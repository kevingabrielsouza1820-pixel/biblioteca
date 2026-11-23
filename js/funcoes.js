/**
 * @param {number} diasAtraso 
 * @returns {number}
 */
function calcularMulta(diasAtraso) {
    if (diasAtraso > 0) {
      return diasAtraso * 1.5;
    } else {
      return 0;
    }
  }
  
  /**
   * @param {object} livro
   * @returns {boolean}
   */
  function verificarDisponibilidade(livro) {
    if (livro.situacao === "DISPONÍVEL") {
      return true;
    } else {
      return false;
    }
  }
  
  /**
   * @param {object[]} livros
   * @param {string} nome
   * @returns {object|null}
   */
  function buscarLivroPorNome(livros, nome) {
    let livroEncontrado = null;
  
    livros.forEach(function (livro) {
      if (livro.titulo.toLowerCase() === nome.trim().toLowerCase()) {
        livroEncontrado = livro;
      }
    });
  
    return livroEncontrado;
  }
  
  /**

   * @param {object[]} usuarios
   * @param {string} nome
   * @returns {object|null}
   */
  function buscarUsuarioPorNome(usuarios, nome) {
    let usuarioEncontrado = null;
  
    usuarios.forEach(function (usuario) {
      if (usuario.nome.toLowerCase() === nome.trim().toLowerCase()) {
        usuarioEncontrado = usuario;
      }
    });
  
    return usuarioEncontrado;
  }
  
  /**
  
   * @param {number} idUsuario
   * @param {object[]} retiradas
   * @returns {boolean}
   */
  function verificarRetiradaAtiva(idUsuario, retiradas) {
    let possuiRetirada = false;
  
    retiradas.forEach(function (retirada) {
      if (retirada.idUsuario === idUsuario && retirada.situacao === "ATIVA") {
        possuiRetirada = true;
      }
    });
  
    return possuiRetirada;
  }
  
  /**

   * @param {object[]} livros
   * @returns {object[]}
   */
  function listarLivrosDisponiveis(livros) {
    const livrosDisponiveis = [];
  
    livros.forEach(function (livro) {
      if (livro.situacao === "DISPONÍVEL") {
        livrosDisponiveis.push(livro);
      }
    });
  
    return livrosDisponiveis;
  }
  
  /**
   * @param {object[]} livros
   * @param {string} termo
   * @returns {object[]}
   */
  function filtrarLivrosPorTermo(livros, termo) {
    const livrosFiltrados = [];
    const termoMinusculo = termo.trim().toLowerCase();
  
    livros.forEach(function (livro) {
      if (
        livro.titulo.toLowerCase().includes(termoMinusculo) ||
        livro.autor.toLowerCase().includes(termoMinusculo)
      ) {
        livrosFiltrados.push(livro);
      }
    });
  
    return livrosFiltrados;
  }
  
  /**
   * @param {object[]} lista
   * @returns {number}
   */
  function gerarProximoId(lista) {
    let maiorId = 0;
  
    lista.forEach(function (item) {
      if (item.id > maiorId) {
        maiorId = item.id;
      }
    });
  
    return maiorId + 1;
  }
  
  /**
   * @param {string} nome
   * @param {string} senha
   * @param {object[]} usuarios
   * @returns {{valido: boolean, mensagem: string}}
   */
  function validarCadastroUsuario(nome, senha, usuarios) {
    if (nome.trim() === "") {
      return { valido: false, mensagem: "Informe o nome de usuário." };
    } else if (senha.length < 6) {
      return {
        valido: false,
        mensagem: "A senha deve ter pelo menos 6 caracteres.",
      };
    } else if (buscarUsuarioPorNome(usuarios, nome) !== null) {
      return { valido: false, mensagem: "Esse usuário já está cadastrado." };
    } else {
      return { valido: true, mensagem: "Usuário cadastrado com sucesso!" };
    }
  }
  
  /**
   * @param {string} titulo
   * @param {string} autor
   * @param {string} categoria
   * @param {object[]} livros
   * @returns {{valido: boolean, mensagem: string}}
   */
  function validarCadastroLivro(titulo, autor, categoria, livros) {
    if (titulo.trim() === "" || autor.trim() === "" || categoria.trim() === "") {
      return { valido: false, mensagem: "Preencha título, autor e categoria." };
    } else if (buscarLivroPorNome(livros, titulo) !== null) {
      return { valido: false, mensagem: "Esse livro já está cadastrado." };
    } else {
      return { valido: true, mensagem: "Livro cadastrado com sucesso!" };
    }
  }
  
  /**
   * @param {object|null} usuario
   * @param {object|null} livro
   * @param {object[]} retiradas
   * @returns {{permitido: boolean, mensagem: string}}
   */
  function verificarRetirada(usuario, livro, retiradas) {
    if (usuario === null) {
      return { permitido: false, mensagem: "Usuário não encontrado." };
    } else if (livro === null) {
      return { permitido: false, mensagem: "Livro não encontrado." };
    } else if (usuario.carteirinha !== "ATIVA") {
      return {
        permitido: false,
        mensagem: "Carteirinha bloqueada: retirada negada.",
      };
    } else if (!verificarDisponibilidade(livro)) {
      return {
        permitido: false,
        mensagem: "Livro indisponível: já está emprestado.",
      };
    } else if (verificarRetiradaAtiva(usuario.id, retiradas)) {
      return {
        permitido: false,
        mensagem: "O usuário já possui uma retirada ativa.",
      };
    } else {
      return { permitido: true, mensagem: "Retirada realizada com sucesso!" };
    }
  }
  
  /**
   * @param {number} idUsuario
   * @param {number} idLivro
   * @param {object[]} retiradas
   * @returns {object|null}
   */
  function buscarRetiradaAtiva(idUsuario, idLivro, retiradas) {
    let retiradaEncontrada = null;
  
    retiradas.forEach(function (retirada) {
      if (
        retirada.idUsuario === idUsuario &&
        retirada.idLivro === idLivro &&
        retirada.situacao === "ATIVA"
      ) {
        retiradaEncontrada = retirada;
      }
    });
  
    return retiradaEncontrada;
  }
  
  /**
   * @param {object[]} livros
   * @returns {{disponiveis: number, emprestados: number}}
   */
  function contarLivrosPorSituacao(livros) {
    const totais = { disponiveis: 0, emprestados: 0 };
  
    livros.forEach(function (livro) {
      if (livro.situacao === "DISPONÍVEL") {
        totais.disponiveis++;
      } else {
        totais.emprestados++;
      }
    });
  
    return totais;
  }