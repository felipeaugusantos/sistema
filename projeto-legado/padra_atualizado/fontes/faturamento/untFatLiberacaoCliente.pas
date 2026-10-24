unit untFatLiberacaoCliente;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  EditFocus, DateUtils, untFuncoesSimples, Menus, StrUtils, System.UITypes,
  AppEvnts, BitBtnLockedIncrem, UniClientDataSet, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, untRedeLojas, untConstantes, untMsgLiberacao,
  untLiberacao, dxGDIPlusClasses;

type
  TfrmFatLiberacaoCliente = class(TfrmPaiSimples)
    lsvMotivos: TListView;
    pnlRodape: TPanel;
    btnDebitos: TBitBtnLocked;
    btnObsCli: TBitBtnLocked;
    btnTravasMinimas: TBitBtnLocked;
    pnlCabecalho: TPanel;
    edtNumLib: TEditFocus;
    edtSenLib: TEditFocus;
    lblNumLib: TLabel;
    lblSenLib: TLabel;
    btnLibera: TSpeedButton;
    btnTipSenha: TSpeedButton;
    edtTraTel: TEditFocus;
    btnInfCobr: TBitBtnLocked;
    btnVendasPorCliente: TBitBtnLocked;
    btnConCre: TBitBtnLocked;
    imgAnalise: TImage;
    lblAnalise: TLabel;
    lblAnalisePor: TLabel;
    imgAguardando: TImage;
    lblAguardando: TLabel;
    FlwPnlRodape: TFlowPanel;
    lblSenLibMaster: TLabel;
    btnAnlAnalitica: TBitBtnLocked;
    pnlDirAcesso: TPanel;
    lblDescricaoDireitoDeAcesso: TLabel;
    btnOperadorAcesso: TSpeedButton;
    btnEnvMensagem: TBitBtnLocked;
    pnlMensagens: TPanel;
    pnlShapeQtdMsgPen: TPanel;
    lblQtdMsg: TLabel;
    shpQtdMsg: TShape;
    btnMensagens: TBitBtnLocked;
    lblOpeSemAce: TLabel;
    btnProdPreMin: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure lsvMotivosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDebitosClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure tmrLiberaTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLiberaClick(Sender: TObject);
    procedure btnObsCliClick(Sender: TObject);
    procedure btnTipSenhaClick(Sender: TObject);
    procedure btnTravasMinimasClick(Sender: TObject);
    procedure lsvMotivosCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btnInfCobrClick(Sender: TObject);
    procedure lsvMotivosSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnVendasPorClienteClick(Sender: TObject);
    procedure btnConCreClick(Sender: TObject);
    procedure btnAnlAnaliticaClick(Sender: TObject);
    procedure lblDescricaoDireitoDeAcessoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOperadorAcessoClick(Sender: TObject);
    procedure btnEnvMensagemClick(Sender: TObject);
    procedure btnMensagensClick(Sender: TObject);
    procedure btnProdPreMinClick(Sender: TObject);
  private
    { Private declarations }
    blnFecharF: Boolean;
    stlInformacao: TStringList;
    strJustTemp  : String;
    strXmlCds: String;
    blnUsaDig : Boolean;
    horaLogVar: TDateTime;
    horaLogEnv: TDateTime;
    horaLogCad: TDateTime;
    FstrOperadorOriginal : String;
    strCodigoLiberacaoLogVar: String;
    function fGetIndexTrava(blnConsiderarAComissaoDoProfissionalEOValorDoFreteNaTravaDePreco : Boolean = False;
      blnEhTravaItemAItemFinalVenda: Boolean = False): Integer;
    function fGetIndexTravaAux: Integer;
    function fMsgLiberacaoJaLida(var strMsgLib: String; strOpeLibRef: String = ''): Boolean;
    function fEnviaMsgLiberacao: Boolean;
    procedure pApagarMsgLiberacao;
    function fRetornaFanCliente(strCodCli: String): String;
    procedure pMostraConsultaCredito;
    procedure pAbrirDireitoDeAcesso;
    procedure pVendasPorCliente(strCodCli : String; strNomCli : String = '');
    procedure pMostrarStatusEmAnalise(blnMostrar : Boolean);
    procedure pMostrarStatusAguardando(blnMostrar : Boolean);
    function fMsgLiberacaoJaAnalisando(var strOpeAnalise: String) : Boolean;
    procedure pLiberacaoMaster;
    function fSolicLiberacaoAnaliseAnalitica: Boolean;
    function ValidarPermissaoAcesso: Boolean;
    function fGetEmpLib: String;
    function fGetSqlLiberacao: String;
    function fExisteOperadorComAcessoLibRemota: Boolean;
    function fPosicaoNivel(strMenu: String): Integer;
    procedure pSetarVisibilidadeQtdMsgNaoLida(const intQtdMsg : Integer);
    procedure pAtualizarBotaoMensagens(Sender : TObject);
    procedure pMandaMensagemLiberacaoValorMinimoPorItem;
    procedure pSalvaProdutosTravaPreco(strNumLib: String);
    procedure pMostraProdutosTravaPreco;
  protected
    function TimerLibera: TNewTimer;
    function TimerBotaoMsg : TNewTimer;
    procedure RemoveTimerLibera;
    procedure RemoveTimerBotaoMsg;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    objLiberacao : TLiberacao;
    strMotivos  : String;
    strCaption  : String;
    strOpeEnv   : String;
    strMenObs   : String;
    strDirAce   : String;
    strDirAceAuxiliar : String;
    blnTraTel   : Boolean;
    strCodOpe   : String;
    strMsgSen   : String;
    strCodDig   : String;
    strCodCli   : String;
    blnConfirma : Boolean;
    blnSenLib   : Boolean;
    strCodIte   : String;
    intAutInc   : Integer;
    strNumLib   : String;
    strOperador : String;

    strDirAceNv2: String;
    strDirAceNv3: String;
    strDirAceNv4: String;
    strDirAceNv5: String;
    strDirAceNv6: String;

    blnNivel2   : Boolean;
    blnNivel3   : Boolean;
    blnNivel4   : Boolean;
    blnNivel5   : Boolean;
    blnNivel6   : Boolean;

    strSenFvu   : String;
    cdsXmlTra   : TUniClientDataSet;
    blnTelaResumida : Boolean;
    blnIgnInc   : Boolean;
    strAssuntoTit: String;
    tipCliFor   : TClienteFornecedor;
    blnManterCompatibilidadeSenCfg : Boolean;
    strSenLib : String;
    intQuantidadeLinhas: Integer;
    blnLimitaQuantidadeDuplicata:Boolean;

    blnSempreVariavelUsuario: Boolean;
    arrHinLin: TStringArray;
    cdsXmlF4 : TUniClientDataSet;
    cdsVenda : TUniClientDataSet;
    cdsTravaProdMin : TUniClientDataSet;

    procedure pPreparaDados;

  end;


implementation

uses untFuncFat,untFuncoes, untMsgInterna, untFatMostraObsCliente,
     untFatMostraTravaMinimaHelper, untLogVar, Data.DB, untInfCobranca,
     untCadMsg, untMostraDadosCobranca, untRelFatVendasCliente, untCadClientes,
     untMemo, untPermissaoAcesso, untFuncoesGenerica, untCadMsgEnv, untFatTravaProdPreco;

{$R *.dfm}

{ TfrmFatLiberacaoCliente }

function TfrmFatLiberacaoCliente.fRetornaFanCliente(strCodCli: String): String;
  var
    qryRedeLoja : TUniQuery;
begin
  try
    // RETORNA FANTASIA/SOBRENOME ( REDE DE LOJA QUE O CLIENTE É VINCULADO)
    Result := '';

    if (fEmptyStr(strCodcli)) then
      Exit;

    qryRedeLoja := fCriaQuery;

    With QryRedeLoja do
    begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT     ');
      Sql.Add('CLI_FANSOB ');
      Sql.Add('FROM       ');
      Sql.Add('CADCLI     ');
      Sql.Add('WHERE      ');
      Sql.Add('CLI_CODCLI = :CODCLI ');
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
    end;

    if ( Not qryRedeLoja.IsEmpty ) then
    begin
      Result := qryRedeLoja.fieldByName('CLI_FANSOB').AsString;
    end
    else
      Result := '';
  finally
    FreeAndNil(qryRedeLoja);
  end;
end;

function TfrmFatLiberacaoCliente.fSolicLiberacaoAnaliseAnalitica: Boolean;
  Var
    objLiberacao: TLiberacao;
begin
  objLiberacao := TLiberacao.Create;
  Try
    objLiberacao.strDirAce := 'TRDESANA';
    objLiberacao.strMsgSen := 'Análise Analítica dos Produtos';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    objLiberacao.objMsgLibera.pAddSeparador;
    objLiberacao.objMsgLibera.pAddTexto('TRAVA DE DESCONTO - REALIZAR ANÁLISE ANALÍTICA DOS PRODUTOS', alCentro);
    objLiberacao.objMsgLibera.pAddSeparador;
   // objLiberacao.objMsgLibera.pAddTexto('Número Liberação: '+ edtNumLib.Text); //removido pois estava causando confusão no cliente
    objLiberacao.objMsgLibera.pAddTexto('Motivo bloqueio : '+ lsvMotivos.Items[0].Caption);
    objLiberacao.objMsgLibera.pAddTexto('Operador        : '+ IIF(blnUsaDig, strCodDig, strCodOpe) +'-'+ fRetNomVendRep(IIF(blnUsaDig, strCodDig, strCodOpe)));
    objLiberacao.objMsgLibera.pAddTexto('Cliente         : '+ strCodCli +'-'+ fRetNomCliente(strCodCli));

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

procedure TfrmFatLiberacaoCliente.pMandaMensagemLiberacaoValorMinimoPorItem;
var
  strDirAceLocal: String;
begin
  strDirAceLocal := Copy(strDirAce, 1, 5);
  if (Pos(strDirAceLocal, 'PRMIN_VEMIN_') > 0) then
  begin
    pSalvaProdutosTravaPreco(edtNumLib.Text);
    Exit;
  end;
end;

procedure TfrmFatLiberacaoCliente.pMostraConsultaCredito;
begin

  Try

    pCriarFormularios(TfrmMostraDadosCobranca, frmMostraDadosCobranca);
    frmMostraDadosCobranca.strCodCli := strCodCli;
    frmMostraDadosCobranca.ShowModal;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[frmFatLiberacaoCliente.pMostraConsultaCredito]');
  End;

  pFreeAndNil(frmMostraDadosCobranca);

