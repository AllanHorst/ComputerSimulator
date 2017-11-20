<template>
  <div class="computer-simulator">
    <h1>Welcome to the Computer Simulator</h1>
    <p>Choose the size of your stack and generate a new computer</p>

    <div class="container">
      <input type="number" placeholder="Stack's Size" v-model="stackSize">
      <button class="btn primary" v-on:click="createComputer()">Create Computer</button>

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
            <button class="btn primary" v-on:click="addToStack()">Create Computer</button>
          </li>

          <li v-for="(item, index) in stack.slice().reverse()" v-bind:key="index">
            <span class="address">{{index}}</span>
            <span class="instruction">{{item.instruction}}</span>
            <span class="param">{{item.param}}</span>
          </li>
        </ul>
      </div>
    </div>

  </div>
</template>

<script>
// URL = 'https://computer-simulator-api.herokuapp.com/v1/computers/'
URL = 'http://localhost:3000/v1/computers/'
export default {
  name: 'computer-simulator',
  data () {
    return {
      stackSize: '',
      computerId: null,
      stack: [],
      stackItem: {},
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
      })
    }
  },
  filters: {
    reverse (value) {
      console.log('so loko')
      return value.slice().reverse()
    }
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
</style>
