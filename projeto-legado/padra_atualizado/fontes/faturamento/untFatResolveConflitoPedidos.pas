unit untFatResolveConflitoPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.ComCtrls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, ComboBoxFocus, EditFocus,
  untFuncFatTypes, Uni, untFuncFat,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao,
  untMsgLiberacao;

type
  TConflitoPedido = (cpCondicao, cpTransportadora, cpDocTransportadora);

type
  TrecConflito=record
    strCodCnd: String;
    strConPag: String;
    strCodFpg: String;
    strForPag: String;
    blnCndEsp: Boolean;
  end;

type
  TColuna = record
    strNome: String;
    intTamanho : Integer;
  End;

type
  TfrmFatResolveConflitoPedidos = class(TfrmPai, IResolveConflitosPedido)
    pnlGridPedidos: TPanel;
    pnlConflitos: TPanel;
    cxgGriidCitelLevel1: TcxGridLevel;
    cxgGriidCitelTableView1: TcxGridDBTableViewCitel;
    cxgGriidCitel: TcxGridCitel;
    pgcConflitos: TPageControl;
    tbsTransportadoras: TTabSheet;
    tbsCondicao: TTabSheet;
    Label1: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    Label2: TLabel;
    cmbConPag: TComboBoxFocus;
    Label3: TLabel;
    edtForPag: TEditFocus;
    dtsPedidos: TDataSource;
    btnConfirmaDados: TBitBtnLocked;
    lblLegenda: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbConPagCloseUp(Sender: TObject);
  private
    { Private declarations }
    strCliente : String;
    qryPedido : TUniQuery;
    arrColunas : Array Of TColuna;
    objLiberacao : TLiberacao;
    function fSQLConflitoCondicao: String;
    function fSQLCOnflitoTransportadora: String;
    function fSQLCOnflitoDocTransportadora: String;
    function fGetWhere: String;
    procedure pCarregaCondicoes;
    function fGetOpcDocDescricao: String;
    procedure pSetarAtributoColunas;
    function pRetConPagAtualizada(strConPagRef: String; dtaUltDtaAlt: TDateTime; dtaDtaEnt, dtaPrevis: TDateTime; strCodCnd, strCodFpg, strConPag: String): String;
  public
    { Public declarations }
    tipConflPedido : TConflitoPedido;
    recDocumentos : TDocumentos;
    strOpcDoc : String;
    blnConfirma : Boolean;
    fatVenda  : TFatVenda;
    arrConflitos: Array Of TrecConflito;
    procedure pAddDocumentos(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatResolveConflitoPedidos: TfrmFatResolveConflitoPedidos;

implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untFuncoesSimples, untFuncoes, untConstantes;

{ TfrmFatResolveConflitoPedidos }

procedure TfrmFatResolveConflitoPedidos.btnConfirmaDadosClick(Sender: TObject);
  var
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;
    strDesOpc : String;
    strTitulo : String;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  objLiberacao.Clear;

  strDesOpc := fGetOpcDocDescricao;

  If Not fEmptyStr(strDesOpc) Then
    strDesOpc := strDesOpc + ' - ';

  strtitulo := '';
  Case tipConflPedido Of
    cpCondicao:
    Begin
      strTitulo := strDesOpc + 'CONDIÇÕES DIFERENTES';
      objLiberacao.objMsgLibera.pAddTexto(strTitulo);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'PEDIDO'          , 20 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DT.EMISSÃO'      , 10 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'CLIENTE'         , 30 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'VR.PEDIDO'       , 13 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'COND.PAGAMENTO'  , 18 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'FORMA PAGAMENTO' , 15 , alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      qryPedido.First;
      While Not qryPedido.Eof Do
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('PEDIDO'          , qryPedido.FieldByName('PEDIDO').AsString                                 , 20 , alEsquerda);
        objLinha.pAddColuna('DT.EMISSÃO'      , FormatDateTime('dd/mm/yyyy', qryPedido.FieldByName('DTAENT').AsDateTime) , 10 , alCentro  );
        objLinha.pAddColuna('CLIENTE'         , qryPedido.FieldByName('CLIENT').AsString                                 , 30 , alEsquerda);
        objLinha.pAddColuna('VR.PEDIDO'       , FloatToStrF(qryPedido.FieldByName('VLRCON').AsFloat, ffFixed, 12, 2)     , 13 , alDireita );
        objLinha.pAddColuna('COND.PAGAMENTO'  , fFormataCondPag(qryPedido.FieldByName('CONPAG').AsString)                , 18 , alEsquerda);
        objLinha.pAddColuna('FORMA PAGAMENTO' , qryPedido.FieldByName('FORMAP').AsString                                 , 15 , alEsquerda);
        objTabela.lstLinhas.Add(objLinha);

        qryPedido.Next;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);


      objLiberacao.objMsgLibera.pAddSeparador(119);
      objLiberacao.objMsgLibera.pAddTextoCaption('Condição Pagamento escolhida para Faturamento' , cmbConPag.Text);
      objLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagamento escolhida para Faturamento' , edtForPag.Text);
      If lblLegenda.Visible Then
        objLiberacao.objMsgLibera.pAddTexto(lblLegenda.Caption);

      objLiberacao.objMsgLibera.pAddSeparador(119);
    End;
    cpTransportadora:
    Begin
      strTitulo := strDesOpc + 'TRANSPORTADORAS DIFERENTES';
      objLiberacao.objMsgLibera.pAddTexto(strTitulo);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'PEDIDO'          , 20 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DT.EMISSÃO'      , 10 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'CLIENTE'         , 30 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'VR.PEDIDO'       , 13 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'TRANSPORTADORA'  , 35 , alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      qryPedido.First;
      While Not qryPedido.Eof Do
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('PEDIDO'          , qryPedido.FieldByName('PEDIDO').AsString                                 , 20 , alEsquerda , teAutcom);
        objLinha.pAddColuna('DT.EMISSÃO'      , FormatDateTime('dd/mm/yyyy', qryPedido.FieldByName('DTAENT').AsDateTime) , 10 , alCentro   , teAutcom);
        objLinha.pAddColuna('CLIENTE'         , qryPedido.FieldByName('CLIENT').AsString                                 , 30 , alEsquerda , teAutcom);
        objLinha.pAddColuna('VR.PEDIDO'       , FloatToStrF(qryPedido.FieldByName('VLRCON').AsFloat, ffFixed, 12, 2)     , 13 , alDireita  , teAutcom);
        objLinha.pAddColuna('TRANSPORTADORA'  , qryPedido.FieldByName('TRANSP').AsString                                 , 35 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);
        qryPedido.Next;
      End;

      objLiberacao.objMsgLibera.pAddSeparador(119);
      objLiberacao.objMsgLibera.pAddTextoCaption('NOVA TRANSPORTADORA' , edtCodTra.Text + '-' + edtNomTra.Text);
      objLiberacao.objMsgLibera.pAddSeparador(119);
    End;
    cpDocTransportadora:
    Begin
      strTitulo := strDesOpc + 'TRANSPORTADORAS DIFERENTES';
      objLiberacao.objMsgLibera.pAddTexto(strTitulo);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'DOCUMENTO'       , 20 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DT.EMISSÃO'      , 10 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'CLIENTE'         , 30 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'VR.DOCUMENTO'    , 13 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'TRANSPORTADORA'  , 35 , alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      qryPedido.First;
      While Not qryPedido.Eof Do
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DOCUMENTO'       , qryPedido.FieldByName('DOCUMENTO').AsString                              , 20 , alEsquerda , teAutcom);
        objLinha.pAddColuna('DT.EMISSÃO'      , FormatDateTime('dd/mm/yyyy', qryPedido.FieldByName('DTAENT').AsDateTime) , 10 , alCentro   , teAutcom);
        objLinha.pAddColuna('CLIENTE'         , qryPedido.FieldByName('CLIENT').AsString                                 , 30 , alEsquerda , teAutcom);
        objLinha.pAddColuna('VR.DOCUMENTO'    , FloatToStrF(qryPedido.FieldByName('VLRCON').AsFloat, ffFixed, 12, 2)     , 13 , alDireita  , teAutcom);
        objLinha.pAddColuna('TRANSPORTADORA'  , qryPedido.FieldByName('TRANSP').AsString                                 , 35 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);
        qryPedido.Next;
      End;
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.objMsgLibera.pAddSeparador(119);
      objLiberacao.objMsgLibera.pAddTextoCaption('NOVA TRANSPORTADORA' , edtCodTra.Text + '-' + edtNomTra.Text);
      objLiberacao.objMsgLibera.pAddSeparador(119);
    End;
  End;

  If tipConflPedido = cpDocTransportadora Then
    objLiberacao.strDirAce := 'TRADOC'
  Else
    objLiberacao.strDirAce := IIF(tipConflPedido = cpCondicao,  IIF(strOpcDoc = 'EX', 'CNEXCP', 'CNDICP'), 'TREXCP');

  objLiberacao.strMsgSen :=strTitulo;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCliente := strCliente;

  If objLiberacao.fLibera Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmFatResolveConflitoPedidos.cmbConPagCloseUp(Sender: TObject);
