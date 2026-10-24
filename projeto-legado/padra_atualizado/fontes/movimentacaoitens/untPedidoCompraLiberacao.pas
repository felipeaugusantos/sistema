unit untPedidoCompraLiberacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient;

type

  TOpcSelecao = (opcMarcar, opcDesmarcar, opcInverter);

  TpImprimePedidoCompra =  procedure (strNumPed,
                                 strEspDoc,
                                 strCodEmp: String); stdcall;

  TfrmPedidoCompraLiberacao = class(TfrmPaiOrdena)
    btnConfirma: TBitBtnLocked;
    btnVencimentos: TBitBtnLocked;
    btnConsulta: TBitBtnLocked;
    btnDetalhes: TBitBtnLocked;
    popOpSele: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    N1: TMenuItem;
    InverterSeleo1: TMenuItem;
    btnOpcaoSelecao: TBitBtnLocked;
    btnConsultarFornecedor: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnVencimentosClick(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
    procedure btnDetalhesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  ShowModalConsultaPedidoCompra: Integer;
    procedure dbgConsultaDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure InverterSeleo1Click(Sender: TObject);
    procedure btnOpcaoSelecaoClick(Sender: TObject);
    procedure btnConsultarFornecedorClick(Sender: TObject);
  private
    { Private declarations }
    blnConsultaPedCompra: Boolean;
    blnFiltroConfirmado: Boolean;

    procedure pConfirmaLiberacao;
    function fLiberaPedido(strNumPed, strCodEmp: String): Boolean;
    function fCarregarFiltrosDaTelaConsulta: string;
    function fAbrirConsulta: Boolean;
    procedure pMarcarMensagemComoLida(const ANumPed, ACodEmp: String);
    function fExisteMensagemLiberacaoPedidos(const ANumPed, ACodEmp: String): Boolean;
    function fLerMensagem(const ANumPed, ACodEmp: String): Boolean;
    procedure pInverteSelecao;
  public
    { Public declarations }
    pImprimePedidoCompra: TpImprimePedidoCompra;
    blnPnlLiberaPedCom: Boolean;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fGetSQLCampos: String;
    procedure pSetParametros;

  end;

implementation

uses untPai, untFuncoesSimples, untFuncoesPedidoSimples,
  untTypesSistema, untConsultaPedCompra,
  untSaldoPedidoCompra, untFuncoesConsulta, untFuncoesRel, untFuncoesRel2,
  untCadFornecedores;

{$R *.dfm}

function TfrmPedidoCompraLiberacao.fAbrirConsulta: Boolean;
begin
  Result := fAbreConsulta(True);
  If Result Then
    TFloatField(cdsConsulta.FieldByName('PCG_TOTGER')).DisplayFormat := '##,#0.00'
end;

function TfrmPedidoCompraLiberacao.fCarregarFiltrosDaTelaConsulta: string;
begin
  Result := '';
  If frmConsultaPedCompra.Showmodal = mrOK Then
  Begin
    blnSempreRelerBanco := False;
    qryConsulta.SQL.Add('SELECT ');
    qryConsulta.SQL.Add('DISTINCT P.AUTOINCREM, ');
    qryConsulta.SQL.Add(fGetSQLCampos);
    qryConsulta.SQL.Add('  FROM PCMGER P ');
    qryConsulta.SQL.Add(' INNER JOIN PCMDET ON PCMDET.PCD_NUMPED = P.PCG_NUMPED ');
    qryConsulta.SQL.Add('                  AND PCMDET.PCD_ESPDOC = P.PCG_ESPDOC ');
    qryConsulta.SQL.Add('                  AND PCMDET.PCD_CODEMP = P.PCG_CODEMP ');
    qryConsulta.SQL.Add('  LEFT JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR ');
    qryConsulta.SQL.Add('  LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ');

    qryConsulta.SQL.Add('  LEFT JOIN CADITE ON ITE_CODITE = PCMDET.PCD_CODITE ');
    qryConsulta.SQL.Add('  WHERE PCG_PEDLIB IS NULL    ');
    qryConsulta.SQL.Add('    AND PCG_NUMCTN = 0   ');
    qryConsulta.SQL.Add('    AND PCG_ESPDOC = "PD" ');

    // DATA INICIAL E FINAL DO PEDIDO ( EMISSAO )
    If Not (fEmptyStr(fTiraCaracEspeciais(frmConsultaPedCompra.mskEmissaoDtaIni.Text))) And
       Not (fEmptyStr(fTiraCaracEspeciais(frmConsultaPedCompra.mskEmissaoDtaFin.Text))) Then
       qryConsulta.SQL.Add('    AND PCG_DTAEMI BETWEEN :EMIINI AND :EMIFIM ');
    // DATA INICIAL E FINAL DO PEDIDO ( ENTREGA )
    If Not (fEmptyStr(fTiraCaracEspeciais(frmConsultaPedCompra.mskentregaDtaIni.Text))) And
       Not (fEmptyStr(fTiraCaracEspeciais(frmConsultaPedCompra.mskEntregaDtaFin.Text))) Then
        qryConsulta.SQL.Add('    AND PCG_DTAENT BETWEEN :ENTINI AND :ENTFIM ');
    // EMPRESA
    If Not fEmptyStr(frmConsultaPedCompra.edtCodEmpresa.Text) Then
    Begin
      qryConsulta.SQL.Add('AND ((IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP, PCG_EMPDES) = :CODEMP)');
      qryConsulta.SQL.Add('      OR(PCG_CODEMP = :CODEMP))');
    End;
    // FORNECEDOR
    qryConsulta.SQL.Add(fStrLocate(frmConsultaPedCompra.edtCodFornecedor,
                                   frmConsultaPedCompra.arrCodFornec, 'PCG_CODFOR', 'CODFOR'));
    // LINHA/GRUPO
    qryConsulta.SQL.Add(fStrLocateLinGru(frmConsultaPedCompra.mskLinhaGrupo,
                                         frmConsultaPedCompra.arrLinhaGrupo, 'ITE_CODGRU','CODGRU'));
    // PRODUTO
    qryConsulta.SQL.Add(fStrLocate(frmConsultaPedCompra.edtProdutos,
                                   frmConsultaPedCompra.arrCodIte,  'PCD_CODITE',  'CODITE'));
    // MARCA
    qryConsulta.SQL.Add(fStrLocate(frmConsultaPedCompra.edtMarca,
                                   frmConsultaPedCompra.arrMarca,    'ITE_CODMAR', 'CODMAR'));
    // GRUPO DE COMPRA
    qryConsulta.SQL.Add(fStrLocate(frmConsultaPedCompra.edtGruCmp,
                                   frmConsultaPedCompra.arrGruCmp,   'ITE_GRUCMP', 'GRUCMP'));
    // COMPRADOR
    qryConsulta.SQL.Add(fStrLocate(frmConsultaPedCompra.edtCodCmp,
                                   frmConsultaPedCompra.arrCodCmp, 'PCG_CODCMP', 'CODCMP'));
    { SITUAÇÃO DO PEDIDO
      0 = TODOS
      1 = BAIXADOS
      2 = NÃO BAIXADOS
      3 = BAIXADOS QUE NÃO SERÃO ENTREGUES }
    Case frmConsultaPedCompra.rdgSituacao.ItemIndex Of
      //baixados
      1: qryConsulta.SQL.Add(' AND PCG_BAIXAD = 1');
      3: qryConsulta.SQL.Add(' AND PCG_BAIXAD = 1 AND PCD_ENTREG = "N"');
      2: qryConsulta.SQL.Add(' AND PCG_BAIXAD = 0');
    End;
    Result := qryConsulta.SQL.Text;
    pSetParametros;
  End;
end;


function TfrmPedidoCompraLiberacao.fExisteMensagemLiberacaoPedidos(
  const ANumPed, ACodEmp: String): Boolean;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil);
    try
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT COUNT(0) AS QTDE ');
      qryGen.SQL.Add('  FROM CADMSG           ');
      qryGen.SQL.Add(' WHERE MSG_LIDA__ = "N" ');
      qryGen.SQL.Add('   AND MSG_EMPENV = ' + QuotedStr(ACodEmp));
      qryGen.SQL.Add('   AND MSG_TITULO = "LIBERAÇÃO DE PEDIDO DE COMPRA ( ' + ANumPed + ' - PD )"');
      qryGen.Open;
      Result := qryGen.FieldByName('QTDE').AsInteger > 0;
      qryGen.Close;
    finally
      FreeAndNil(qryGen);
    end;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fExisteMensagemLiberacaoPedidos]');
    End;
  End;