end;

procedure TfrmFatLiberacaoCliente.pMostraProdutosTravaPreco;
const
  MENSAGEM = 'Não há retorno da solicitação.';
var
  frmFatTravaProdPreco: TfrmFatTravaProdPreco;
begin
  If fEmptyStr(edtNumLib.Text) Then
  begin
    pMensagemOk(MENSAGEM);
    Exit;
  end;

  if fCampoTabela('GER_NUMLIB','TPMGER',['GER_NUMLIB'],[edtNumLib.Text]) <> edtNumLib.Text then
  begin
    pMensagemOk(MENSAGEM);
    Exit;
  end;

  if fCampoTabela('GER_RESPON','TPMGER',['GER_NUMLIB'],[edtNumLib.Text]) <> 'S' then
  begin
    pMensagemOk(MENSAGEM);
    Exit;
  end;

  pCriarFormularios(TfrmFatTravaProdPreco, frmFatTravaProdPreco);

  try
    frmFatTravaProdPreco.NumLib := edtNumLib.Text;
    frmFatTravaProdPreco.ApenaVisualizacao := True;
    frmFatTravaProdPreco.ShowModal;
    pCloneDataSet(cdsTravaProdMin, frmFatTravaProdPreco.cdsProdutos);
  finally
    pFreeAndNil(frmFatTravaProdPreco);
  end;
end;

procedure TfrmFatLiberacaoCliente.pMostrarStatusAguardando(blnMostrar: Boolean);
begin
  imgAguardando.Visible := blnMostrar;
  lblAguardando.Visible := blnMostrar;

  {Posicionar a frente do [F8]}
  imgAguardando.Top := imgAnalise.Top;
  lblAguardando.Top := imgAnalise.Top;
end;

procedure TfrmFatLiberacaoCliente.pMostrarStatusEmAnalise(blnMostrar: Boolean);
begin
  imgAnalise.Visible    := blnMostrar;
  lblAnalise.Visible    := blnMostrar;
  lblAnalisePor.Visible := blnMostrar;
end;

procedure TfrmFatLiberacaoCliente.pPreparaDados;
  Var
    intContador  : Integer;
    intIndexTrava: Integer;
    intIndexTravaAux: Integer;
    strTipLib    : String;
    strInfOrig   : String;
    strFanRedeLoja : String;
    strRedeLoja: String;
    stlMensagem  : TStringList;
    strExpressaoTroca: string;
    strMensagem: string;
    strTotGer: string;
    intPosicaoNivel : Integer;

