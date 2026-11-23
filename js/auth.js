// Controle de acesso demonstrativo (somente front-end).
// Em produção, autenticação e permissões devem ser validadas no servidor.
(function () {
  const pagina = location.pathname.split('/').pop() || 'index.html';
  const usuario = JSON.parse(sessionStorage.getItem('bibliotecolandia_sessao') || 'null');
  const paginasFuncionario = ['index.html', 'cadastro.html', 'cadastro_livro.html', 'operacoes.html', 'retirada_livro.html', 'devolucao.html', 'doacao.html'];
  
  if (pagina !== 'login.html') {
    if (!usuario) { location.replace('login.html'); return; }
    if (paginasFuncionario.includes(pagina) && usuario.tipo !== 'funcionario') { location.replace('catalogo.html'); return; }
    document.addEventListener('DOMContentLoaded', () => {
      const nav = document.querySelector('.Cabecalho nav');
      
      if (nav) { const sair = document.createElement('button'); 
        sair.type = 'button'; 
        sair.className = 'BotaoVoltar'; 
        sair.textContent = 'Sair'; 
        sair.onclick = () => { sessionStorage.removeItem('bibliotecolandia_sessao'); 
          location.replace('login.html'); }; 
          nav.appendChild(sair); }

      const h = document.querySelector('.Cabecalho');
      
      if (h) { const info = document.createElement('span'); info.className = 'usuario-logado'; 
        info.textContent = `${usuario.nome} — ${usuario.tipo === 'funcionario' ? 'Funcionário' : 'Cliente'}`; 
        h.appendChild(info); 
      }
    });
  }
})();

function realizarLogin(event) {
  event.preventDefault();
  const identificador = document.getElementById('identificador').value.trim().toLowerCase();
  const senha = document.getElementById('senhaLogin').value;
  const resultado = document.getElementById('resultadoLogin');
  // Credencial de demonstração: altere e implemente validação no backend antes de publicar.
  if (identificador === 'funcionario@biblioteca.com' && senha === 'admin123') {
    sessionStorage.setItem('bibliotecolandia_sessao', JSON.stringify({ nome: 'Funcionário', tipo: 'funcionario' }));
    location.href = 'index.html'; return;
  }
  const base = [{ nome: 'João', email: 'joao@email.com', senha: '123456' }, { nome: 'Maria', email: 'maria@email.com', senha: 'abcdef' }];
  const cadastrados = JSON.parse(localStorage.getItem('bibliotecolandia_clientes') || '[]');
  const cliente = [...base, ...cadastrados].find(c => c.email.toLowerCase() === identificador && c.senha === senha);
  if (cliente) { sessionStorage.setItem('bibliotecolandia_sessao', JSON.stringify({ nome: cliente.nome, tipo: 'cliente' })); location.href = 'catalogo.html'; return; }
  resultado.textContent = 'E-mail ou senha incorretos.';
}