end;

function TfrmPedidoCompraLiberacao.fLerMensagem(const ANumPed, ACodEmp: String): Boolean;
begin
  Result := True;

  If blnPnlLiberaPedCom Then
    Exit;

  If fExisteMensagemLiberacaoPedidos(ANumPed, ACodEmp) Then
    Exit;

  Result := False;
end;

procedure TfrmPedidoCompraLiberacao.pSetParametros;
begin
  // DATA INICIAL E FINAL DO PEDIDO ( EMISSAO )
  If Not (fEmptyStr(fTiraCaracEspeciais(frmConsultaPedCompra.mskEmissaoDtaIni.Text))) And
     Not (fEmptyStr(fTiraCaracEspeciais(frmConsultaPedCompra.mskEmissaoDtaFin.Text))) Then
  Begin
    qryConsulta.ParamByName('EMIINI').AsDateTime := StrToDate(frmConsultaPedCompra.mskEmissaoDtaIni.Text);
    qryConsulta.ParamByName('EMIFIM').AsDateTime := StrToDate(frmConsultaPedCompra.mskEmissaoDtaFin.Text);
  End;

  // DATA INICIAL E FINAL DO PEDIDO ( ENTREGA )
  If Not (fEmptyStr(fTiraCaracEspeciais(frmConsultaPedCompra.mskentregaDtaIni.Text))) And
     Not (fEmptyStr(fTiraCaracEspeciais(frmConsultaPedCompra.mskEntregaDtaFin.Text))) Then
  Begin
    qryConsulta.ParamByName('ENTINI').AsDateTime := strToDate(frmConsultaPedCompra.mskentregaDtaIni.Text);
    qryConsulta.ParamByName('ENTFIM').AsDateTime := strToDate(frmConsultaPedCompra.mskEntregaDtaFin.Text);
  End;

  // EMPRESA
  pSetaParam(frmConsultaPedCompra.edtCodEmpresa.Text,
             frmConsultaPedCompra.arrEmpresa,
             frmConsultaPedCompra.strEmpresa,'CODEMP', qryConsulta);
  // FORNECEDOR
  pSetaParam(frmConsultaPedCompra.edtCodFornecedor.Text,
             frmConsultaPedCompra.arrCodFornec,
             frmConsultaPedCompra.strCodFornec,'CODFOR', qryConsulta);
  // LINHA/GRUPO
  pSetaParam(frmConsultaPedCompra.mskLinhaGrupo.Text,
             frmConsultaPedCompra.arrLinhaGrupo,
             frmConsultaPedCompra.strLinhaGrupo, 'CODGRU', qryConsulta);
  // PRODUTO
  pSetaParam(frmConsultaPedCompra.edtProdutos.Text,
             frmConsultaPedCompra.arrCodIte,
             frmConsultaPedCompra.strLinhaProdu, 'CODITE', qryConsulta);
  // MARCA
  pSetaParam(frmConsultaPedCompra.edtMarca.Text,
             frmConsultaPedCompra.arrMarca,
             frmConsultaPedCompra.strMarca, 'CODMAR', qryConsulta);
  // GRUPO DE COMPRA
  pSetaParam(frmConsultaPedCompra.edtGruCmp.Text,
             frmConsultaPedCompra.arrGruCmp,
             frmConsultaPedCompra.strGruCmp, 'GRUCMP', qryConsulta);
  // COMPRADOR
  pSetaParam(frmConsultaPedCompra.edtCodCmp.Text,
             frmConsultaPedCompra.arrCodCmp,
             frmConsultaPedCompra.strCodCmp, 'CODCMP', qryConsulta);