begin
  intPosicaoNivel := 0;

  if Assigned(objLiberacao) then
  begin
    strCaption               := objLiberacao.strCaption;
    strOpeEnv                := objLiberacao.strOpeEnv;
    strDirAce                := objLiberacao.strDirAce;
    strDirAceAuxiliar        := objLiberacao.strDirAceAuxiliar;
    blnTraTel                := objLiberacao.blnTraTel;
    strCodOpe                := objLiberacao.strCodOpe;
    strOperador              := objLiberacao.strCodOpe;
    FstrOperadorOriginal     := objLiberacao.strCodOpe;
    strCodDig                := objLiberacao.strCodDig;
    strCodCli                := LeftStr(objLiberacao.strCliente,8);
    strCodIte                := objLiberacao.strCodIte;
    intAutInc                := objLiberacao.intAutInc;
    blnSempreVariavelUsuario := objLiberacao.blnSempreVariavelUsuario;
    cdsXmlTra                := objLiberacao.cdsXmlTra;
    cdsXmlF4                 := objLiberacao.cdsXmlF4;
    blnTelaResumida          := objLiberacao.blnTelaResumida;
    blnIgnInc                := objLiberacao.blnIgnInc;
    strAssuntoTit            := objLiberacao.objMsgLibera.strTitulo;
    tipCliFor                := objLiberacao.tipCliFor;

    strDirAceNv2             := objLiberacao.strDirAceNv2;
    blnNivel2                := objLiberacao.blnNivel2;

    strDirAceNv3             := objLiberacao.strDirAceNv3;
    blnNivel3                := objLiberacao.blnNivel3;

    strDirAceNv4             := objLiberacao.strDirAceNv4;
    blnNivel4                := objLiberacao.blnNivel4;

    strDirAceNv5             := objLiberacao.strDirAceNv5;
    blnNivel5                := objLiberacao.blnNivel5;

    strDirAceNv6             := objLiberacao.strDirAceNv6;
    blnNivel6                := objLiberacao.blnNivel6;

    strMsgSen                := objLiberacao.strMsgSen;
    strSenLib                := objLiberacao.strSenLib;
    blnManterCompatibilidadeSenCfg := objLiberacao.blnManterCompatibilidadeSenCfg;
    strTotGer                := objLiberacao.strTotGer;

    if (fCfgSis('ALTVMT', varString) = 'S') and (fCfgSis('TRAREM', varString) = '1') then
    begin
      cdsVenda := objLiberacao.cdsVenda;
      cdsTravaProdMin := objLiberacao.cdsTravaProdMin;
    end;
  end;


  if blnTelaResumida then
  begin
    Self.Width 	:= 290;
    Self.Height := 247;

    lsvMotivos.Visible 	:= False;
    pnlCabecalho.Align 	:= alClient;

    edtTraTel.Visible := False;

    btnTipSenha.Left  := 18;
    btnTipSenha.Top   := 113;
    btnTipSenha.Width := 246;

    btnLibera.Left  := 18;
    btnLibera.Top   := 135;
    btnLibera.Width := 246;
  end;

  Try
    strTipLib := strDirAce;

    blnFecharF  := False;

    If (strSenFvu = 'V') Then
    Begin
      btnTipSenha.Visible := True;
      edtSenLib.MaxLength := 0;
    End;

    If blnNivel2 Then
      strDirAce := strDirAceNv2;

    If blnNivel3 Then
      strDirAce := strDirAceNv3;

    If blnNivel4 Then
      strDirAce := strDirAceNv4;

    If blnNivel5 Then
      strDirAce := strDirAceNv5;

    If blnNivel6 Then
      strDirAce := strDirAceNv6;

    {**********************************}
    {* PEGA O NRO DA LIBERAÇÃO        *}
    {*******************************JB*}
    edtNumLib.Text := fGeraNumLiberacao(strDirAce);
    strNumLib := edtNumLib.Text;

    stlInformacao := TStringList.Create;
    stlInformacao.Clear;

    objLiberacao.pInformaDadosCliente;

    {***************************************}
    {*   VERIFICA FANTASIA - REDE DE LOJA  *}
    {************************************RL*}
    if (Not fEmptyStr(strCodCli)) then
    begin
      If ( Not fClienteConsumidor(fRetNomCliente(strCodCli), True, True)) Then
      begin
        If tipCliFor = cfFornecedor Then
          strFanRedeLoja  := fRetNomFanFor(strCodCli)
        Else
          strFanRedeLoja := fRetornaFanCliente(strCodCli);

        strRedeLoja := fRetornaRedeLojaCliente(strCodCli);

        if (Not fEmptyStr(strFanRedeLoja)) then
        begin
          if Assigned(objLiberacao) then
            objLiberacao.objMsgLibera.pAddTexto('Nome Fantasia: ' + strFanRedeLoja);
        end;

        if (Not fEmptyStr(strRedeLoja)) and (strTipLib = 'LIMCR') then
        begin
          if Assigned(objLiberacao) then
            objLiberacao.objMsgLibera.pAddTexto('Rede de Lojas: ' + fRetornaRedeLojaCliente(strCodCli));
        end;
      end;
    end;

    if Assigned(objLiberacao) then
    begin
      stlMensagem := TStringList.Create;
      Try
        stlMensagem.Text := objLiberacao.objMsgLibera.fGetMensagem;

        If (fCfgSis('HABREM', varString) = 'N') Then
          stlMensagem.Text := AnsiReplaceStr(stlMensagem.Text, STRING_VALOR_DOCUMENTO, strTotGer);

        if not (fVerificaAcessoSistema('PVISPF')) then
        begin
          while Pos('@(', stlMensagem.Text) > 1 do
          begin
            strExpressaoTroca := Copy(stlMensagem.Text, Pos('@(', stlMensagem.Text), Pos(')@', stlMensagem.Text) - Pos('@(', stlMensagem.Text) + 2);
            stlMensagem.Text := AnsiReplaceStr(stlMensagem.Text, strExpressaoTroca, '*,**');
          end;
        end;

        stlMensagem.Text := fLimpaTagMsgOculta(stlMensagem.Text, omlMsgParaQuemReceb);

        For intContador := 0 To stlMensagem.Count -1 Do
        Begin
          if (Pos(STRING_PROFISSIONAIS_LIBERACAO, stlMensagem[intContador]) > 0) then
            strMensagem := ''
          else
            strMensagem := stlMensagem[intContador];

          lsvMotivos.Items.Add;
          lsvMotivos.Items[intContador].Caption := fTagMsgOcultaToMsgCoringa(strMensagem);

          If Not objLiberacao.blnSomenteMsgRemota Then
            stlInformacao.Add(stlMensagem[intContador]);

          If (intContador = stlMensagem.count -1) And (stlMensagem[0] = MENSAG_CREDIARIO) Then
          Begin
            lsvMotivos.Font.Size  := 11;
            lsvMotivos.Font.Color := clRed;
            lsvMotivos.Font.Style := [fsBold];
            lsvMotivos.Realign;
          End;
        End;
      Finally
        stlMensagem.Destroy;
      End;
    end;

    strInfOrig := stlInformacao.Text;

    {*******************************************}
    {* CASO EXISTA UMA MENSAGEM QUE DEVE SER   *}
    {* EXIBIDA NA TELA DE LIBERACAO DE CLIENTE *}
    {* BLOQUEADO, MAS NAO DEVA SER EXIBIDA AO  *}
    {* OPERADOR. ENTAO GRAVA NO LOGVAR MAS NAO *}
    {* INSERE NA LISTA DE MOTIVOS BLOQUEIO...  *}
    {****************************************JC*}
    If Assigned(objLiberacao) and (not objLiberacao.objMsgRemota.IsEmpty) Then
      stlInformacao.Add(objLiberacao.objMsgRemota.fGetMensagem);

    pRegistraUltimoBloqueio(objLiberacao.objMsgLibera.fGetMensagem,
                            objLiberacao.objMsgRemota.fGetMensagem);

    If blnTraTel Then
    Begin

      If (strTipLib = 'LIBCAN') Then
      Begin
        Caption := 'Liberação de pendências de cancelamento';
        edtTraTel.Text := 'LIBERAÇÃO DE PENDÊNCIAS DE CANCELAMENTO';
      End
      Else If (strTipLib = 'LIBHOR') Then
      Begin
        Caption := 'Liberação de Restrição de Horário';
        edtTraTel.Text := 'RESTRIÇÃO DE HORÁRIO';
      End
      Else If (strTipLib = 'LBSDVN') Then
        edtTraTel.Text := 'SALDO INSUFICIENTE'
      Else If (strTipLib = 'F10TRA') Then
      Begin
        Caption := 'Liberação de Transferência entre Armazéns';
        edtTraTel.Text := 'TRANSFERÊNCIA ENTRE ARMAZÉNS BLOQUEADA';
      End
      Else If (strTipLib = 'TRODIR') Then
        edtTraTel.Text := 'LIBERAÇÃO DE ACESSO PARA TROCA DE BASE'
      Else
        edtTraTel.Text := 'CLIENTE BLOQUEADO';

      If Assigned(objLiberacao) Then
      Begin
        If (Not fEmptyStr(Trim(objLiberacao.strDirAce))) And (Not fEmptyStr(objLiberacao.strSequencialUnicoDtaHra)) Then
          strCodigoLiberacaoLogVar := Trim(objLiberacao.strDirAce) + objLiberacao.strSequencialUnicoDtaHra;
      End;

      fGravaLogVar(strNumLib, stlInformacao.Text, strCodOpe, strCodDig, strCodCli, strCodigoLiberacaoLogVar, cdsXmlTra, cdsXmlF4);
    End
    Else
    Begin
      if not fEmptyStr(strCaption) then
        Caption := strCaption;

      intIndexTrava := fGetIndexTrava(objLiberacao.blnConsiderarAComissaoDoProfissionalEOValorDoFreteNaTravaDePreco,
        objLiberacao.blnEhTravaItemAItemFinalVenda);

      If intIndexTrava = -1 Then
      Begin
        SetLength(arrLogAvi, Succ(Length(arrLogAvi)));
        intIndexTrava := High(arrLogAvi);
      End;

      if blnNivel2 then
        strDirAce := strDirAceNv2;

      if blnNivel3 then
        strDirAce := strDirAceNv3;

      if blnNivel4 then
        strDirAce := strDirAceNv4;

      if blnNivel5 then
        strDirAce := strDirAceNv5;

      if blnNivel6 then
        strDirAce := strDirAceNv6;

      arrLogAvi[intIndexTrava].strMsgSen := strMsgSen;
      arrLogAvi[intIndexTrava].strDirAce := strDirAce;
      arrLogAvi[intIndexTrava].strDirAceAuxiliar := strDirAceAuxiliar;
      arrLogAvi[intIndexTrava].strNumLib := edtNumLib.Text;
      arrLogAvi[intIndexTrava].strInfBlo := strInfOrig;
      arrLogAvi[intIndexTrava].strInfLib := stlInformacao.Text;
      arrLogAvi[intIndexTrava].strMenObs := strMenObs;
      arrLogAvi[intIndexTrava].strCodIte := strCodIte;
      arrLogAvi[intIndexTrava].intAutInc := intAutInc;
      arrLogAvi[intIndexTrava].strCodOpe := strCodOpe;
      arrLogAvi[intIndexTrava].strCodDig := strCodDig;
      arrLogAvi[intIndexTrava].blnIgnInc := blnIgnInc;
      arrLogAvi[intIndexTrava].blnAviso_ := False;

      If Assigned(objLiberacao) Then
        arrLogAvi[intIndexTrava].blnAviso_ := objLiberacao.blnAviso_;

      if AssigNed(objLiberacao) then
        arrLogAvi[intIndexTrava].strMsgJso := objLiberacao.fGetJsonMensagemCompleta
      else
        arrLogAvi[intIndexTrava].strMsgJso := '';

      intIndexTravaAux := fGetIndexTravaAux;
      If intIndexTravaAux = -1 Then
      Begin
        SetLength(arrLogAviAux, Succ(Length(arrLogAviAux)));
        intIndexTravaAux := High(arrLogAviAux);
      End;
      arrLogAviAux[intIndexTravaAux] := arrLogAvi[intIndexTrava];

      lblNumLib.Visible   := FALSE;
      lblSenLib.Visible   := FALSE;
      edtNumLib.Visible   := FALSE;
      edtSenLib.Visible   := FALSE;
      btnTipSenha.Visible := FALSE;
      lblSenLibMaster.Visible := FALSE;

      pnlCabecalho.Height := 50;

      edtTraTel.Alignment := taCenter;
      edtTraTel.Text := '*** ATENÇÃO ***';
      edtTraTel.Left := (pnlCabecalho.Width div 2) - (edtTraTel.Width div 2);
      pSetFocus(lsvMotivos);
    End;

    edtSenLib.ReadOnly := Not blnTraTel;

    If (strSenFvu = 'V') And (blnTraTel) Then
    Begin
      {*************************************}
      {* VERIFICA SE ENVIA MSG P/ GERÊNCIA *}
      {**********************************RV*}
      If fCfgSis('HABREM', varBoolean) And blnTraTel Then
      Begin
        btnLibera.Visible := True;
        lblOpeSemAce.Visible := (Not fExisteOperadorComAcessoLibRemota);
        btnLibera.Enabled    := (Not lblOpeSemAce.Visible);
      End;
    End;

    If Assigned(objLiberacao) Then
      btnAnlAnalitica.Visible := blnTraTel And objLiberacao.blnAnAnalitica
    Else
      btnAnlAnalitica.Visible := False;

    if blnTelaResumida then
      pnlRodape.Visible := False
    else
      pnlRodape.Visible := (Pos(strDirAce, 'DEATR_LIMCR_') > 0) Or
                           TMostraTravaMinimaHelper.fExibeTravaMinima Or
                           btnAnlAnalitica.Visible;

    strXmlCds := fRetornaXmlClientTravasMinimas(edtNumLib.Text);
    btnTravasMinimas.Visible := TMostraTravaMinimaHelper.fExibeTravaMinima And (Pos(strDirAce, 'VEMIN_VEMIN2_VEMIN3_VEMIN4_VEMIN5_VEMIN6_PRMIN_PRMIN2_PRMIN3_PRMIN4_PRMIN5_PRMIN6_') > 0) And blnTraTel And (Not fEmptyStr(strXmlCds));
    btnDebitos.Visible       := (Pos(strDirAce, 'DEATR_LIMCR_') > 0);
    btnObsCli.Visible        := (Pos(strDirAce, 'DEATR_LIMCR_') > 0);
    btnInfCobr.Visible       := btnDebitos.Visible;

    btnVendasPorCliente.Visible := (Not fEmptyStr(strCodCli)) And fVerificaAcessoSistema('VENCLF', strLoginUsuarioLogado);
    btnConCre.Visible           := (Not fEmptyStr(strCodCli)) And fVerificaAcessoSistema('CONCRE', strLoginUsuarioLogado);

    If (pnlRodape.Visible) Then
      pnlRodape.Visible := (btnDebitos.Visible)          Or
                           (btnObsCli.Visible)           Or
                           (btnTravasMinimas.Visible)    Or
                           (btnInfCobr.Visible)          Or
                           (btnVendasPorCliente.Visible) Or
                           (btnConCre.Visible)           Or
                           (btnAnlAnalitica.Visible);


    if (strSenFvu <> fCfgSis('SENPVU')) and (not fEmptyStr(fCfgSis('SENPVU'))) and (strSenFvu = 'V') then
      btnTipSenha.Click;

    If objLiberacao.blnSuprimirNivel Then
      intPosicaoNivel := fPosicaoNivel(GetDescricaoDirAce(strDirAce));

    If intPosicaoNivel > 0 Then
      lblDescricaoDireitoDeAcesso.Caption := Copy(GetDescricaoDirAce(strDirAce), 0, Pred(intPosicaoNivel))
    Else
      lblDescricaoDireitoDeAcesso.Caption := GetDescricaoDirAce(strDirAce);

    pnlDirAcesso.Visible := Not fEmptyStr(lblDescricaoDireitoDeAcesso.Caption);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fLiberacaoCliente]');
      blnConfirma := False;
      blnFecharF  := True;
    End;
  End;
end;

procedure TfrmFatLiberacaoCliente.pVendasPorCliente(strCodCli, strNomCli: String);
begin

  If Not fVerificaAcessoSistema('VENCLF') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso em Vendas por Clientes!', ['&O k']);
    Exit;
  End Else If fEmptyStr(strCodCli) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar um cliente.', ['&Ok']);
    Exit;
  End
  Else If (fEmptyStr(fRetNomCliente(strCodCli))) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar um cliente válido!', ['&Ok']);
    Exit;
  End;

  Try

    If fEmptyStr(strNomCli) Then
      strNomCli := fRetNomCliente(strCodCli);

    pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);

    Try
      frmRelFatVendasCliente.blnFaturamento         := True;
      frmRelFatVendasCliente.blnSenha               := False;
      frmRelFatVendasCliente.blnVeioDoTelemarketing := false;
      frmRelFatVendasCliente.blnVeioDoTablet        := false;
      frmRelFatVendasCliente.edtCodCliente.Text     := strCodCli;
      frmRelFatVendasCliente.edtDesCliente.Text     := strNomCli;
      frmRelFatVendasCliente.blnSomenteVendas       := True;
      frmRelFatVendasCliente.blnVeioTelaVendas      := True;
      frmRelFatVendasCliente.blnMosCom              := True;
      frmRelFatVendasCliente.blnCliCons := fClienteConsumidor(strNomCli, False, True);

      frmRelFatVendasCliente.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pVendasPorCliente]');
      End;
    End;

  Finally
    pFreeAndNil(frmRelFatVendasCliente);
  End;

end;

procedure TfrmFatLiberacaoCliente.RemoveTimerLibera;
begin
  TNewTimer.Del(Self.Name + '.tmrLibera');
end;

