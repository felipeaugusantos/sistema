unit Autoatendimento.ConsultaPreco.View.BuscarPreco;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Types, FMX.Controls,
  FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Effects, FMX.Media, FMX.TabControl, FMX.Ani, FMX.ListBox, FMX.Edit,
  Autoatendimento.ConsultaPreco.Interfaces, FMX.Filter.Effects, System.Actions, FMX.ActnList, DateUtils,
  FMX.ScrollBox, FMX.Memo, StrUtils, AVPlayer;

Type
  TTipoCartao = (opcDebito, opcCredito);

type
  TfmxBuscarPreco = class(TForm)
    memProdutos: TMemo;
    memErros: TMemo;
    edtCodigoBarras: TEdit;
    btnBuscar: TButton;
    imgProduto: TImage;
    procedure btnBuscarClick(Sender: TObject);
  private
    { Private declarations }
    FConsultaPreco: IAutoatendimentoConsultaPreco;
    procedure MostraMensagem(AMsg, ATipo: String);
    procedure AddInformacoesEmbalagem(Produto: IAutoatendimentoConsultaProduto);
    procedure AddDadosTecnicos(Produto: IAutoatendimentoConsultaProduto);
    procedure AddProdutosSimilares(Produto: IAutoatendimentoConsultaProduto);
    procedure AddProdutosAgregados(Produto: IAutoatendimentoConsultaProduto);
  public
    { Public declarations }
    procedure OnMensagemAoUsuario(AMsg: String);
    procedure OnMensagemDeErro(AMsg: String);
    procedure OnMensagemAguarde(AMsg: String);
  published
    property ConsultaPreco: IAutoatendimentoConsultaPreco Read FConsultaPreco write FConsultaPreco;
  end;

var
  fmxBuscarPreco: TfmxBuscarPreco;

implementation

Uses IOUtils;

{$R *.fmx}

procedure TfmxBuscarPreco.OnMensagemAguarde(AMsg: String);
begin
  MostraMensagem(AMsg, 'Aguarde');
end;

procedure TfmxBuscarPreco.OnMensagemAoUsuario(AMsg: String);
begin
  MostraMensagem(AMsg, 'Ao usuário');
end;

procedure TfmxBuscarPreco.OnMensagemDeErro(AMsg: String);
begin
  MostraMensagem(AMsg, 'Erro');
end;

procedure TfmxBuscarPreco.AddDadosTecnicos(
  Produto: IAutoatendimentoConsultaProduto);
Var
  LAtributo: IAutoatendimentoConsultaAtributos;
  LGrupo: String;
begin
  If Produto.DadosTecnicos.Count > 0 Then
  Begin
    memProdutos.Lines.Add('----------------------------------------------------');
    memProdutos.Lines.Add('Dados Técnicos');
    memProdutos.Lines.Add('----------------------------------------------------');

    For LAtributo In Produto.DadosTecnicos Do
    Begin
      If LGrupo <> LAtributo.Grupo Then
        memProdutos.Lines.Add(' - ' + LAtributo.Grupo);

      memProdutos.Lines.Add('   - ' + LAtributo.Descricao + ': ' + LAtributo.Valor);

      LGrupo := LAtributo.Grupo;
    End;
  End;
end;

procedure TfmxBuscarPreco.AddInformacoesEmbalagem(
  Produto: IAutoatendimentoConsultaProduto);
begin
  If Produto.EmbalagemFechada Then
  Begin
    memProdutos.Lines.Add('Embalagem com ' + Produto.QuantidadeEmbalagem.ToString() + ' ' + Produto.UnidadeVenda);
    memProdutos.Lines.Add('por apenas R$ ' + Produto.PrecoVenda.ToString());
  End
  Else
    memProdutos.Lines.Add('Cada ' + Produto.UnidadeVenda + ' por apenas R$ ' + Produto.PrecoVenda.ToString());
end;

procedure TfmxBuscarPreco.AddProdutosAgregados(
  Produto: IAutoatendimentoConsultaProduto);
