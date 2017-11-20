<template>
  <div class="computer-simulator">
    <h1>Welcome to the Computer Simulator</h1>
    <p>Choose the size of your stack and generate a new computer</p>

    <div class="container">

      <div v-if="computerId == null">
        <input type="number" placeholder="Stack's Size" v-model="stackSize">
        <button class="btn primary" v-on:click="createComputer()">Create Computer</button>
      </div>

      <div class="list" v-if="computerId != null">
        <ul>
          <li class="new">
            <label for="instruction">Instruction</label>
            <select id="instruction" v-model="stackItem.instruction">
              <option v-bind:value="instruction" v-for="(instruction, index) in instructions" v-bind:key="index">
                {{instruction.name}}
              </option>
            </select>
            <input type="number"
              placeholder="Param"
              v-model="stackItem.arg"
              v-bind:disabled="!stackItem.instruction || !stackItem.instruction.param">
            <button class="btn default" v-on:click="addToStack()">Add</button>
          </li>

          <li v-for="(item, index) in stack.slice().reverse()" v-bind:key="index">
            <span class="address">{{index}}</span>
            <span class="instruction">{{item.instruction}}</span>
            <span class="param">{{item.param}}</span>
          </li>
        </ul>

        <h4>Current Address: {{currentPointer}}</h4>
        <input type="number" placeholder="New Address" v-model="newAddress">
        <button class="btn default" v-on:click="setAddress()">Set Address</button>
        <button class="btn primary" v-on:click="execute()">Execute Program</button>

      </div>

      <div class="results" v-if="results.length > 0">
        <h2>Results</h2>
        <ul>
          <li v-for="(item, index) in results" v-bind:key="index">
            <span>{{item}}</span>
          </li>
        </ul>
      </div>
    </div>


  </div>
</template>

<script>
URL = process.env.NODE_ENV == 'development' ? 'http://localhost:3000/v1/computers/' : 'https://computer-simulator-api.herokuapp.com/v1/computers/'
export default {
  name: 'computer-simulator',
  data () {
    return {
      currentPointer: null,
      newAddress: null,
      stackSize: '',
      computerId: null,
      stack: [],
      stackItem: {},
      results: [],
      instructions: [
        {
          name: 'PUSH',
          param: true
        },
        {
          name: 'MULT',
          param: false
        },
        {
          name: 'RET',
          param: false
        },
        {
          name: 'PRINT',
          param: false
        },
        {
          name: 'CALL',
          param: true
        },
        {
          name: 'STOP',
          param: false
        }]
    }
  },
  methods: {
    createComputer() {
      this.$http.post(URL, {stack: this.stackSize}).then(data => {
        this.computerId = data.body.id
        this.currentPointer = data.body.pointer
      })
    },
    addToStack() {
      let obj = {
        arg: this.stackItem.arg
      }
      this.$http.post(URL + `${this.computerId}/stack/insert/${this.stackItem.instruction.name}`, {arg: this.stackItem.arg}).then(data => {
          this.stack = data.body.stack.map( item => {
            if (!item) {
              return {}
            }
            return JSON.parse(item)
          })
          this.stackItem = {}
          this.currentPointer = data.body.pointer
      })
    },
    setAddress() {
      this.$http.patch(URL + `${this.computerId}/stack/pointer`, {addr: this.newAddress}).then(data => {
        this.currentPointer = data.body.pointer
        this.newAddress = null
      })
    },
    execute() {
      this.$http.post(URL + `${this.computerId}/exec`).then(data => {
        this.results = data.body
      })
    }
  },
  mounted() {
    this.stackItem.instruction = this.instructions[0]
  }

}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  h1, p {
    text-align: center;
  }

  .container {
    padding: 5%;
  }

  li {
    list-style: none;
  }
</style>