procedure TfrmFatLiberacaoCliente.RemoveTimerBotaoMsg;
begin
  TNewTimer.Del(Self.Name + '.tmrBotaoMsg');
end;

function TfrmFatLiberacaoCliente.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strCodigoLiberacao: String;

  function fSenhaValidaParaLiberacao: Boolean;
  begin
    Result := True;

    If blnNivel6 Then
    Begin
      If (fEmptyStr(strDirAceNv6))                               Or
         (Not fVerificaAcessoSistema(strDirAceNv6, strOperador)) Then
      Begin
        Result := False;
      End;
    End

    Else If blnNivel5 Then
    Begin
      If (fEmptyStr(strDirAceNv5))                               Or
         (Not fVerificaAcessoSistema(strDirAceNv5, strOperador)) Then
      Begin
        Result := False;
      End;
    End

    Else If blnNivel4 Then
    Begin
      If (fEmptyStr(strDirAceNv4))                               Or
         (Not fVerificaAcessoSistema(strDirAceNv4, strOperador)) Then
      Begin
        Result := False;
      End;
    End

    Else If blnNivel3 Then
    Begin
      If (fEmptyStr(strDirAceNv3))                               Or
         (Not fVerificaAcessoSistema(strDirAceNv3, strOperador)) Then
      Begin
        Result := False;
      End;
    End

    Else If blnNivel2 Then
    Begin
      If (fEmptyStr(strDirAceNv2))                               Or
         (Not fVerificaAcessoSistema(strDirAceNv2, strOperador)) Then
      Begin
        Result := False;
      End;
    End

    Else If (Not fVerificaAcessoSistema(strDirAce, strOperador)) Then
    Begin
      Result := False;
    End;

  end;