end;

function TfrmPedidoCompraLiberacao.ShowModalConsultaPedidoCompra: Integer;
begin
  blnConsultaPedCompra := True;
  btnConfirma.Visible :=  Not blnConsultaPedCompra;
  btnConsulta.Visible := Assigned(pImprimePedidoCompra);
  pCriarFormularios(TfrmConsultaPedCompra, frmConsultaPedCompra);
  Self.OnShow := nil;
  Result := 0;
  If fAbrirConsulta Then
    Result :=  Self.Showmodal;
end;

function TfrmPedidoCompraLiberacao.fGetSql(blnLike: Boolean): String;
  Var
    strSql : String;
begin
  If blnConsultaPedCompra and fEmptyStr(qryConsulta.SQL.Text) Then
  Begin
    fCarregarFiltrosDaTelaConsulta;
    // se cancelou a tela de filtros, o SQL continua vazio
    blnFiltroConfirmado := Not fEmptyStr(qryConsulta.SQL.Text);
  End
  Else
  Begin
    blnFiltroConfirmado := True;

    strSql := '';
    strSql := strSql  + 'SELECT SQL_NO_CACHE         ';
    strSql := strSql  + '  P.AUTOINCREM,             ';
    strSQL := strSQL + fGetSQLCampos;
    begin
      strSql := strSql  + 'FROM                        ';
      strSql := strSql  + '  PCMGER P                  ';
      strSql := strSql  + '  LEFT JOIN CADFOR ON       ';
      strSql := strSql  + '    FOR_CODFOR = PCG_CODFOR ';
      strSql := strSql  + '  LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ';

      strSql := strSql  + 'WHERE                       ';
      strSql := strSql  + '   PCG_BAIXAD = 0 AND ';
      strSql := strSql  + '   PCG_PEDLIB IS NULL AND   ';
      strSql := strSql  + '   PCG_ESPDOC = "PD"    ';
      strSql := strSql  + '   AND PCG_NUMCTN = 0   ';

      If fCfgSis('LEMPCM') = '1' Then
      Begin
         strSql := strSql  + ' AND (IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP, PCG_EMPDES) = ' + QuotedStr(VS_strCodEmp);
         strSql := strSql  + '    OR PCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ')';
      End;
      Result := strSql;
    End;
  End;