begin
  inherited;
  edtForPag.Text := '';
  If (cmbConPag.ItemIndex >= 0) Then
  Begin
    {SE CFG_CNDPES = "S" E A CONDIÇÃO SELECIONADA FOR "ESPECIAL", CHECAR A LISTA DE PRODUTOS JÁ INSERIDOS - KM}
    if ((fatVenda.blnCondicaoEspecial) and (arrConflitos[cmbConPag.ItemIndex].blnCndEsp)) then
    Begin
      if fatVenda.fProdutoForaCondEsp(arrConflitos[cmbConPag.ItemIndex].strCodCnd) then
      Begin
        fMensagem('ATENÇÃO!','Essa condição de pagamento não poderá ser utilizada pois existem produtos não permitidos! ' +
                    'Favor verificar e excluir os itens fora da política de parcelamento.', ['&Ok']);
      End;
    End
    else
      edtForPag.Text := arrConflitos[cmbConPag.ItemIndex].strForPag;
  End;
end;

procedure TfrmFatResolveConflitoPedidos.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp : TConsultasArray;
begin
  inherited;
  If fPesqTransportadora(conTraCompleta, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatResolveConflitoPedidos.fGetOpcDocDescricao: String;
begin
  Result := '';
  If (strOpcDoc = 'CP') Then
    Result := 'CONFIRMAÇÃO DE PEDIDOS'
  Else If (strOpcDoc = 'EX') Then
    Result := 'EXPEDIÇÃO';
end;

function TfrmFatResolveConflitoPedidos.fGetWhere: String;

  Var
    intCnt : Integer;
    strWhere : String;

  function fGetCondicoes: String;
  begin
    Result := '';
    Result := Result + ' (FGO_NUMDOC = ' + QuotedStr(recDocumentos[intCnt].strNumDoc) + ' AND ';
    Result := Result + '  FGO_ESPDOC = ' + QuotedStr(recDocumentos[intCnt].strEspDoc) + ' AND ';
    Result := Result + '  FGO_CODEMP = ' + QuotedStr(recDocumentos[intCnt].strCodEmp) + ' AND ';
    Result := Result + '  FGO_CODCLI = ' + QuotedStr(recDocumentos[intCnt].strCodCli) + ') ';
  end;

  function fGetDocCondicoes: String;
  begin
    Result := '';
    Result := Result + ' (GER_NUMDOC = ' + QuotedStr(recDocumentos[intCnt].strNumDoc) + ' AND ';
    Result := Result + '  GER_ESPDOC = ' + QuotedStr(recDocumentos[intCnt].strEspDoc) + ' AND ';
    Result := Result + '  GER_CODEMP = ' + QuotedStr(recDocumentos[intCnt].strCodEmp) + ' AND ';
    Result := Result + '  GER_CODCLI = ' + QuotedStr(recDocumentos[intCnt].strCodCli) + ') ';
  end;

begin
  strWhere := '';

  For intCnt := Low(recDocumentos) To High(recDocumentos) Do
  Begin
    If fEmptyStr(strWhere) Then
      strWhere := IIF(tipConflPedido = cpDocTransportadora, fGetDocCondicoes, fGetCondicoes)
    Else
      strWhere := strWhere + ' OR ' + IIF(tipConflPedido = cpDocTransportadora, fGetDocCondicoes, fGetCondicoes);
  End;

  If fEmptyStr(strWhere) Then
    Result := ' WHERE FALSE'
  Else
    Result := ' WHERE ' + strWhere;
end;

procedure TfrmFatResolveConflitoPedidos.FormActivate(Sender: TObject);
begin
  inherited;
  Case tipConflPedido Of
    cpCondicao: pSetFocus(cmbConPag);
    cpTransportadora, cpDocTransportadora: pSetFocus(edtCodTra);
  End;
end;

procedure TfrmFatResolveConflitoPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  qryPedido := fCriaQuery(Self);
  objLiberacao := TLiberacao.Create;
  FillChar(recDocumentos, SizeOf(recDocumentos), #0);
  strCliente := '';
  strOpcDoc := '';
  blnConfirma := False;
end;

procedure TfrmFatResolveConflitoPedidos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryPedido);
  FreeAndNil(objLiberacao);
end;

procedure TfrmFatResolveConflitoPedidos.FormShow(Sender: TObject);
begin
  inherited;

  lblLegenda.Visible := False;
  blnConfirma := False;

  Case tipConflPedido Of
    cpCondicao:
    Begin
      With qryPedido Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add( fSQLConflitoCondicao );
        Open;

        TStringField(FieldbyName('CONPAG')).EditMask := MASK_CONPAG;
        TFloatField(FieldbyName('VLRCON')).DisplayFormat := '#,##0.00';
      End;

      pCarregaCondicoes;

      tbsCondicao.TabVisible := True;
      tbsTransportadoras.TabVisible := False;

      SetLength(arrColunas, 10);
      arrColunas[0].strNome := 'Pedido';
      arrColunas[0].intTamanho := 120;
      arrColunas[1].strNome := 'Dt.Emissão';
      arrColunas[1].intTamanho := 63;
      arrColunas[2].strNome := 'Cliente';
      arrColunas[2].intTamanho := 222;
      arrColunas[3].strNome := 'Vr.Pedido';
      arrColunas[3].intTamanho := 103;
      arrColunas[4].strNome := 'Cond.Pagamento';
      arrColunas[4].intTamanho := 150;
      arrColunas[5].strNome := 'Forma de Pagamento';
      arrColunas[5].intTamanho := 130;

      arrColunas[6].intTamanho := 0;
      arrColunas[7].intTamanho := 0;
      arrColunas[8].intTamanho := 0;
      arrColunas[9].intTamanho := 0;

      Caption := 'Condições Diferentes';
    End;

    cpTransportadora:
    Begin
      With qryPedido Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add( fSQLCOnflitoTransportadora );
        Open;

        TFloatField(FieldbyName('VLRCON')).DisplayFormat := '0.00';
      End;

      tbsTransportadoras.TabVisible := True;
      tbsCondicao.TabVisible := False;

      SetLength(arrColunas, 5);
      arrColunas[0].strNome := 'Pedido';
      arrColunas[0].intTamanho := 120;
      arrColunas[1].strNome := 'Dt.Emissão';
      arrColunas[1].intTamanho := 63;
      arrColunas[2].strNome := 'Cliente';
      arrColunas[2].intTamanho := 222;
      arrColunas[3].strNome := 'Vr.Pedido';
      arrColunas[3].intTamanho := 103;
      arrColunas[4].strNome := 'Transportadora';
      arrColunas[4].intTamanho := 258;

      Caption := 'Transportadoras Diferentes';
    End;

    cpDocTransportadora:
    Begin
      With qryPedido Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add( fSQLCOnflitoDocTransportadora );
        Open;

        TFloatField(FieldbyName('VLRCON')).DisplayFormat := '0.00';
      End;

      tbsTransportadoras.TabVisible := True;
      tbsCondicao.TabVisible := False;

      SetLength(arrColunas, 5);
      arrColunas[0].strNome := 'Documento';
      arrColunas[0].intTamanho := 120;
      arrColunas[1].strNome := 'Dt.Emissão';
      arrColunas[1].intTamanho := 63;
      arrColunas[2].strNome := 'Cliente';
      arrColunas[2].intTamanho := 222;
      arrColunas[3].strNome := 'Vr.Documento';
      arrColunas[3].intTamanho := 103;
      arrColunas[4].strNome := 'Transportadora';
      arrColunas[4].intTamanho := 258;

      Caption := 'Transportadoras Diferentes';
    End;
  End;

  dtsPedidos.DataSet := qryPedido;
  cxgGriidCitelTableView1.ClearItems;
  cxgGriidCitelTableView1.DataController.CreateAllItems;
  pSetarAtributoColunas;
end;

function TfrmFatResolveConflitoPedidos.fSQLConflitoCondicao: String;
begin
  Result := '';
  Result := Result + ' SELECT CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS PEDIDO, ';
  Result := Result + '        FGO_DTAENT AS DTAENT, ';
  Result := Result + '        CONCAT(FGO_CODCLI, "-", CLI_NOMCLI) AS CLIENT, ';
  Result := Result + '        FGO_VLRCON AS VLRCON, ';
  Result := Result + '        FGO_CONPAG AS CONPAG, ';
  Result := Result + '        CONCAT(FGO_CODFPG, "-", FPG_DESCRI) AS FORMAP, ';
  Result := Result + '        FGO_CODCND AS CODCND, ';
  Result := Result + '        FGO_PREVIS AS PREVIS, ';
  Result := Result + '        FGO_CODFPG AS CODFPG, ';
  Result := Result + '        FGO_ULTALT AS ULTALT  ';
  Result := Result + '   FROM FATGOR ';
  Result := Result + '   JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ';
  Result := Result + '   LEFT JOIN CADFPG ON FPG_CODIGO = FGO_CODFPG ';
  Result := Result + fGetWhere;
end;

function TfrmFatResolveConflitoPedidos.fSQLCOnflitoDocTransportadora: String;
begin
  Result := '';
  Result := Result + ' SELECT CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS DOCUMENTO, ';
  Result := Result + '        GER_DTAENT AS DTAENT, ';
  Result := Result + '        CONCAT(GER_CODCLI, "-", CLI_NOMCLI) AS CLIENT, ';
  Result := Result + '        GER_VLRCON AS VLRCON, ';
  Result := Result + '        CONCAT(GER_CODTRA, "-", TRA_NOMTRA) AS TRANSP ';
  Result := Result + '   FROM MOVGER ';
  Result := Result + '   JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
  Result := Result + '   JOIN CADTRA ON TRA_CODTRA = GER_CODTRA ';
  Result := Result + fGetWhere;
end;

function TfrmFatResolveConflitoPedidos.fSQLCOnflitoTransportadora: String;
begin
  Result := '';
  Result := Result + ' SELECT CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS PEDIDO, ';
  Result := Result + '        FGO_DTAENT AS DTAENT, ';
  Result := Result + '        CONCAT(FGO_CODCLI, "-", CLI_NOMCLI) AS CLIENT, ';
  Result := Result + '        FGO_VLRCON AS VLRCON, ';
  Result := Result + '        CONCAT(FGO_CODTRA, "-", TRA_NOMTRA) AS TRANSP ';
  Result := Result + '   FROM FATGOR ';
  Result := Result + '   JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ';
  Result := Result + '   JOIN CADTRA ON TRA_CODTRA = FGO_CODTRA ';
  Result := Result + fGetWhere;
end;

function TfrmFatResolveConflitoPedidos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodTra) And (tbsTransportadoras.TabVisible) Then
  Begin
    If fEmptyStr(edtCodTra.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A nova transportadora deve ser preenchida!', ['&OK']);
      Result := False;
    End
    Else
    Begin
      edtNomTra.Text := fRetNomTransportadora(edtCodTra.Text);
      If fEmptyStr(edtNomTra.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Transportadora Incorreta!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = cmbConPag) And (tbsCondicao.TabVisible) Then
  Begin
    If (cmbConPag.ItemIndex < 0) Then
    Begin
      edtForPag.Text := '';
      fMensagem('ATENÇÃO!', 'A nova condição deve ser preenchida!', ['&OK']);
      Result := False;
    End
    Else
    Begin
      {SE A CONDIÇÃO SELECIONADA FOR "ESPECIAL", CHECAR A LISTA DE PRODUTOS JÁ INSERIDOS - KM}
      if ((fatVenda.blnCondicaoEspecial) and (arrConflitos[cmbConPag.ItemIndex].blnCndEsp)) then
      Begin
        if fatVenda.fProdutoForaCondEsp(arrConflitos[cmbConPag.ItemIndex].strCodCnd) then
        Begin
          fMensagem('ATENÇÃO!','Essa condição de pagamento não poderá ser utilizada pois existem produtos não permitidos! ' +
                      'Favor verificar e excluir os itens fora da política de parcelamento.', ['&Ok']);
          Result := False;
        End;
      End
      else
        edtForPag.Text := arrConflitos[cmbConPag.ItemIndex].strForPag;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatResolveConflitoPedidos.pAddDocumentos(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String);
begin
  SetLength(recDocumentos, Length(recDocumentos) + 1);
  recDocumentos[Length(recDocumentos)-1].strNumDoc := strNumDoc;
  recDocumentos[Length(recDocumentos)-1].strEspDoc := strEspDoc;
  recDocumentos[Length(recDocumentos)-1].strCodEmp := strCodEmp;
  recDocumentos[Length(recDocumentos)-1].strCodCli := strCodCli;

  If fEmptyStr(strCliente) Then
    strCliente := strCodCli;
end;

procedure TfrmFatResolveConflitoPedidos.pCarregaCondicoes;
  Var
    strConPagAtu: String;
    strConPagOri: String;

    procedure pAddArrConflitos(strCodCnd, strConPag, strCodFpg, strForPag: String; blnCndEsp : Boolean);
    begin
      SetLength(arrConflitos, Length(arrConflitos) + 1);
      arrConflitos[Length(arrConflitos)-1].strCodCnd := strCodCnd;
      arrConflitos[Length(arrConflitos)-1].strConPag := strConPag;
      arrConflitos[Length(arrConflitos)-1].strCodFpg := strCodFpg;
      arrConflitos[Length(arrConflitos)-1].strForPag := strForPag;
      arrConflitos[Length(arrConflitos)-1].blnCndEsp := blnCndEsp;
    end;

    function fRetConPag(strConOri, strConAtu: String; blnFormatado: Boolean): String;
      Var
        blnComPagAtu: Boolean;
    begin
      blnComPagAtu := (Not fEmptyStr(strConAtu)) And (strConAtu <> strConOri);

      If blnComPagAtu And (Not lblLegenda.Visible) Then
        lblLegenda.Visible := True;

      If blnFormatado Then
      Begin
        If blnComPagAtu Then
          Result := fFormataCondPag(strConOri)+ ' (ORIGINAL) - ' + fFormataCondPag(strConAtu)+ ' (ATUALIZADA) (*)'
        Else
          Result := fFormataCondPag(strConOri);
      End
      Else
      Begin
        If blnComPagAtu Then
          Result := strConAtu
        Else
          Result := strConOri;
      End;
    end;

begin
  cmbConPag.Items.Clear;
  FillChar(arrConflitos, SizeOf(arrConflitos), #0);

  qryPedido.First;
  While Not qryPedido.Eof Do
  Begin
    strConPagAtu := pRetConPagAtualizada(qryPedido.FieldByName('CONPAG').AsString,
                                         qryPedido.FieldByName('ULTALT').AsDateTime,
                                         qryPedido.FieldByName('DTAENT').AsDateTime,
                                         qryPedido.FieldByName('PREVIS').AsDateTime,
                                         qryPedido.FieldByName('CODCND').AsString,
                                         qryPedido.FieldByName('CODFPG').AsString,
                                         qryPedido.FieldByName('CONPAG').AsString);
    strConPagOri := qryPedido.FieldByName('CONPAG').AsString;

    cmbConPag.Items.Add(fRetConPag(strConPagOri, strConPagAtu, True));

    pAddArrConflitos(qryPedido.FieldByName('CODCND').AsString,
                     fRetConPag(strConPagOri, strConPagAtu, False),
                     qryPedido.FieldByName('CODFPG').AsString,
                     qryPedido.FieldByName('FORMAP').AsString,
                     (fRetEspConPag(qryPedido.FieldByName('CODCND').AsString) = 'S'));
    qryPedido.Next;
  End;
end;

function TfrmFatResolveConflitoPedidos.pRetConPagAtualizada(strConPagRef: String; dtaUltDtaAlt: TDateTime; dtaDtaEnt, dtaPrevis: TDateTime;
  strCodCnd, strCodFpg, strConPag: String): String;
  Var
    strTipFor: String;
    strConPagTmp: String;

    dtaGraPedBkp,
    dtaPrevisBkp: TDateTime;
    strConPagBkp: String;

    strConPagOri : String;
begin
  Result := '';

  If Not Assigned(fatVenda) Then
    Exit;

  dtaGraPedBkp := fatVenda.dtaGraPed;
  dtaPrevisBkp := fatVenda.dtaPrevis;
  strConPagBkp := fatVenda.strConPag;

  Try
    strConPagOri := strConPag;

    fatVenda.dtaGraPed := dtaDtaEnt;
    fatVenda.dtaPrevis := dtaPrevis;

    strTipFor := fRetTipoForaConPag(strCodCnd);

    If (strTipFor = 'OUTROS') And (Not fEmptyStr(strConPag)) Then
      strConPagTmp := strConPag
    Else
      strConPagTmp := fRetConPagCodCnd(strCodCnd);

    fatVenda.pAcertaDataGravacaoDataPrevisao(dtaDtaEnt, dtaPrevis);

    fatVenda.strConPag := fRetCondicao(strConPagRef,
                                       dtaUltDtaAlt,
                                       strCodCnd,
                                       strTipFor,
                                       strConPagTmp,
                                       IIF(fatVenda.dtaPreVis > 0, fatVenda.dtaPreVis, VS_Date),
                                       fatVenda.strOpcDoc,
                                       fatVenda.strCodCid);

    If Not fatVenda.fDocumentoParaFornecedor Then
    Begin
      fatVenda.strConPag := fRetCondicaoDiaFixoCliente(strConPagRef,
                                                       dtaUltDtaAlt,
                                                       fatVenda.strCodCli,
                                                       fatVenda.strConPag,
                                                       IIF(fatVenda.dtaPreVis > 0, fatVenda.dtaPreVis, VS_Date),
                                                       fatVenda.strOpcDoc,
                                                       fatVenda.strCodCid);
    End;

    If (strConPagOri <> fatVenda.strConPag) Then
      Result := fatVenda.strConPag;

  Finally
    fatVenda.dtaGraPed := dtaGraPedBkp;
    fatVenda.dtaPrevis := dtaPrevisBkp;
    fatVenda.strConPag := strConPagBkp;
  End;
end;

procedure TfrmFatResolveConflitoPedidos.pSetarAtributoColunas;
  Var
    intCnt : Integer;
begin
  If cxgGriidCitelTableView1.ColumnCount <> Length(arrColunas) Then
    Exit;

  For intCnt := 0 To cxgGriidCitelTableView1.ColumnCount - 1 Do
  Begin
    cxgGriidCitelTableView1.Columns[intCnt].Caption := arrColunas[intCnt].strNome;

    If (arrColunas[intCnt].intTamanho = 0) Then
      cxgGriidCitelTableView1.Columns[intCnt].Visible := False
    Else
      cxgGriidCitelTableView1.Columns[intCnt].Width := arrColunas[intCnt].intTamanho;
  End;
end;

end.