Var
  LAgregado: IAutoatendimentoConsultaProduto;
begin
  If Produto.ProdutosAgregados.Count > 0 Then
  Begin
    memProdutos.Lines.Add('----------------------------------------------------');
    memProdutos.Lines.Add('Comprar junto');
    memProdutos.Lines.Add('----------------------------------------------------');

    For LAgregado In Produto.ProdutosAgregados Do
    Begin
      Try
        memProdutos.Lines.Add('');
        memProdutos.Lines.Add(LAgregado.Descricao);
        memProdutos.Lines.Add('R$ ' + LAgregado.PrecoVenda.ToString() + ' ' + LAgregado.UnidadeVenda);
        memProdutos.Lines.Add(LAgregado.TextoAdicionalPreco);
        // LAgregado.PathImagemPrincipal para utilizar a imagem
      Except
        On E: Exception Do
          MostraMensagem(E.Message, 'Erro');
      End;
    End;
  End;
end;

procedure TfmxBuscarPreco.AddProdutosSimilares(
  Produto: IAutoatendimentoConsultaProduto);
Var
  LSimilar: IAutoatendimentoConsultaProduto;
begin
  If Produto.ProdutosSimilares.Count > 0 Then
  Begin
    memProdutos.Lines.Add('----------------------------------------------------');
    memProdutos.Lines.Add('Produtos similares');
    memProdutos.Lines.Add('----------------------------------------------------');

    For LSimilar In Produto.ProdutosSimilares Do
    Begin
      Try
        memProdutos.Lines.Add('');
        memProdutos.Lines.Add(LSimilar.Descricao);

        If LSimilar.DetalhesUtilizacao <> '' Then
          memProdutos.Lines.Add(LSimilar.DetalhesUtilizacao);

        memProdutos.Lines.Add('R$ ' + LSimilar.PrecoVenda.ToString() + ' ' + LSimilar.UnidadeVenda);
        memProdutos.Lines.Add(LSimilar.TextoAdicionalPreco);
        // LSimilar.PathImagemPrincipal para utilizar a imagem
      Except
        On E: Exception Do
          MostraMensagem(E.Message, 'Erro');
      End;
    End;
  End;
end;

procedure TfmxBuscarPreco.btnBuscarClick(Sender: TObject);
Var
  LProduto: IAutoatendimentoConsultaProduto;
begin
  imgProduto.Visible := False;
  memErros.Lines.Clear;
  memProdutos.Lines.Clear;

  Try
    //Utilizar para retornar o logo da empresa
    //FConsultaPreco.PathLogotipoEmpresa;

    LProduto := FConsultaPreco.Consultar(edtCodigoBarras.Text);

    memProdutos.Lines.Add('----------------------------------------------------');

    memProdutos.Lines.Add(LProduto.Descricao);

    AddInformacoesEmbalagem(LProduto);

    If LProduto.EmPromocao Then
      memProdutos.Lines.Add('*** EM PROMOÇÃO ***');

    memProdutos.Lines.Add(LProduto.TextoAdicionalPreco);

    If Not LProduto.PathImagemPrincipal.IsEmpty And FileExists(LProduto.PathImagemPrincipal) Then
    Begin
      imgProduto.Visible := True;
      imgProduto.Bitmap.LoadFromFile(LProduto.PathImagemPrincipal);
    End;

    If Not LProduto.PathVideoApresentacao.IsEmpty And FileExists(LProduto.PathVideoApresentacao) Then
    Begin
      // aqui implementar player de video
    End;

    AddDadosTecnicos(LProduto);

    AddProdutosSimilares(LProduto);

    AddProdutosAgregados(LProduto);

    memProdutos.Lines.Add('----------------------------------------------------');

  Except
    On E: Exception Do
      MostraMensagem(E.Message, 'Erro');
  End;
end;

procedure TfmxBuscarPreco.MostraMensagem(AMsg, ATipo: String);
begin
  memErros.Lines.Add(ATipo + ': ' + AMsg);
end;

end.
