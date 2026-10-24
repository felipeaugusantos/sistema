unit untEntConfPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  untEntConferenciaFuncoes, BitBtnLockedIncrem, MemDS,
  DBAccess, Datasnap.Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, System.UITypes,
  StrUtils,
  untSalvaDadosInterface;

type
  TfrmEntConfPedidos = class(TfrmPaiOrdena)
    btnConfirma: TBitBtnLocked;
    btnSeleciona: TBitBtnLocked;
    btnItensPend: TBitBtnLocked;
    shpGarantia: TShape;
    Label1: TLabel;
    btnSelTodos: TBitBtnLocked;
    btnReqAssoc: TBitBtnLocked;
    Label2: TLabel;
    rbnExibirPerguta: TRadioButton;
    rbnSemprePermitirSelecao: TRadioButton;
    rbnNaoPermitirSelecao: TRadioButton;
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnItensPendClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnSelTodosClick(Sender: TObject);
    procedure btnReqAssocClick(Sender: TObject);
    procedure rbnExibirPergutaClick(Sender: TObject);
  private
    { Private declarations }
    FrbnAnterior: TRadioButton;
    FstrPedGar: String;
    objSalInt: TSalvaInterface;
    FstrPedidos: String;
    strForSel: String;

    blnCotDor: Boolean;
    intMoeda: Integer;
    function fValidarPedidoConferido: Boolean;
    function fValidarPedidoGarantia: Boolean;
    function fValidarPedidoFornecedor: Boolean;
    function fValidarPedidoMoeda: Boolean;
    procedure pSelecionarPedidosFornecedorDiferente(
      strPedidoFornecedor: String);
    function fValidarMensagem(strMensagem, strTipo: String): String;
    procedure pAlterarAcaoForDif;

  public
    { Public declarations }
    blnPreNota: Boolean;
    blnSalvaFornecedor: Boolean;

    strCodFor : String;
    objConEnt : TConfereEntrada;
    stlRegSel : TStringList;
    blnSelGarantia : Boolean;
    blnConferenciaPorPedido : Boolean;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    procedure pAddListaQuery; Override;
  end;

implementation

uses untFuncoesSimples, untMostraItensPendentes, untFuncoesRel;

{$R *.dfm}

function TfrmEntConfPedidos.fGetSql(blnLike: Boolean): String;
Begin
  Result := objConEnt.fSqlSelecPedidos(blnLike, blnPreNota);
End;

procedure TfrmEntConfPedidos.btnItensPendClick(Sender: TObject);
begin

  If Not cdsConsulta.IsEmpty Then

     TfrmMostraItensPendentes.pMostraItensPendentes(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                                    cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
                                                    cdsConsulta.FieldByName('PCG_CODEMP').AsString);

end;

procedure TfrmEntConfPedidos.btnReqAssocClick(Sender: TObject);
begin
  If Not cdsConsulta.IsEmpty Then
    if Assigned(prcExecutaRelatorio) then
      prcExecutaRelatorio(350, 16152, [16152],
        ['NUMPED', 'ESPDOC', 'CODEMP'],
        [cdsConsulta.FieldByName('PCG_NUMPED').AsString,
         cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
         cdsConsulta.FieldByName('PCG_CODEMP').AsString],
        Sender, nil, True);

end;

procedure TfrmEntConfPedidos.btnSelecionaClick(Sender: TObject);
begin
  inherited;

  objConEnt.acoAcaoForDif  := acoPerguntar;
  objConEnt.blnMarcarTodos := False;

  pAddListaQuery;
  dbgConsulta.Refresh;
end;

procedure TfrmEntConfPedidos.btnSelTodosClick(Sender: TObject);
Var
  strPedidosConferidos: String;
  strPedidosGarantias: String;
  strPedidoMoeda: String;
  strPedidoFornecedor: String;