end;

function TfrmPedidoCompraLiberacao.fGetSQLCampos: String;
begin
  Result := Result  + '  PCG_DTAENT,               ';
  Result := Result  + '  PCG_NUMPED,               ';
  Result := Result  + '  PCG_CODEMP,               ';
  Result := Result  + '  PCG_CODFOR,               ';
  Result := Result  + '  FOR_NOMFOR,               ';
  Result := Result  + '  PCG_TOTGER,               ';
  Result := Result  + '  PCG_CONPAG,               ';
  Result := Result  + '  PCG_DTAENT,               ';
  Result := Result  + '  P.PCG_CODCMP,             ';
  Result := Result  + '  OPE_NOMOPE AS OPE_NOMOPE, ';
  Result := Result  + '  PCG_DTAPED                ';
end;

function TfrmPedidoCompraLiberacao.fSetParametros: Boolean;
begin
  Result := True;
  If blnConsultaPedCompra Then
  Begin
    If Not blnFiltroConfirmado Then
      Result := False
    Else
      pSetParametros;
  End;
end;

procedure TfrmPedidoCompraLiberacao.InverterSeleo1Click(Sender: TObject);
Var
  intTag: Integer;
begin
  inherited;
  intTag := TMenuItem(Sender).Tag;

  case TOpcSelecao(intTag) of
    opcMarcar:    pMarcaTodos;
    opcDesmarcar: pDesmarcaTodos;
    opcInverter:  pInverteSelecao;
  End;
end;