Var
  strCodEmpDes: String;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtSenLib) And (Not edtSenLib.ReadOnly) Then
    Begin
      If fEmptyStr(edtSenLib.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A senha de liberação deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If strSenFvu = 'V' Then
      Begin
        if blnManterCompatibilidadeSenCfg then
        begin
          If (edtSenLib.Text <> strSenLib)Then
          begin
            fMensagem('ATENÇÃO!', 'A senha de liberação deve ser preenchida!', ['&O k']);
            Result := False;
          end
          else
          begin
            strCodigoLiberacao := fCodigoLiberacaoLogLib(strDirAce);
            pGeraMatrizLiberacao(strOperador,
                                 '',
                                 fMesclaMensagemMaisJustificativa(strMenObs, strJustTemp),
                                 strDirAce,
                                 strCodigoLiberacao,
                                 strCodIte,
                                 intAutInc,
                                 strNumLib,
                                 fMesclaMensagemMaisJustificativa(stlInformacao.Text, strJustTemp),
                                 blnIgnInc,
                                 fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFOF4'),
                                 0,
                                 0,
                                 0,
                                 strMsgSen,
                                 strMsgSen,
                                 strDirAceAuxiliar);

            pGeraLogLiberacao(strOperador,
                              '',
                              fMesclaMensagemMaisJustificativa(strMenObs, strJustTemp),
                              strDirAce,
                              strCodIte,
                              intAutInc,
                              strNumLib,
                              fMesclaMensagemMaisJustificativa(stlInformacao.Text, strJustTemp),
                              blnIgnInc,
                              fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFOF4'),
                              0,
                              0,
                              0,
                              strMsgSen,
                              strMsgSen,
                              strDirAceAuxiliar,
                              objLiberacao.strNumDoc,
                              objLiberacao.strEspDoc,
                              objLiberacao.strCodEmp,
                              strCodigoLiberacao);

            blnConfirma := True;
            Close;
          end;
        end
        else
        if (fRetornaSenCli(StrToInt(LeftStr(strNumLib,cnstIntTamIniCodLib))) <> LeftStr(edtSenLib.Text,7)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Senha de liberação não confere!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          strOperador := fDescriptografaOperador(edtSenLib.Text);
          If fEmptyStr(strOperador) Then
          Begin
            fMensagem('ATENÇÃO!', 'Senha de liberação não confere!', ['&O k']);
            Result := False;
          End
          Else If (fRetornaStatusCadastro(strOperador, 'OPE', 'CADOPE', 'OPE_CODOPE') = 'I') Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Usuário está inativo!', ['&O k']);
            Result := False;
          End

          Else
          Begin
            {**********************}
            {* GERA LOG LIBERACAO *}
            {*******************AF*}
            strCodigoLiberacao := fCodigoLiberacaoLogLib(strDirAce);
            pGeraMatrizLiberacao(strOperador,
                                 '',
                                 fMesclaMensagemMaisJustificativa(strMenObs, strJustTemp),
                                 strDirAce,
                                 strCodigoLiberacao,
                                 strCodIte,
                                 intAutInc,
                                 strNumLib,
                                 fMesclaMensagemMaisJustificativa(stlInformacao.Text, strJustTemp),
                                 blnIgnInc,
                                 fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFOF4'),
                                 0,
                                 0,
                                 0,
                                 strMsgSen,
                                 strMsgSen,
                                 strDirAceAuxiliar);

            pGeraLogLiberacao(strOperador,
                              '',
                              fMesclaMensagemMaisJustificativa(strMenObs, strJustTemp),
                              strDirAce,
                              strCodIte,
                              intAutInc,
                              strNumLib,
                              fMesclaMensagemMaisJustificativa(stlInformacao.Text, strJustTemp),
                              blnIgnInc,
                              fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFOF4'),
                              0,
                              0,
                              0,
                              strMsgSen,
                              strMsgSen,
                              strDirAceAuxiliar,
                              objLiberacao.strNumDoc,
                              objLiberacao.strEspDoc,
                              objLiberacao.strCodEmp,
                              strCodigoLiberacao);

            strCodEmpDes := '';
            If Not btnLibera.Enabled Then
              strCodEmpDes := TfrmCadMsg.fRetEmpDesCadMsg(strNumLib, strOperador);

            If Not fEmptyStr(strCodEmpDes) Then
            Begin
              {*****************************************************************}
              {* CASO OUTRO USUÁRIO PASSE PELA ESTAÇÃO E LIBERE O REGISTRO SEM *}
              {* SER PELA SUA ESTAÇÃO REMOTA                                   *}
              {***************************************************************VA}
              TfrmCadMsg.fMarcaLiberada(strNumLib, '', strOperador);
              pUpdateLogVar(strNumLib, strOperador, False, strCodEmpDes);
            End
            Else
            Begin
              pUpdateLogVar(strNumLib, strOperador);
            End;

            blnConfirma := True;
            Close;
          End;
        End;

      End
      Else If (strSenFvu = 'U') Or (blnSempreVariavelUsuario) Then
      Begin

        strOperador := fRetCodVendedor(edtSenLib.Text);
        If (Not fEmptyStr(strOperador)) Then
        Begin
          If Not fSenhaValidaParaLiberacao Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse operador não tem direitos para essa liberação!', ['&O k']);
            Result := False;
          End
          Else If (fRetornaStatusCadastro(strOperador, 'OPE', 'CADOPE', 'OPE_CODOPE') = 'I') Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Usuário está inativo!', ['&O k']);
            Result := False;
          End
          Else If (Not fEhAdministrador(strOperador)) And (Pos(VS_strCodEmp, fRetEmpAcessoUsuario(strOperador)) <= 0 ) Then
          Begin
            fMensagem('ATENÇÃO!', '-------------------------------------------------------------------------------------------------'+#13+
                                  'Este usuário de liberação não tem acesso à esta empresa. '+#13+
                                  'Esta liberação não será confirmada. '+#13+
                                  'Para definição do acesso às empresas, acessar CAD.OPERADORES > ACESSO EMPRESA > EMPRESAS - ACESSO'+#13+
                                  '-------------------------------------------------------------------------------------------------', ['&O k']);
            Result := False;
          End
          Else
          Begin
            {**********************}
            {* GERA LOG LIBERACAO *}
            {*******************AF*}
            strCodigoLiberacao := fCodigoLiberacaoLogLib(strDirAce);
            pGeraMatrizLiberacao(strOperador,
                                 strCodOpe,
                                 fMesclaMensagemMaisJustificativa(strMenObs, strJustTemp),
                                 strDirAce,
                                 strCodigoLiberacao,
                                 strCodIte,
                                 intAutInc,
                                 strNumLib,
                                 fMesclaMensagemMaisJustificativa(stlInformacao.Text, strJustTemp),
                                 blnIgnInc,
                                 fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFOF4'),
                                 0,
                                 0,
                                 0,
                                 strMsgSen,
                                 strMsgSen,
                                 strDirAceAuxiliar);

            pGeraLogLiberacao(strOperador,
                              strCodOpe,
                              fMesclaMensagemMaisJustificativa(strMenObs, strJustTemp),
                              strDirAce,
                              strCodIte,
                              intAutInc,
                              strNumLib,
                              fMesclaMensagemMaisJustificativa(stlInformacao.Text, strJustTemp),
                              blnIgnInc,
                              fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFOF4'),
                              0,
                              0,
                              0,
                              strMsgSen,
                              strMsgSen,
                              strDirAceAuxiliar,
                              objLiberacao.strNumDoc,
                              objLiberacao.strEspDoc,
                              objLiberacao.strCodEmp,
                              strCodigoLiberacao);

            strCodEmpDes := '';
            If Not btnLibera.Enabled Then
              strCodEmpDes := TfrmCadMsg.fRetEmpDesCadMsg(strNumLib, strOperador);

            If Not fEmptyStr(strCodEmpDes) Then
            Begin
              {*****************************************************************}
              {* CASO OUTRO USUÁRIO PASSE PELA ESTAÇÃO E LIBERE O REGISTRO SEM *}
              {* SER PELA SUA ESTAÇÃO REMOTA                                   *}
              {***************************************************************VA}
              TfrmCadMsg.fMarcaLiberada(strNumLib, '', strOperador);
              pUpdateLogVar(strNumLib, strOperador, False, strCodEmpDes);
            End
            Else
            Begin
              pUpdateLogVar(strNumLib, strOperador);
            End;

            blnConfirma := True;
            Close;
          End;
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Esse operador não tem direitos para essa liberação!', ['&O k']);
          Result := False;
        End;

      End

    End;

  End;

  If Not Result Then
  Begin
    strOperador := FstrOperadorOriginal;
    pSetFocus(Sender);
  End;
end;

function TfrmFatLiberacaoCliente.TimerLibera: TNewTimer;
begin
  if not TNewTimer.Has(Self.Name + '.tmrLibera') then
  begin
    Result := TNewTimer.Get(Self.Name + '.tmrLibera');
    Result.Interval := 1500;
    Result.Enabled  := True;
    Result.OnTimer  := tmrLiberaTimer;
  end
  else
    Result := TNewTimer.Get(Self.Name + '.tmrLibera');
end;

function TfrmFatLiberacaoCliente.TimerBotaoMsg: TNewTimer;
begin
  if not TNewTimer.Has(Self.Name + '.tmrBotaoMsg') then
  begin
    Result := TNewTimer.Get(Self.Name + '.tmrBotaoMsg');
    Result.Interval := fCfgSis('ATBTMS', varInteger) * 1000;
    Result.Enabled  := True;
    Result.OnTimer  := pAtualizarBotaoMensagens;
  end
  else
    Result := TNewTimer.Get(Self.Name + '.tmrBotaoMsg');
end;

procedure TfrmFatLiberacaoCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  RemoveTimerLibera;
  pLiberacaoMaster;

  If Not fVerificaLiberacao(strNumLib, strOperador) Then
    pApagarMsgLiberacao;

  FreeAndNil(stlInformacao);
end;

procedure TfrmFatLiberacaoCliente.FormCreate(Sender: TObject);
begin
  inherited;
  strMotivos := 'Motivos';

  strCaption  := '';
  strOpeEnv   := '';
  blnConfirma := False;
  strSenFvu := fCfgSis('SENFVU');
  edtSenLib.MaxLength := 10;
  strXmlCds := '';
  blnIgnInc := False;
  blnSenLib := False;
  blnUsaDig := (fCfgSis('USADIG', varBoolean));
  intQuantidadeLinhas:= 0;
  blnLimitaQuantidadeDuplicata:= False;

  If Assigned(cdsXmlTra) Then
    FreeAndNil(cdsXmlTra);

  If Assigned(cdsXmlF4) Then
    FreeAndNil(cdsXmlF4);

end;

procedure TfrmFatLiberacaoCliente.FormDestroy(Sender: TObject);
begin
  RemoveTimerLibera;
  RemoveTimerBotaoMsg;
  inherited;
end;

function TfrmFatLiberacaoCliente.fPosicaoNivel(strMenu: String): Integer;
  Var
    intContador : Integer;
begin
  For intContador := 0 To 6 Do
  Begin
    Result := Pos(' - Nível '+IntToStr(intContador), strMenu);
    If Result > 0 Then
      Break;
  End;
end;

function TfrmFatLiberacaoCliente.fExisteOperadorComAcessoLibRemota: Boolean;
  Var
    qryCadOpe: TUniQuery;
begin
  qryCadOpe := fCriaQuery;
  Try
    qryCadOpe.SQL.Add( fGetSqlLiberacao );
    qryCadOpe.SQL.Add('AND OPE_CODOPE NOT IN ("997", "998", "999")');
    qryCadOpe.SQL.Add('AND EXISTS(');
    qryCadOpe.SQL.Add('  SELECT 1 FROM DIROPE D');
    qryCadOpe.SQL.Add('  WHERE D.OPE_CODOPE = CADOPE.OPE_CODOPE');
    qryCadOpe.SQL.Add('  AND D.DIR_NOMFRM = :DIRACE');
    qryCadOpe.SQL.Add('  UNION ALL');
    qryCadOpe.SQL.Add('  SELECT 1 FROM DIRGPO D');
    qryCadOpe.SQL.Add('  JOIN OPEGPO O ON O.GPO_CODGPO = D.GPO_CODGPO');
    qryCadOpe.SQL.Add('  WHERE O.OPE_CODOPE = CADOPE.OPE_CODOPE');
    qryCadOpe.SQL.Add('  AND D.DIR_NOMFRM = :DIRACE');
    qryCadOpe.SQL.Add(')');
    qryCadOpe.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryCadOpe.ParamByName('CODEMP').AsString := fGetEmpLib;
    qryCadOpe.ParamByName('DIRACE').AsString := strDirAce;
    qryCadOpe.Open;

    Result := Not qryCadOpe.IsEmpty;
  Finally
    FreeAndNil(qryCadOpe);
  End;
end;

function TfrmFatLiberacaoCliente.fGetEmpLib: String;
begin
  Result := VS_strCodEmp;

  If objLiberacao.blnOperacaoMultiLojaTravaEstoqueItemAItem Then
    Result := objLiberacao.strEmpresaOperacaoMultiLoja;
end;

function TfrmFatLiberacaoCliente.fGetSqlLiberacao: String;
begin
  Result := '';
  Result := Result + ' SELECT OPE_CODOPE ';
  Result := Result + ' FROM CADOPE       ';
  Result := Result + ' WHERE OPE_CODOPE <> :CODOPE ';
  //Feito para operadores que podem acessar a empresa para fazer vendas mas não podem liberar travas daquela empresa
  Result := Result + ' AND LOCATE(:CODEMP, OPE_EMPLIB) > 0 ';

  If objLiberacao.blnOperacaoMultiLojaTravaEstoqueItemAItem Then
    Result := Result + ' AND LOCATE(:CODEMP, OPE_EMPEST) > 0 ';

  Result := Result + ' AND OPE_MSGLIB  = "S" ';
  Result := Result + ' AND OPE_STATUS <> "I" ';

  If Not fEmptyStr(strOpeEnv) Then
    Result := Result + ' AND OPE_CODOPE = ' + QuotedStr(strOpeEnv);
end;

function TfrmFatLiberacaoCliente.fGetIndexTrava(blnConsiderarAComissaoDoProfissionalEOValorDoFreteNaTravaDePreco : Boolean = False;
  blnEhTravaItemAItemFinalVenda: Boolean = False): Integer;
  Const
    TRAVAS_VENDA_VR_MINIMO = 'VEMIN_VEMIN2_VEMIN3_VEMIN4_VEMIN5_VEMIN6_';
    TRAVAS_VRUNI_PR_MINIMO = 'PRMIN_PRMIN2_PRMIN3_PRMIN4_PRMIN5_PRMIN6_';
  Var
    intContador: Integer;
begin

  Result := -1;

  If (blnConsiderarAComissaoDoProfissionalEOValorDoFreteNaTravaDePreco) Then
  Begin
    For intContador := Low(arrLogAvi) To High(arrLogAvi) Do
      If (Pos(strDirAce, TRAVAS_VENDA_VR_MINIMO) > 0) Then
        Exit(intContador);
  End;

  if blnEhTravaItemAItemFinalVenda and (Pos(strDirAce, TRAVAS_VRUNI_PR_MINIMO) > 0) then
  begin
    For intContador := Low(arrLogAvi) To High(arrLogAvi) Do
      If SameText(arrLogAvi[intContador].strDirAce, strDirAce) and (arrLogAvi[intContador].intAutInc = intAutInc) Then
      Begin
        Result := intContador;
        Exit;
      End;
  end
  else
  begin
    For intContador := Low(arrLogAvi) To High(arrLogAvi) Do
      If SameText(arrLogAvi[intContador].strDirAce, strDirAce) Then
      Begin
        Result := intContador;
        Exit;
      End;
  end;
end;

function TfrmFatLiberacaoCliente.fGetIndexTravaAux: Integer;
  Var
    intContador: Integer;
begin
  Result := -1;
  For intContador := Low(arrLogAviAux) To High(arrLogAviAux) Do
    If SameText(arrLogAviAux[intContador].strDirAce, strDirAce) Then
    Begin
      Result := intContador;
      Exit;
    End;
end;

procedure TfrmFatLiberacaoCliente.lblDescricaoDireitoDeAcessoClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pAbrirDireitoDeAcesso, 'Carregando Direitos de Acesso (AUTCOM), Aguarde ...', '');
end;

procedure TfrmFatLiberacaoCliente.lsvMotivosCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  inherited;
  DefaultDraw:=True;

  If Pos(STRING_JUSTIFICATIVA, Item.Caption) > 0 Then
    DefaultDraw:=False;

  If Pos(STRING_FORMAS_PAGTO_NEGOCIADAS, Item.Caption) > 0 Then
    DefaultDraw:=False;

end;

procedure TfrmFatLiberacaoCliente.lsvMotivosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
  Begin

    If (Not blnTraTel) Or (blnSenLib) Then
    Begin
      Close;
    End
    Else
    Begin
      pSetFocus(edtSenLib);
    End;

  End;
end;

procedure TfrmFatLiberacaoCliente.lsvMotivosSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
  Var
    intCnt : Integer;
begin
  inherited;

  pnlInfo.Caption := '';

  For intCnt := Low(arrHinLin) To High(arrHinLin) Do
  Begin
    If intCnt = Item.Index Then
    Begin
      pnlInfo.Caption := arrHinLin[intCnt];
      Break;
    End;
  End;
end;

function TfrmFatLiberacaoCliente.fEnviaMsgLiberacao: Boolean;
  Var
    qryCadOpe : TUniQuery;
    msgInterna: TMsgInterna;
    strMensagem: String;
    strMensagemJson : String;
    strJustificativa: String;
    strMsgNegativa: String;
    objRegistro : TRegistroMsgLibera;
    strMsgJsonEnvio: String;
    strMsgEnvio: String;
begin
  qryCadOpe := fCriaQuery;
  Try
    qryCadOpe.SQL.Add( fGetSqlLiberacao );
    qryCadOpe.SQL.Add('ORDER BY OPE_CODOPE');
    qryCadOpe.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryCadOpe.ParamByName('CODEMP').AsString := fGetEmpLib;
    qryCadOpe.Open;

    Result := Not qryCadOpe.IsEmpty;

    If Not Result Then
    Begin
      If Not fEmptyStr(strOpeEnv) Then
        pMensagemOk('O operador '+ strOpeEnv +'-'+ fRetNomeOperador(strOpeEnv) +' está inativo, '+
                    'não está marcado para "Receber mensagem de Liberação Remota", '+
                    'ou não possui acesso no quadro "Empresas - Acesso para receber liberação remota" '+
                    IIF(objLiberacao.blnOperacaoMultiLojaTravaEstoqueItemAItem, 'e "Empresas - Estoque" ', '') +
                    'liberado para a loja '+ fGetEmpLib +'. Sendo assim, não pode receber a mensagem.'+ sLineBreak +
                    'Peça para o responsável ajustar o cadastro e depois tente novamente.', 500, 220)
      Else
        pMensagemOk('Não há nenhum operador ativo marcado para "Receber mensagem de Liberação Remota", '+
                    'com acesso no quadro "Empresas - Acesso para receber liberação remota" '+
                    IIF(objLiberacao.blnOperacaoMultiLojaTravaEstoqueItemAItem, 'e "Empresas - Estoque" ', '') +
                    'liberado para a loja '+ fGetEmpLib +'. Sendo assim, ninguém pode receber a mensagem.'+ sLineBreak +
                    'Peça para o responsável ajustar os cadastros e depois tente novamente.', 500, 220);
      Exit;
    End;

    qryCadOpe.First;
    msgInterna := TMsgInterna.Create(Self);

    strJustificativa := '';

    If fMensagem('', 'Deseja digitar uma justificativa para a solicitação de liberação?', ['','']) = 1 Then
    Begin
      While (fEmptyStr(strJustificativa)) Do
      Begin
         If not InputQuery(Trim(strAssuntoTit), 'Digite a justificativa para esta liberação:', strJustificativa) then
           break;
      End;

      if not fEmptyStr(strJustificativa) then
      begin

        if Assigned(objLiberacao) then
        begin
          if (not objLiberacao.objMsgRemota.IsEmpty) then
            objLiberacao.objMsgRemota.strJustificativa := strJustificativa
          else
            objLiberacao.objMsgLibera.strJustificativa := strJustificativa;
        end;

        strJustificativa := STRING_QUEBRA + 'JUSTIFICATIVA:' + STRING_QUEBRA + strJustificativa + STRING_QUEBRA;
        strJustTemp := #13 + StringReplace(strJustificativa, STRING_QUEBRA, '', [rfReplaceAll]) + #13;

        pGravarJustificativa(edtNumLib.Text, strJustTemp);
      end;
    End;

    If fEmptyStr(strAssuntoTit) Then
    begin
      if Assigned(objLiberacao) then
      begin
        if not fEmptyStr(objLiberacao.objMsgLibera.strTitulo) then
          strAssuntoTit := objLiberacao.objMsgLibera.strTitulo
        else
        begin
          for objRegistro in objLiberacao.objMsgLibera.lstRegistros do
          begin
            case objRegistro.enuTipo of
              trTexto        : strAssuntoTit := TRegistroMsgLiberaTexto(objRegistro).strTexto;
              trTextoCaption : strAssuntoTit := TRegistroMsgLiberaTextoCaption(objRegistro).strTexto;
            end;

            if not fEmptyStr(strAssuntoTit) then
              Break;
          end;
        end;
      end;
    end;

    if Assigned(objLiberacao) then
    begin
      strMensagem     := objLiberacao.objMsgLibera.fGetMensagem(intQuantidadeLinhas, blnLimitaQuantidadeDuplicata);
      strMensagemJSON := objLiberacao.fGetJsonMensagemCompleta;

      if (not objLiberacao.objMsgRemota.IsEmpty) then
      begin
        if objLiberacao.blnSomenteMsgRemota then
        begin
          strMensagem := objLiberacao.objMsgRemota.fGetMensagem;
        end
        else
        begin
          strMensagem     := strMensagem    + STRING_QUEBRA + objLiberacao.objMsgRemota.fGetMensagem;
        end;
      end;
    end
    else
    begin
      strMensagem     := stlInformacao.Text;
      strMensagem     := fMesclaMensagemMaisJustificativa(strMensagem, strJustificativa);
      strMensagemJSON := '';
    end;

    strMsgNegativa := fRetJustificativaNegacaoMsgAnterior(strCodigoLiberacaoLogVar, strCodCli);
    If Not fEmptyStr(strMsgNegativa) Then
      strMensagem := strMensagem + strMsgNegativa;

    strMensagem := strMensagem  + #13#10+ objLiberacao.strRotina;
    strMensagem := AnsiReplaceStr(strMensagem, #13#10, STRING_QUEBRA);

    if not (fVerificaAcessoSistema('PVISPF')) then
    begin
      strMensagem := AnsiReplaceStr(strMensagem, '@(', '');
      strMensagem := AnsiReplaceStr(strMensagem, ')@', '');
      strMensagemJSON := AnsiReplaceStr(strMensagemJSON, '@(', '');
      strMensagemJSON := AnsiReplaceStr(strMensagemJSON, ')@', '');
    end;

    strMensagem     := fLimpaTagMsgOculta(strMensagem);
    strMensagemJSON := fLimpaTagMsgOculta(strMensagemJSON);

    Try
      fStartTransaction();

      If (fCfgSis('ALTVMT', varBoolean)) Then
      Begin
        pMandaMensagemLiberacaoValorMinimoPorItem;
      End;

      While Not qryCadOpe.Eof Do
      Begin
        If (Not fEmptyStr(strOpeEnv)) Or fVerificaAcessoSistema(strDirAce, qryCadOpe.FieldByName('OPE_CODOPE').AsString) Then
        Begin
          strMsgJsonEnvio := strMensagemJSON;
          strMsgEnvio := strMensagem;
          If fDestinatarioSemDireitoAcessoInformacao(strDirAce, qryCadOpe.FieldByName('OPE_CODOPE').AsString) Then
          Begin
            strMsgEnvio     := fTagMsgOcultaToMsgCoringa(strMsgEnvio, omlMsgParaQuemReceb);
            strMsgJsonEnvio := fTagMsgOcultaToMsgCoringa(strMsgJsonEnvio, omlMsgParaQuemReceb);
          End
          Else
          Begin
            strMsgEnvio     := fLimpaTagMsgOculta(strMsgEnvio, omlMsgParaQuemReceb);
            strMsgJsonEnvio := fLimpaTagMsgOculta(strMsgJsonEnvio, omlMsgParaQuemReceb);
          End;

          If Not msgInterna.fEnviaMensagem( Trim(strAssuntoTit),
                                            strMsgEnvio,
                                            fRetCodOpeSolicitante(untFuncFat.strOpcDocUntFuncFat, IIF(blnUsaDig, strCodDig, strCodOpe)),
                                            qryCadOpe.FieldByName('OPE_CODOPE').AsString,
                                            'S',
                                            edtNumLib.Text,
                                            strMsgJsonEnvio ) Then
          Begin
            Exit(False);
          End;
        End;

        qryCadOpe.Next;
      End;

      fCommit();

    Except
      On E: Exception Do
      Begin
        fRollBack();
        pMensagensErro('Erro: ' + E.Message, '[fEnviaMsgLiberacao]');
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryCadOpe);

    If Assigned(msgInterna) Then
      FreeAndNil(msgInterna);
  End;
end;

procedure TfrmFatLiberacaoCliente.pLiberacaoMaster;
var
  strCodEmpDes: String;
  strCodigoLiberacao: String;
begin
  If blnSenLib Or fVerificaAcessoMaster(strDirAce, strCodOpe) Then
  Begin
    {**********************}
    {* GERA LOG LIBERACAO *}
    {*******************AF*}
    strCodigoLiberacao := fCodigoLiberacaoLogLib(strDirAce);
    pGeraMatrizLiberacao(strOperador,
                         strCodOpe,
                         fMesclaMensagemMaisJustificativa(strMenObs, strJustTemp),
                         strDirAce,
                         strCodigoLiberacao,
                         strCodIte,
                         intAutInc,
                         strNumLib,
                         fMesclaMensagemMaisJustificativa(stlInformacao.Text, strJustTemp),
                         blnIgnInc,
                         fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFOF4'),
                         0,
                         0,
                         0,
                         strMsgSen,
                         strMsgSen,
                         strDirAceAuxiliar);

    pGeraLogLiberacao(strOperador,
                      strCodOpe,
                      fMesclaMensagemMaisJustificativa(strMenObs, strJustTemp),
                      strDirAce,
                      strCodIte,
                      intAutInc,
                      strNumLib,
                      fMesclaMensagemMaisJustificativa(stlInformacao.Text, strJustTemp),
                      blnIgnInc,
                      fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFOF4'),
                      0,
                      0,
                      0,
                      strMsgSen,
                      strMsgSen,
                      strDirAceAuxiliar,
                      objLiberacao.strNumDoc,
                      objLiberacao.strEspDoc,
                      objLiberacao.strCodEmp,
                      strCodigoLiberacao);

    strCodEmpDes := '';
    If Not btnLibera.Enabled Then
      strCodEmpDes := TfrmCadMsg.fRetEmpDesCadMsg(strNumLib, strOperador);

    If Not fEmptyStr(strCodEmpDes) Then
    Begin
      {*****************************************************************}
      {* CASO OUTRO USUÁRIO PASSE PELA ESTAÇÃO E LIBERE O REGISTRO SEM *}
      {* SER PELA SUA ESTAÇÃO REMOTA                                   *}
      {***************************************************************VA}
      TfrmCadMsg.fMarcaLiberada(strNumLib, '', strOperador);
      pUpdateLogVar(strNumLib, strOperador, False, strCodEmpDes);
    End
    Else
    Begin
      pUpdateLogVar(strNumLib, strOperador);
    End;

    blnConfirma := True;
  End;
end;

procedure TfrmFatLiberacaoCliente.tmrLiberaTimer(Sender: TObject);
Var
  strMsgLib          : String;
  strOpeAnalise      : String;
  strCodigoLiberacao : String;
  strWtsMaq          : String;
begin

  inherited;

  If (Not btnLibera.Enabled) And (Not lblOpeSemAce.Visible) Then
  Begin

    If fMsgLiberacaoJaAnalisando(strOpeAnalise) Then
    Begin
      If Not fEmptyStr(strOpeAnalise) Then
      Begin
        lblAnalisePor.Caption := 'Por: ' + strOpeAnalise + '-' + fRetNomeOperador(strOpeAnalise);
        pMostrarStatusEmAnalise(True);
        pMostrarStatusAguardando(False);
      End;
    End
    Else
    Begin
      pMostrarStatusEmAnalise(False);
      pMostrarStatusAguardando(True);
    End;

  End;

  If fVerificaLiberacao(strNumLib, strOperador) Then
  Begin
    if fCfgSis('JUSLIB', varBoolean) then
    begin
      while not fMsgLiberacaoJaLida(strMsgLib, strOperador) do
      Begin
        Continue;
      End;

      if not fEmptyStr(strMsgLib) then
      begin
        strMsgLib := sLineBreak + 'Justificativa de Liberação: ' + strMsgLib;
      end;
    end;

    if not fVerificaDataHoraLiberacao(strNumLib, horaLogVar) then
      horaLogVar := 0;
    if not fVerificaDataHoraEnvio(strNumLib, horaLogEnv) then
      horaLogEnv := 0;
    if not fVerificaDataHoraCadastro(strNumLib, horaLogCad) then
      horaLogCad := 0;
    fVerificaMaquinaLiberacao(strNumLib, strWtsMaq);

    strCodigoLiberacao := fCodigoLiberacaoLogLib(strDirAce);
    pGeraMatrizLiberacao(strOperador,
                         strCodOpe,
                         fMesclaMensagemMaisJustificativa(strMenObs, strJustTemp, strMsgLib),
                         strDirAce,
                         strCodigoLiberacao,
                         strCodIte,
                         intAutInc,
                         strNumLib,
                         fMesclaMensagemMaisJustificativa(stlInformacao.Text, strJustTemp, strMsgLib),
                         blnIgnInc,
                         fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFOF4'),
                         horaLogVar,
                         horaLogCad,
                         horaLogEnv,
                         strMsgSen,
                         strMsgSen,
                         strDirAceAuxiliar);

    pGeraLogLiberacao(strOperador,
                      strCodOpe,
                      fMesclaMensagemMaisJustificativa(strMenObs, strJustTemp, strMsgLib),
                      strDirAce,
                      strCodIte,
                      intAutInc,
                      strNumLib,
                      fMesclaMensagemMaisJustificativa(stlInformacao.Text, strJustTemp, strMsgLib),
                      blnIgnInc,
                      fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFOF4'),
                      horaLogVar,
                      horaLogCad,
                      horaLogEnv,
                      strMsgSen,
                      strMsgSen,
                      strDirAceAuxiliar,
                      objLiberacao.strNumDoc,
                      objLiberacao.strEspDoc,
                      objLiberacao.strCodEmp,
                      strCodigoLiberacao,
                      strWtsMaq);

    If (Not fEmptyStr(strMsgLib)) And (fCfgSis('JUSLIB', varBoolean)) And (fCfgSis('JUSAUT', varBoolean)) Then
    Begin
      TimerLibera.Enabled := False;
      fMensagem('', 'A sua solicitação de liberação foi Autorizada!' + strMsgLib, ['&Ok']);
    End;

    blnConfirma := True;
    Close;
  End
  Else If fMsgLiberacaoJaLida(strMsgLib) Then
  Begin
    TimerLibera.Enabled := False;
    If Not fEmptyStr(strMsgLib) Then
      strMsgLib := #13#10 + 'Justificativa: ' + strMsgLib;

    fMensagem('', 'A sua solicitação de liberação foi Negada!' + strMsgLib, ['&Ok']);

    lblAnalise.Caption := 'Solicitação Negada!';
    lblAnalisePor.Caption := 'Por: ' + strOpeAnalise + '-' + fRetNomeOperador(strOpeAnalise);
    pMostrarStatusEmAnalise(True);
    pMostrarStatusAguardando(False);
  End;
end;

procedure TfrmFatLiberacaoCliente.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F5) And pnlRodape.Visible Then
    btnDebitos.Click
  Else
  If (Key = VK_F6) Then
  Begin
    If Shift = [ssAlt] then
      btnMensagens.Click
    Else If pnlRodape.Visible Then
      btnObsCli.Click;
  End
  Else
  If (Key = VK_F7) Then
  Begin
    If Shift = [ssAlt] then
      btnEnvMensagem.Click
    Else If pnlRodape.Visible Then
      btnTravasMinimas.Click;
  End
  Else If Key = VK_F9 Then
  Begin
    If Shift = [ssAlt] Then
      btnProdPreMin.Click
    Else If pnlRodape.Visible Then
      btnInfCobr.Click;
  End
  Else
  If Key = VK_F2 Then
    btnTipSenha.Click
  Else
  If (ssAlt in Shift) And (Key = VK_F8) And (btnVendasPorCliente.Visible) then
    btnVendasPorCliente.Click
  Else
  If (Key = VK_F8) And btnLibera.Visible And btnLibera.Enabled Then
    btnLibera.Click
  Else
  If (Key = VK_F11) And (btnConCre.Visible) then
    btnConCre.Click
  Else
  If (Key = VK_F12) And (pnlRodape.Visible) then
    btnAnlAnalitica.Click
  Else
  If (Key = VK_F3) And (blnTraTel) Then
    btnOperadorAcesso.Click;

