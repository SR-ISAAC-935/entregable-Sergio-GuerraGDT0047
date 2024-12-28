const express= require('express')
const port=3000;
const cors = require('cors');
const cookieParser = require('cookie-parser');
const HomeRoutes= require('./Routes/HomeRoutes')
const authRoutes= require('./Routes/AuthRoutes')
const adminRoutes = require('./Routes/adminRoutes')
const app = express();
// CORS configuration
app.use(cors({
    credentials: true,
    origin: process.env.PATHRENDER || '*',
    methods: ['GET', 'POST']
}));

app.use(express.json())
app.use(cookieParser())
app.use('/auth',authRoutes )
app.use('/',HomeRoutes )
app.use('/admin', adminRoutes)
app.listen(port,()=>{
    console.log(`transmitiendo en http://localhost:${port}`);
})