procedure TfrmPedidoCompraLiberacao.btnConsultarFornecedorClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('frmCadFornecedores') Then
  Begin
    pMensagemOk('Usuário sem permissão para o Cadastro de Fornecedores!');
    Exit;
  End;

  pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);
  Try
    Try
      frmCadFornecedores.strCodFornecedorIniciarCadastro := cdsConsulta.FieldByName('PCG_CODFOR').AsString;
      frmCadFornecedores.ShowModal;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(frmCadFornecedores);
  End;
end;

procedure TfrmPedidoCompraLiberacao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not btnConfirma.Visible Then
    Exit;
  If (cdsConsulta.RecordCount = 0) Or
     (stlListSelecao.Count    = 0) Then
  Begin
    fMensagem('','Nenhum Pedido Selecionado !',['&O K']);
    Exit;
  End
  Else If fMensagem('','Confirma liberação dos pedidos selecionados ?', ['','']) = 1 Then
    pConfirmaLiberacao;

end;

procedure TfrmPedidoCompraLiberacao.pConfirmaLiberacao;
  Var
    intContador : Integer;
begin

  pnlInfo.Caption   := 'Processando Pedidos, Aguarde...';
  pnlBotoes.Enabled := False;

  Application.ProcessMessages;

  With cdsConsulta Do
  Begin

    DisableControls;

    For intContador := 0 To stlListSelecao.Count -1 Do
    Begin
      Filtered  := False;
      Filter := 'AUTOINCREM = ' + stlListSelecao[IntContador];
      Filtered  := True;

      If RecordCount > 0 Then
      Begin
        If fLiberaPedido(FieldByname('PCG_NUMPED').AsString,
                         FieldByname('PCG_CODEMP').AsString) Then
          pMarcarMensagemComoLida(FieldByname('PCG_NUMPED').AsString,
                                  FieldByname('PCG_CODEMP').AsString);
      End;

    End;

    Filter   := '';
    Filtered := False;

    EnableControls;

  End;

  pnlInfo.Caption   := '';
  pnlBotoes.Enabled := True;

  fAbreConsulta(True);

  pSetFocus(dbgConsulta);

end;

procedure TfrmPedidoCompraLiberacao.pMarcarMensagemComoLida(const ANumPed, ACodEmp: String);
var
  qryGen: TUniQuery;
begin
  If Not fLerMensagem(ANumPed, ACodEmp) Then
    Exit;

  Try
    qryGen := fCriaQuery(Nil);
    try
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add('UPDATE CADMSG ');
      qryGen.SQL.Add('   SET MSG_LIDA__ = "S" ');
      qryGen.SQL.Add(' WHERE MSG_EMPENV = ' + QuotedStr(ACodEmp));
      qryGen.SQL.Add('   AND MSG_TITULO = "LIBERAÇÃO DE PEDIDO DE COMPRA ( ' + ANumPed + ' - PD )"');
      qryGen.ExecSQL;
      qryGen.Close;
    finally
      FreeAndNil(qryGen);
    end;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[pMarcarMensagemComoLida]');
    End;
  End;
end;

function TfrmPedidoCompraLiberacao.fLiberaPedido(strNumPed, strCodEmp: String): Boolean;
  Var
    strUpdate: String;
    qryUpdate: TUniQuery;
    strLogLib: String;
begin

  strUpdate := '';
  strUpdate := strUpdate + '                              ';
  strUpdate := strUpdate + '  UPDATE                      ';
  strUpdate := strUpdate + '    PCMGER                    ';
  strUpdate := strUpdate + '  SET                         ';
  strUpdate := strUpdate + '    PCG_PEDLIB = :PEDLIB      ';
  strUpdate := strUpdate + '  WHERE                       ';
  strUpdate := strUpdate + '    PCG_NUMPED = :NUMPED AND  ';
  strUpdate := strUpdate + '    PCG_CODEMP = :CODEMP AND  ';
  strUpdate := strUpdate + '    PCG_ESPDOC = "PD"         ';

  strLogLib := strLoginUsuarioLogado + FormatDateTime('ddmmyyyy', VS_Date) + FormatDateTime('hhmmss', fTime());

  qryUpdate := fCriaQuery(Nil);

  With qryUpdate Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strUpdate);
    ParamByName('PEDLIB').AsString := strLogLib;
    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('CODEMP').AsString := strCodEmp;

    pEstornaSaldoPedidoCompra(strNumPed, 'PD', strCodEmp);

    ExecSQL;

    pAtualizaSaldoPedidoCompra(strNumPed, 'PD', strCodEmp);
  End;

  FreeAndNil(qryUpdate);

  Result := True;

