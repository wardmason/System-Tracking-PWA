<script setup>
import { ref, onMounted } from 'vue'

const users = ref([])

onMounted(async () => {
  const response = await fetch('http://127.0.0.1:8000/users')
  users.value = await response.json()
})
</script>

<template>
  <div>
    <h1>Users</h1>

    <ul>
      <li v-for="user in users" :key="user.id">
        {{ user.username }}
      </li>
    </ul>
  </div>
</template>