end;

procedure TfrmFatLiberacaoCliente.btnAnlAnaliticaClick(Sender: TObject);
  Var
    strInfLog: String;
begin
  inherited;
  If Not btnAnlAnalitica.Visible Then
    Exit;

  If Not fSolicLiberacaoAnaliseAnalitica Then
    Exit;

  fObtemInfoLog(edtNumLib.Text, strInfLog);

  {*REQ*145519**********RP*}
  pCriarFormularios(TfrmMemo, frmMemo);
  Try
    frmMemo.Height := 600;
    frmMemo.Width  := 1024;
    frmMemo.cxMemo.Lines.Text := fLimpaTagMsgOculta(strInfLog, omlMsgParaQuemReceb);
    frmMemo.cxMemo.Style.Font.Style := [];
    frmMemo.cxMemo.Style.Font.Size  := 8;
    frmMemo.cxMemo.Properties.ScrollBars := ssBoth;
    frmMemo.cxMemo.Properties.WordWrap := False;
    frmMemo.ShowModal;
  Finally
    pFreeAndNil(frmMemo);
  End;
end;

procedure TfrmFatLiberacaoCliente.btnConCreClick(Sender: TObject);
begin
  inherited;
  If (btnConCre.Visible) Then
    pMostraConsultaCredito;
