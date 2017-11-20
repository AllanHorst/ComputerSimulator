<template>
  <div class="computer-simulator">
    <h1>Welcome to the Computer Simulator</h1>
    <p>Choose the size of your stack and generate a new computer</p>

    <div class="container">
      <div class="input-field">
        <input type="number" placeholder="Stack's Size" v-model="stackSize">
        <button class="btn primary" v-on:click="createComputer()">Create Computer</button>
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
      computerId: null
    }
  },
  methods: {
    createComputer() {
      this.$http.post(URL, {stack: this.stackSize}).then(data => {
        console.log(data)
        this.computerId = data.body.id
      })
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