begin
  inherited;
  cdsConsulta.First;
  intMoeda := cdsConsulta.FieldByName('PCG_MOEDA_').AsInteger;
  FstrPedGar := cdsConsulta.FieldByName('PEDGAR').AsString;
  While Not cdsConsulta.Eof Do
  Begin
    objConEnt.acoAcaoForDif := acoLiberarTodos;

    case AnsiIndexText(true.ToString,[fValidarPedidoGarantia.ToString,
      fValidarPedidoConferido.ToString,
      fValidarPedidoMoeda.ToString,
      fValidarPedidoFornecedor.ToString
      ]) Of
      0: strPedidosGarantias := strPedidosGarantias +
           cdsConsulta.FieldByName('PCG_NUMPED').AsString + #13;

      1: strPedidosConferidos := strPedidosConferidos +
           cdsConsulta.FieldByName('PCG_NUMPED').AsString + #13;

      2: strPedidoMoeda := strPedidoMoeda +
           cdsConsulta.FieldByName('PCG_NUMPED').AsString + #13;

      3:
      Begin
        If stlListSelecao.IndexOf(fRetChaveLista) > -1 Then
          pAddListaQuery
        ELse If rbnExibirPerguta.Checked Then
          strPedidoFornecedor := strPedidoFornecedor +
            cdsConsulta.FieldByName('PCG_NUMPED').AsString + #13
        Else If rbnSemprePermitirSelecao.Checked Then
          pAddListaQuery;
      End
    Else
      pAddListaQuery;
    End;

    cdsConsulta.Next;
  End;

  If Not fEmptyStr(strPedidoFornecedor) Then
    pSelecionarPedidosFornecedorDiferente(strPedidoFornecedor);


  FstrPedidos :=
    fValidarMensagem(strPedidosConferidos,'CONFERIDO') + #13 +
    fValidarMensagem(strPedidosGarantias,'GARANTIA')  + #13 +
    fValidarMensagem(strPedidoMoeda,'MOEDA')  + #13 ;

  If Not fEmptyStr(FstrPedidos) Then
    fMensagem('ATENÇÃO!', FstrPedidos, ['&Ok'],
    1,
    False,
    1,
    0,
    False,
    0,
    False,
    False,
    False,
    0,
    0,
    FstrPedidos.CountChar(#13));

  objConEnt.acoAcaoForDif  := acoPerguntar;
  intMoeda := -1;
End;

function TfrmEntConfPedidos.fValidarMensagem(strMensagem: String; strTipo: String): String;
Begin
  Result := '';
  If Not fEmptyStr(strMensagem) Then
    case AnsiIndexText(strTipo, ['GARANTIA','CONFERIDO','MOEDA']) of
      0: Result := IfThen(FstrPedGar.Equals('S'),'Só é permitido selecionar pedidos originados de garantia!',
        'Os pedidos abaixo são originados de garantia e não permite seleção:') + #13 +
        strMensagem;
      1: Result := 'Os pedidos abaixo já foram conferidos e não permite seleção:' + #13 +
          strMensagem;
      2: Result := 'Os pedidos abaixo não são da mesma moeda:' + #13 +
        strMensagem;
    End;
end;

procedure TfrmEntConfPedidos.pSelecionarPedidosFornecedorDiferente(strPedidoFornecedor: String);
Var
  strPedido: String;
Begin
  FstrPedidos := 'Os fornecedores do XML e do Pedido de Compra são diferentes, porém seus CNPJ''s são do mesmo grupo de empresas.' + #13 +
      'Será possivel trocar o fornecedor do pedido automaticamente. Deseja prosseguir?' + #13 + strPedidoFornecedor;

  If fMensagem('', FstrPedidos, ['Sim', 'Não'], 1,False, 1,0,False, 0, False,False,False,0,0, FstrPedidos.CountChar(#13)) = 1 Then
    For strPedido In strPedidoFornecedor.Split([#13]) Do
      If cdsConsulta.Locate('PCG_NUMPED', strPedido, []) Then
      Begin
        objConEnt.acoAcaoForDif := acoLiberarTodos;
        pAddListaQuery;
      End;
End;

procedure TfrmEntConfPedidos.rbnExibirPergutaClick(Sender: TObject);
Var
  rbnSelecao: TRadioButton absolute Sender;
begin
  inherited;

  If Not (FrbnAnterior.Equals(rbnSelecao)) Then
  Begin
    if (stlListSelecao.Count > 0) Then
      if (fMensagem('', 'Os pedidos selecionados serão desmarcados. Deseja Prosseguir!', ['&Sim','&Não']) = 1) Then
      Begin
        FrbnAnterior := rbnSelecao;
        pDesmarcaTodos
      End
      else
        FrbnAnterior.Checked := True
    Else
      FrbnAnterior := rbnSelecao;
  End;


  pAlterarAcaoForDif;
end;

function TfrmEntConfPedidos.fValidarPedidoConferido: Boolean;
Begin
  Result := cdsConsulta.FieldByName('CONFER').AsString = 'S';
End;

function TfrmEntConfPedidos.fValidarPedidoGarantia: Boolean;
Begin
  Result := cdsConsulta.FieldByName('PEDGAR').AsString = 'S';
End;

function TfrmEntConfPedidos.fValidarPedidoMoeda: Boolean;
Begin
  Result := intMoeda <> cdsConsulta.FieldByName('PCG_MOEDA_').AsInteger;
End;

function TfrmEntConfPedidos.fValidarPedidoFornecedor: Boolean;
Begin
  Result := (strCodFor <> cdsConsulta.FieldByName('PCG_CODFOR').AsString);
End;

procedure TfrmEntConfPedidos.dbgConsultaDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If TDBGridCitel(Sender).DataSource.DataSet.FieldByName('PEDGAR').AsString = 'S' Then
  Begin
    TDBGridCitel(Sender).Canvas.Font.Color := shpGarantia.Brush.Color;
    TDBGridCitel(Sender).Canvas.FillRect(Rect);
    TDBGridCitel(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmEntConfPedidos.FormShow(Sender: TObject);
begin
  inherited;

  stlListSelecao.Clear;
 // objConEnt.stlPedidos.Text;

  blnQuoteLista := False;
  strCampoLista := 'AUTOINCREM';
  blnSempreRelerBanco := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pLimpaPesquisa;
  fAbreConsulta(True);

  strForSel := strCodFor;

  If Not blnPreNota Then
    pSetColunaVisivel('PRE_NOTAS', False);

  If Not fCfgSis('COTDOR', varBoolean) Then
    pSetColunaVisivel('EM_DOLAR', False);

end;

procedure TfrmEntConfPedidos.pAlterarAcaoForDif;
Begin
  If Assigned(objConEnt) Then
    If objConEnt.acoAcaoForDif <> acoLiberarTodos Then
      If rbnExibirPerguta.Checked Then
        objConEnt.acoAcaoForDif  := acoPerguntar
      else If rbnSemprePermitirSelecao.Checked Then
        objConEnt.acoAcaoForDif  := acoLiberarTodos
      else
        objConEnt.acoAcaoForDif  := acoNaoLiberarTodos;
End;

procedure TfrmEntConfPedidos.pAddListaQuery;
Begin
  pAlterarAcaoForDif;

  If objConEnt.fValidaPedidoSelec(cdsConsulta, strForSel, blnSalvaFornecedor) Then
  Begin

    If (Not fInLista) Then
    Begin

      If blnSelGarantia And (not fPedidoDeCompraOriundoDeGarantia(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                                                  cdsConsulta.FieldByName('PCG_CODEMP').AsString)) Then
      Begin
        fMensagem('', 'Só é permitido selecionar pedidos originados de garantia!', ['&Ok']);
        Exit;
      End

      Else
      If (not blnSelGarantia) And (fPedidoDeCompraOriundoDeGarantia(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                                                    cdsConsulta.FieldByName('PCG_CODEMP').AsString)) Then
      Begin
        fMensagem('', 'Só é permitido selecionar pedidos que não são originados de garantia!', ['&Ok']);
        Exit;
      End;

      If blnCotDor And (intMoeda <> -1) And (intMoeda <> cdsConsulta.FieldByName('PCG_MOEDA_').AsInteger) Then
      Begin
        pMensagemOk('Selecione somente pedidos na mesma moeda!');
        Exit;
      End;

      intMoeda := cdsConsulta.FieldByName('PCG_MOEDA_').AsInteger;
    End;

    inherited pAddListaQuery;

    If stlListSelecao.Count = 0 Then
    Begin
      strForSel := strCodFor;
      intMoeda  := -1;
    End

    Else If fEmptyStr(strCodFor) Then
      strForSel := cdsConsulta.FieldByName('PCG_CODFOR').AsString;
  End;

  If (stlListSelecao.Count = 1) Then
    blnSelGarantia := fPedidoDeCompraOriundoDeGarantia(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                                       cdsConsulta.FieldByName('PCG_CODEMP').AsString);

End;

procedure TfrmEntConfPedidos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  objSalInt.fSalvaDados('', Self.Name, strLoginUsuarioLogado, True);
  If (ModalResult = mrOk) And (stlListSelecao.Count = 0) Then
  Begin
    fMensagem('','Selecione um pedido para conferência!', ['&Ok']);
    Action := caNone;
  End;

  If Assigned(stlRegSel) Then
    stlRegSel.Text:=stlListSelecao.Text;

  inherited;
end;

procedure TfrmEntConfPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  FrbnAnterior := rbnExibirPerguta;
  intMoeda  := -1;
  strCodFor := '';
  strForSel := '';
  blnPreNota := False;

  blnSalvaFornecedor := True;
  blnSelGarantia := False;
  blnConferenciaPorPedido := False;

  blnCotDor := fCfgSis('COTDOR', varBoolean);
  objSalInt := TSalvaInterface.Create(Self);
  objSalInt.fCarregaDados('', Self, Self.Name, strLoginUsuarioLogado);
end;

procedure TfrmEntConfPedidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_SPACE: btnSeleciona.Click;
    VK_F10  : Begin
                btnConfirma.Click;
                Key := 0;
              End;

    VK_F6   : btnSelTodos.Click;

    VK_F11 : btnItensPend.Click;
  End;

end;

End.