end;

procedure TfrmPedidoCompraLiberacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  If blnConsultaPedCompra Then
  Begin
    qryConsulta.SQL.Clear;
    Self.Hide;
    If fAbreConsulta(True) Then
    Begin
      Self.Show;
      Action := caNone
    End;
  End;
end;

procedure TfrmPedidoCompraLiberacao.FormCreate(Sender: TObject);
begin
  inherited;
  pImprimePedidoCompra := Nil;
  blnPnlLiberaPedCom := False;
end;

procedure TfrmPedidoCompraLiberacao.FormDestroy(Sender: TObject);
begin
  If blnConsultaPedCompra Then
    FreeAndNil(frmConsultaPedCompra);
  inherited;
end;

procedure TfrmPedidoCompraLiberacao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_F10 Then
    btnConfirma.Click;

  If Key = VK_F9 Then
    btnConsulta.Click;

  If (Key = VK_F8) and (btnVencimentos.Enabled) And (btnVencimentos.Visible) Then
    btnVencimentos.Click;

  If Key = VK_F11 Then
    btnDetalhes.Click;

end;

procedure TfrmPedidoCompraLiberacao.FormShow(Sender: TObject);
begin
  btnConsulta.Visible := Assigned(pImprimePedidoCompra);
  fAbrirConsulta;
end;

procedure TfrmPedidoCompraLiberacao.btnConsultaClick(Sender: TObject);
begin
  inherited;

    If Assigned(pImprimePedidoCompra) Then
      pImprimePedidoCompra(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                           'PD',
                           cdsConsulta.FieldByName('PCG_CODEMP').AsString); //blnBlockButtons
 // End;

end;

procedure TfrmPedidoCompraLiberacao.btnDetalhesClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(110, 5863, [],
                        ['NUMPED','CODEMP','ESPDOC'],
                        [cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                        cdsConsulta.FieldByName('PCG_CODEMP').AsString,
                        'PD'],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmPedidoCompraLiberacao.btnOpcaoSelecaoClick(Sender: TObject);
begin
  inherited;
  popOpSele.Popup(Mouse.CursorPos.X + 2, Mouse.CursorPos.Y + 2);
end;

procedure TfrmPedidoCompraLiberacao.btnVencimentosClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(108, 5838, [],
                        ['NUMPED','CODEMP','ESPDOC'],
                        [cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                        cdsConsulta.FieldByName('PCG_CODEMP').AsString,
                        'PD'],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmPedidoCompraLiberacao.dbgConsultaDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  If Not blnConsultaPedCompra Then
    inherited;
end;

procedure TfrmPedidoCompraLiberacao.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  With cdsConsulta Do
  Begin
    If (Key = VK_RETURN) And (RecNo < RecordCount)Then
      RecNo := RecNo + 1;
  End;

end;

procedure TfrmPedidoCompraLiberacao.pInverteSelecao;
var
  strAuto  : String;
  intIndex : integer;
  intRecNo : Integer;
begin {AddListaQuery}
  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.First;
  cdsConsulta.DisableControls;
  While Not cdsConsulta.Eof Do
  Begin
    If  (blnTemSelecao Or blnTemMarcacao)
    And (Not cdsConsulta.IsEmpty) Then
    Begin
      If blnQuoteLista Then
        strAuto  := '''' + fRetChaveLista + ''''
      Else
        strAuto  := fRetChaveLista;

      intIndex := stlListSelecao.IndexOf(strAuto);
      If intIndex > 0 then
        stlListSelecao.Delete(intIndex)
      Else
        pAddListaQuery;
    End;
    cdsConsulta.Next;
  End;
  dbgConsulta.Refresh;
  cdsConsulta.RecNo := intRecNo;
  cdsConsulta.EnableControls;
end;

end.