end;

procedure TfrmFatLiberacaoCliente.btnDebitosClick(Sender: TObject);
begin
  inherited;

  pDebitosCliente(strCodOpe, strCodDig, strCodCli);
end;

procedure TfrmFatLiberacaoCliente.btnEnvMensagemClick(Sender: TObject);
var
  frmCadMsgEnv: TfrmCadMsgEnv;
begin
  inherited;

  pCriarFormularios(TfrmCadMsgEnv, frmCadMsgEnv);
  try
    frmCadMsgEnv.ShowModal;
  finally
    pFreeAndNil(frmCadMsgEnv);
  end;
end;

procedure TfrmFatLiberacaoCliente.btnInfCobrClick(Sender: TObject);
  Var
    frmInfCobranca : TfrmInfCobranca;
begin
  inherited;
  If (Not btnInfCobr.Visible) Or (Not pnlRodape.Visible) Then
    Exit;

  If (Not fEmptyStr(strCodCli)) Then
  Begin
    Try
      pCriarFormularios(TfrmInfCobranca, frmInfCobranca);
      frmInfCobranca.edtCodCli.Text := strCodCli;
      frmInfCobranca.edtNomCli.Text := fRetNomCliente(strCodCli);
      frmInfCobranca.ShowModal;

    Finally
      pFreeAndNil(frmInfCobranca);
    End;
  End;
end;

procedure TfrmFatLiberacaoCliente.btnLiberaClick(Sender: TObject);
begin
  inherited;
  If Not fEnviaMsgLiberacao Then
    Exit;

  TimerLibera.Enabled := True;
  btnLibera.Enabled := False;
end;

procedure TfrmFatLiberacaoCliente.btnMensagensClick(Sender: TObject);
var
  frmCadMsg: TfrmCadMsg;
begin
  inherited;

  pCriarFormularios(TfrmCadMsg, frmCadMsg);
  try
    frmCadMsg.ShowModal;
  finally
    pFreeAndNil(frmCadMsg);
  end;
end;

procedure TfrmFatLiberacaoCliente.btnObsCliClick(Sender: TObject);
  Var
    qryQuery: TUniQuery;
begin
  inherited;
  Try
    qryQuery := fCriaQuery(Self);
    With qryQuery Do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add('   CLI_OBSERV ');
      SQL.Add(' FROM CADCLI ');
      SQL.Add(' WHERE CLI_CODCLI = :CODCLI ');
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      If (Not FieldByName('CLI_OBSERV').IsNull) And (FieldByName('CLI_OBSERV').AsString <> '') Then
      Begin
        Try
          pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
          frmFatMostraObsCliente.memObserv.Texto := FieldByName('CLI_OBSERV').AsString;
          frmFatMostraObsCliente.strCodCli       := strCodCli;
          frmFatMostraObsCliente.showModal;
        Except
          On E: Exception Do
            pMensagensErro(E.Message, '[btnObsCliClick]');
        End;
        pFreeAndNil(frmFatMostraObsCliente);
      End
      Else
        fMensagem('Informação', 'Nenhuma observação encontrada para este cliente', ['&OK']);
    End;
  Finally
    FreeAndNil(qryQuery);
  End;
end;

procedure TfrmFatLiberacaoCliente.btnOperadorAcessoClick(Sender: TObject);
  var
    frmPermisaoAcesso : TfrmPermissaoAcesso;
begin
  inherited;
  If (Not ValidarPermissaoAcesso) Then
    Exit;
  pCriarFormularios(TfrmPermissaoAcesso, frmPermisaoAcesso);

  Try
    frmPermisaoAcesso.strDireitoAcesso := strDirAce;
    frmPermisaoAcesso.blnSomenteExibir := True;
    frmPermisaoAcesso.Showmodal;
  Finally
    pFreeAndNil(frmPermisaoAcesso);
  End;
end;

procedure TfrmFatLiberacaoCliente.btnProdPreMinClick(Sender: TObject);
begin
  inherited;

  if not btnProdPreMin.Visible then
    Exit;

  pMostraProdutosTravaPreco;
end;

procedure TfrmFatLiberacaoCliente.btnTipSenhaClick(Sender: TObject);
begin
  inherited;
  If (Not btnTipSenha.Visible) Then
    Exit;

  If strSenFvu = 'U' Then
  Begin
    btnTipSenha.Caption := '[F2] SENHA VARIÁVEL';
    strSenFvu := 'V';
    edtSenLib.Clear;
    edtSenLib.MaxLength := 0;
  End
  Else If strSenFvu = 'V' Then
  Begin
    btnTipSenha.Caption := '[F2] SENHA POR USUÁRIO';
    strSenFvu := 'U';
    edtSenLib.Clear;
    edtSenLib.MaxLength := 10;
  End
end;

procedure TfrmFatLiberacaoCliente.btnTravasMinimasClick(Sender: TObject);
  Var
    cdsTmp: TUniClientDataSet;
    StringStream: TStringStream;
begin
  inherited;

  If (btnTravasMinimas.Visible) And (Not fEmptyStr(strXmlCds)) Then
  Begin
    StringStream := TStringStream.Create(AnsiReplaceStr(strXmlCds, '''', '"'));

    Try
      cdsTmp := TUniClientDataSet.Create(Self);
      cdsTmp.LoadFromStream(StringStream);
    Except
      // Cria os fields caso exista algum erro no código do XML
    End;

    TMostraTravaMinimaHelper.pExibeDados(cdsTmp, Nil);
    FreeAndNil(StringStream);
    FreeAndNil(cdsTmp);
  End;
end;

procedure TfrmFatLiberacaoCliente.btnVendasPorClienteClick(Sender: TObject);
begin
  inherited;
  If btnVendasPorCliente.Visible Then
    pVendasPorCliente(fRetornaClienteDaLiberacao(strNumLib));
end;

procedure TfrmFatLiberacaoCliente.FormPaint(Sender: TObject);
begin
  inherited;

  If blnFecharF Then
    Close;

end;

procedure TfrmFatLiberacaoCliente.FormShow(Sender: TObject);
begin
  inherited;
  lsvMotivos.Column[0].Caption := strMotivos;
  TimerBotaoMsg.Enabled := True;
  btnProdPreMin.Visible := fCfgSis('ALTVMT', varBoolean);
  pAtualizarBotaoMensagens(Self);
end;

procedure TfrmFatLiberacaoCliente.pAbrirDireitoDeAcesso;
begin
  TfrmPermissaoAcesso.EditarPermissoes(strDirAce);
end;

procedure TfrmFatLiberacaoCliente.pApagarMsgLiberacao;
begin
  fExecutaSQL( ' DELETE FROM CADMSG ' +
               ' WHERE MSG_OPEENV = ' + QuotedStr(fRetCodOpeSolicitante(untFuncFat.strOpcDocUntFuncFat, IIF(blnUsaDig, strCodDig, strCodOpe))) +
               ' AND MSG_NUMLIB = ' + QuotedStr(edtNumLib.Text) );
end;

function TfrmFatLiberacaoCliente.fMsgLiberacaoJaAnalisando(var strOpeAnalise: String): Boolean;
var
  qryMsg: TUniQuery;
begin

  qryMsg := fCriaQuery(nil);

  Try

    With qryMsg, SQL Do
    Begin

      Clear;

      Add('SELECT SQL_NO_CACHE ');
      Add('  MSG_OPELIB ');
      Add('FROM ');
      Add('  CADMSG ');
      Add('WHERE ');
      Add('  MSG_OPEENV = :OPEENV AND ');
      Add('  MSG_NUMLIB = :NUMLIB AND ');
      Add('  ((MSG_OPELIB IS NOT NULL) AND (MSG_OPELIB <> "")) ');

      ParamByName('OPEENV').AsString := fRetCodOpeSolicitante(untFuncFat.strOpcDocUntFuncFat, IIF(blnUsaDig, strCodDig, strCodOpe));
      ParamByName('NUMLIB').AsString := edtNumLib.Text;

      Open;

      Result := (Not IsEmpty);

      strOpeAnalise := '';

      If Result Then
        strOpeAnalise := FieldByName('MSG_OPELIB').AsString;

    End;

  Finally
    FreeAndNil(qryMsg);
  End;

end;

function TfrmFatLiberacaoCliente.fMsgLiberacaoJaLida(var strMsgLib: String; strOpeLibRef: String = ''): Boolean;
  var
    qryMsg: TUniQuery;
begin
  qryMsg := fCriaQuery(nil);

  With qryMsg, SQL Do
  Begin
    Clear;
    Add('SELECT SQL_NO_CACHE ');
    Add('  MSG_MSGLIB ');
    Add('FROM ');
    Add('  CADMSG ');
    Add('WHERE ');
    If (Not fEmptyStr(strOpeLibRef)) Then
      Add('MSG_OPELIB = "'+strOpeLibRef+'" AND ');
    Add('  MSG_OPEENV = :OPEENV AND ');
    Add('  MSG_NUMLIB = :NUMLIB AND ');
    Add('  MSG_LIDA__ = "S" ');

    ParamByName('OPEENV').AsString := fRetCodOpeSolicitante(untFuncFat.strOpcDocUntFuncFat, IIF(blnUsaDig, strCodDig, strCodOpe));
    ParamByName('NUMLIB').AsString := edtNumLib.Text;

    Open;

    Result := (Not IsEmpty);

    strMsgLib := '';

    If Result Then
      strMsgLib := FieldByName('MSG_MSGLIB').AsString;
  End;

  FreeAndNil(qryMsg);
end;

function TfrmFatLiberacaoCliente.ValidarPermissaoAcesso: Boolean;
Var
  LSenha: String;
begin
  If Not fVerificaAcessoSistema('frmDirAcesso') Then
  Begin
    If Not ffrmSenha(LSenha) Then
      Exit(False);

    If Not fVerificaAcessoSistema('frmDirAcesso', fRetCodVendedor(LSenha)) Then
      Exit(False);
  End;
  Result := True;
end;

procedure TfrmFatLiberacaoCliente.pSalvaProdutosTravaPreco(strNumLib: String);
var
  qryProdutosTrava: TUniQuery;
  strAutInc: String;
begin
  if not Assigned(cdsVenda) then
    Exit;

  if not cdsVenda.Active then
    Exit;

  if cdsVenda.RecordCount <= 0 then
    Exit;

  cdsVenda.First;

  qryProdutosTrava := fCriaQuery;

  try
    try
      strAutInc := fRetAutoIncrem('TPMGER', VS_strCodEmp);

      qryProdutosTrava.Close;
      qryProdutosTrava.SQL.Clear;
      qryProdutosTrava.SQL.Add('INSERT INTO TPMGER(AUTOINCREM, GER_OPESOL, GER_NUMLIB)');
      qryProdutosTrava.SQL.Add('VALUES(:AUTINC, :OPESOL, :NUMLIB)');

      qryProdutosTrava.ParamByName('AUTINC').AsString := strAutInc;
      qryProdutosTrava.ParamByName('OPESOL').AsString := strLoginUsuarioLogado;
      qryProdutosTrava.ParamByName('NUMLIB').AsString := strNumLib;

      qryProdutosTrava.ExecSQL;

      qryProdutosTrava.Close;
      qryProdutosTrava.SQL.Clear;
      qryProdutosTrava.SQL.Add('INSERT INTO TPMDET(AUTOINCREM, DET_SEQGER, DET_CODITE, DET_DESITE, DET_PREORI, DET_DESCON,');
      qryProdutosTrava.SQL.Add('                   DET_PRENOV, DET_PRECUS, DET_MARLIQ, DET_PREPER, DET_PREAUT, DET_SEQFDO)');
      qryProdutosTrava.SQL.Add('VALUES(:AUTINC, :SEQGER, :CODITE, :DESITE, :PREORI, :DESCON,');
      qryProdutosTrava.SQL.Add('       :PRENOV, :PRECUS, :MARLIQ, :PREPER, :PREAUT, :SEQFDO)');

      while not cdsVenda.Eof do
      begin
        qryProdutosTrava.Close;
        qryProdutosTrava.ParamByName('AUTINC').AsString := fRetAutoIncrem('TPMDET', VS_strCodEmp);
        qryProdutosTrava.ParamByName('SEQGER').AsString := strAutInc;
        qryProdutosTrava.ParamByName('CODITE').AsString := cdsVenda.FieldByName('ITE_CODITE').AsString;
        qryProdutosTrava.ParamByName('DESITE').AsString := cdsVenda.FieldByName('ITE_DESITE').AsString;
        qryProdutosTrava.ParamByName('PREORI').AsFloat := cdsVenda.FieldByName('ITE_UNIORI').AsFloat;
        qryProdutosTrava.ParamByName('DESCON').AsFloat := ((cdsVenda.FieldByName('ITE_UNITAR').AsFloat * 100) / cdsVenda.FieldByName('ITE_UNIORI').AsFloat);
        qryProdutosTrava.ParamByName('PRENOV').AsFloat := cdsVenda.FieldByName('ITE_UNITAR').AsFloat;
        qryProdutosTrava.ParamByName('PRECUS').AsFloat := cdsVenda.FieldByName('ITE_PRECU2').AsFloat;
        qryProdutosTrava.ParamByName('MARLIQ').AsFloat := cdsVenda.FieldByName('ITE_MARLUC').AsFloat;
        qryProdutosTrava.ParamByName('PREPER').AsFloat := cdsVenda.FieldByName('ITE_PREMIN').AsFloat;
        qryProdutosTrava.ParamByName('PREAUT').AsFloat := cdsVenda.FieldByName('ITE_PREMIN').AsFloat;
        qryProdutosTrava.ParamByName('SEQFDO').AsString := cdsVenda.FieldByName('AUTOINCREM').AsString;
        qryProdutosTrava.ExecSQL;

        cdsVenda.Next;
      end;
    except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmFatLiberacaoBloqueios.pSalvaProdutosTravaPreco');
      End;
    end;
  finally
    FreeAndNil(qryProdutosTrava);
  end;
end;

procedure TfrmFatLiberacaoCliente.pSetarVisibilidadeQtdMsgNaoLida(const intQtdMsg: Integer);
begin
  If (intQtdMsg > 99) Then
    lblQtdMsg.Caption := '+99'
  Else
    lblQtdMsg.Caption := IntToStr(intQtdMsg);
  pnlShapeQtdMsgPen.Visible := (intQtdMsg > 0);
  If (pnlShapeQtdMsgPen.Visible) Then
    btnMensagens.Font.Color := clBlue
  Else
    btnMensagens.Font.Color := clBlack;
end;

procedure TfrmFatLiberacaoCliente.pAtualizarBotaoMensagens(Sender : TObject);
begin
  pSetarVisibilidadeQtdMsgNaoLida(TfrmCadMsg.fGetQtdMensagensNaoLidas);
end;

end.


