unit untTrocaOrigemMovimentacaoProgramada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untPai, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, untCadLote, untTransferenciaMovimentacaoProgramada,
  Vcl.ComCtrls, untTypesSistema, Uni, untTFatReservaSaldo, System.StrUtils, untMovimentacaoProgramada;

type
  TDadosLocOri = Record
    strORIPIC: string;
    strLOCORI: string;
    fltSALORI: Double;
    fltSALORIRES: Double;
    ftltMAXORI: double;
    fltREPORI: Double;
    fltSALORIDIS: Double;
    dtaDTAVAL: TDateTime;
  End;

  TfrmTrocaOrigemMovimentacaoProgramada = class(TfrmPai)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtLocFisOri: TEditFocus;
    edtLocFisDes: TEditFocus;
    Label3: TLabel;
    edtQtdMov: TEditFocus;
    Label4: TLabel;
    edtCapacidade: TEditFocus;
    pnlitem: TPanel;
    pnlCabec: TPanel;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    Label10: TLabel;
    cdsItens: TUniClientDataSet;
    dtsGrid: TDataSource;
    cxgItens: TcxGridCitel;
    cxgItensView: TcxGridDBTableViewCitel;
    cxgItensViewColumn8: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensViewColumn5: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    btnConfirmar: TBitBtnLocked;
    Panel2: TPanel;
    Label5: TLabel;
    edtCodite: TEditFocus;
    edtDesIte: TEditFocus;
    Label6: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label7: TLabel;
    edtSigUni: TEditFocus;
    lblOrigem: TLabel;
    grbOrigem: TGroupBox;
    lblSalOri: TLabel;
    lblMaxOri: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dbeSalOri: TEditFocus;
    dbeMaxOri: TEditFocus;
    dbeSalOriRes: TEditFocus;
    dbeSalOriDis: TEditFocus;
    Label11: TLabel;
    edtNumLotOri: TEditFocus;
    Label12: TLabel;
    edtNumLotDes: TEditFocus;
    dbeLotOri: TEditFocus;
    dbeQtdIte: TEditFocus;
    cdsItensITE_CODITE: TStringField;
    cdsItensITE_DESITE: TStringField;
    cdsItensLOC_CODLOC: TStringField;
    cdsItensQTD_TRANSF: TFloatField;
    cdsItensLOT_NUMLOT: TStringField;
    cdsItensLOT_LOCFIS: TStringField;
    cdsItensLOT_DTAVAL: TDateField;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    procedure edtSenDigExit(Sender: TObject);
    procedure dbeLotOriKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure pAtualizaOrigem;
    procedure pInsereMovimentacao;
    procedure FormDestroy(Sender: TObject);


  private
    objCadLote: TCadLot;
    strCodOpe: String;
    DadosLocOri: TDadosLocOri;
    blnCadLoc: Boolean;
    fltMaxDes: Double;
    fltSaldoDestino: Double;
    qryUpdate: TUniQuery;
    qryIns: TUniQuery;
    MovimentacaoProgramada: TMovimentacaoProgramadaManual;
    function fValidarOperador: Boolean;
    function fValidarLoteOrigem: Boolean;
    Function fCarregarLote(strLocFis: String): Boolean;
    procedure pLimparaRecDadosLocOri;
    procedure pLimparaDados;
    function fFormataValor(Valor: Double; Format: String): String;
    function fValidarLocalizacaoDestino(const strCodIte,strLocDes: String): Boolean;
    function fValidarQuantidade: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strIncremOrigem: String;
    strOpeDes: String;
    { Public declarations }
  end;

var
  frmTrocaOrigemMovimentacaoProgramada: TfrmTrocaOrigemMovimentacaoProgramada;

implementation

uses
  untFuncoesSimples, untConsultas;

{$R *.dfm}


procedure TfrmTrocaOrigemMovimentacaoProgramada.btnConfirmarClick(
  Sender: TObject);
var
  fltQtdAgregada: Double;
begin
  inherited;
  fltQtdAgregada := 0;
  If cxgItensView.DataController.Summary.FooterSummaryValues[0] <> null Then
    fltQtdAgregada := cxgItensView.DataController.Summary.FooterSummaryValues[0];


  If fltQtdAgregada < StrToFloat(edtQtdMov.Text) Then
  Begin
    pMensagemOk('A Quantidade de transferência menor que a original.');
    Exit;
  End;

  If fPergunta('Confirmar a troca do lote de Origem?') Then
  Begin
    cdsItens.First;
    MovimentacaoProgramada := TMovimentacaoProgramadaManual.Create('');
    qryIns := MovimentacaoProgramada.fCriaQueryInsertMovLot;
    MovimentacaoProgramada.fOperador(strCodOpe);


    Try

      fStartTransaction;
      Try
        while not cdsItens.Eof do
        Begin
          If cdsItens.RecNo = 1 Then
            pAtualizaOrigem
          Else
            pInsereMovimentacao;

          cdsItens.Next;
        End;
        fCommit;
        pMensagemOk('Concluído com sucesso!');
        Close;
      Except
        on e:Exception do
        Begin
          pMensagensErro(e.message, '[TfrmTrocaOrigemMovimentacaoProgramada.btnConfirmarClick]');
          fRollBack;
        End;
      End;

    Finally
      FreeAndNil(MovimentacaoProgramada);
      FreeAndNil(qryIns);
    End;


  End;
  {}
end;

procedure TfrmTrocaOrigemMovimentacaoProgramada.btnAdicionarClick(
  Sender: TObject);
begin
  inherited;
  cdsItens.First;
  cdsItens.DisableControls;
  Try
    If cdsItens.Locate('LOT_NUMLOT', dbeLotOri.Text, []) Then
      cdsItens.Delete;
  Finally
    cdsItens.EnableControls;
  End;

  cdsItens.Insert;
  Try
    cdsItens.FieldByName('ITE_CODITE').AsString := edtCodIte.Text;
    cdsItens.FieldByName('ITE_DESITE').AsString := edtDesIte.Text;
    cdsItens.FieldByName('LOC_CODLOC').AsString := edtLocFisDes.Text;
    cdsItens.FieldByName('QTD_TRANSF').AsFloat  := StrToFloat(dbeQtdIte.Text);
    cdsItens.FieldByName('LOT_NUMLOT').AsString := dbeLotOri.Text;
    cdsItens.FieldByName('LOT_LOCFIS').AsString := DadosLocOri.strLOCORI;
    cdsItens.FieldByName('LOT_DTAVAL').AsDateTime := DadosLocOri.dtaDTAVAL;
    cdsItens.Post;
    pLimparaDados;

    pSetFocus(dbeLotOri);
  Except
    on e: Exception do
    Begin
      cdsItens.Cancel;
      pMensagensErro(e.message, '[TfrmTrocaOrigemMovimentacaoProgramada.btnAdicionarClick]');
    End;
  End;
end;

procedure TfrmTrocaOrigemMovimentacaoProgramada.btnCancelaItemClick(
  Sender: TObject);
begin
  inherited;
  pLimparaDados;
end;

procedure TfrmTrocaOrigemMovimentacaoProgramada.cxgItensViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
    cdsItens.Delete;
end;

procedure TfrmTrocaOrigemMovimentacaoProgramada.dbeLotOriKeyPress(
  Sender: TObject; var Key: Char);
var strPicking: string;
begin
  inherited;
  strPicking := '';

  If objCadLote.fedtNumLotKeyPress(edtCodIte.Text, Sender, Key, TEditFocus(Sender)
    , Self, False, False, Nil, Nil, '', False, False, True, False, Nil, strPicking) Then
  Begin
    If fValidaCampos(TEdit(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTrocaOrigemMovimentacaoProgramada.edtSenDigExit(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeLotOri);

end;

function TfrmTrocaOrigemMovimentacaoProgramada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      If (Sender = edtSenDig) Then
        result := fValidarOperador
      Else If Sender = dbeLotOri Then
      Begin
        Result := fValidarLoteOrigem;
        If Result Then
        Begin
          dbeSalOri.Text := fFormataValor(DadosLocOri.fltSALORI, '#,##0.00');
          dbeSalOriRes.Text := fFormataValor(DadosLocOri.fltSALORIRES, '#,##0.00');
          dbeSalOriDis.Text := fFormataValor(DadosLocOri.fltSALORIDIS, '#,##0.00');
          dbeMaxOri.Text := fFormataValor(DadosLocOri.ftltMAXORI, '#,##0.00');
        End;
      End
      Else If Sender = dbeQtdIte Then
        Result := fValidarQuantidade

{      Else If Sender = edtCodOpeDest Then
        result := fValidarOperadorDest
      Else If Sender = edtCodOpe Then
        result := fValidarOperadorAbastPreven
      Else If Sender = dbeCodIte Then
        result := fValidarProduto(blnBuscaPorChave)
      Else If Sender = dbeLotOri Then
        Result := fValidarLoteOrigem
      Else If Sender = dbeLocDes Then
        Result := fValidarLocalizacaoDestino
      Else If Sender = edtGirEst Then
        Result := fValidarGiro
      Else If Sender = edtCapMax Then
        Result := fValidarPctCapMax;
        }
    End;
  Except
    On E: Exception Do
    Begin
      Result := false;
      pSetFocus(Sender);
      pMensagemOk(e.Message);
    End;
  End;
end;

function TfrmTrocaOrigemMovimentacaoProgramada.fValidarOperador: Boolean;
begin
  strCodOpe := '';
  if (fEmptyStr(edtSenDig.Text))  then
    raise Exception.Create('ATENÇÃO! O digitador deve ser preenchido!');

  strCodOpe := fRetCodVendedor(edtSenDig.Text);
  edtNomDig.Text := fRetNomVendRep(strCodOpe);

  if (fEmptyStr(edtNomDig.Text)) then
    raise Exception.Create('ATENÇÃO! Senha inválida!');

  pnlitem.Enabled := Not fEmptyStr(edtNomDig.Text);
  Result := true;
end;

function TfrmTrocaOrigemMovimentacaoProgramada.fValidarLoteOrigem: Boolean;
Begin
  If edtLocFisOri.Text = dbeLotOri.Text Then
    raise Exception.Create('Lote Informado igual ao original.');

  If Not fNumLotAtivo(edtCodIte.Text, dbeLotOri.Text, VS_strCodEmp) Then
    raise Exception.Create('Não é permitido movimentação de estoque para lotes inativos');

  Result := fCarregarLote(dbeLotOri.Text);


  If (Result) Then
    If (DadosLocOri.fltSalOriDis <= 0) Then
      raise Exception.Create('Atenção!' + #13 + 'No lote de origem é permitido informar somente lotes que tenham saldo.');

  If Result Then
    If (DadosLocOri.strORIPIC = 'S') then
      raise Exception.Create('Atenção!' + #13 + 'No lote de origem é permitido informar somente lotes Buffer!');
End;

Function TfrmTrocaOrigemMovimentacaoProgramada.fCarregarLote(strLocFis: String): Boolean;
Var
  qryDadIte: TUniQuery;
Begin

  qryDadIte := fCriaQuery(Self);
  Try
    qryDadIte.SQL.Clear;
    qryDadIte.SQL.Add(' SELECT L.*,                                      ');
    qryDadIte.SQL.Add('        G.ITE_PRECUS,                             ');
    qryDadIte.SQL.Add('        I.ITE_CODMAR,                             ');
    qryDadIte.SQL.Add('        I.ITE_CODITE,                             ');
    qryDadIte.SQL.Add('        I.ITE_DESITE,                             ');
    qryDadIte.SQL.Add('          LOC_PICKIN,                             ');
    qryDadIte.SQL.Add('          MAR_DESMAR,                             ');
    qryDadIte.SQL.Add('          IFNULL(LOC_CRITIC,"N") AS LOC_CRITIC,   ');
    qryDadIte.SQL.Add('          UNI_SIGUNI                              ');
    qryDadIte.SQL.Add(' FROM CADLOT L                                    ');
    qryDadIte.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = LOT_CODITE ');
    qryDadIte.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = LOT_CODITE ');
    qryDadIte.SQL.Add('                    AND G.ITE_CODEMP = LOT_CODEMP ');
    qryDadIte.SQL.Add(' LEFT  JOIN CADMAR   ON   MAR_CODMAR = ITE_CODMAR ');
    qryDadIte.SQL.Add(' LEFT  JOIN CADUNI   ON   UNI_CODUNI = ITE_CODUNI ');
    qryDadIte.SQL.Add(' LEFT  JOIN CADLOC   ON   LOC_CODLOC = LOT_LOCFIS ');
    qryDadIte.SQL.Add('                    AND   LOT_CODEMP = LOC_CODEMP ');
    qryDadIte.SQL.Add(' WHERE LOT_CODEMP = :CODEMP                       ');
    qryDadIte.SQL.Add('   AND LOT_CODITE = :CODITE                       ');
    qryDadIte.SQL.Add('   AND LOT_NUMLOT = :NUMLOT                       ');
    qryDadIte.ParamByName('CODITE').AsString := edtCodIte.Text;
    qryDadIte.ParamByName('NUMLOT').AsString := strLocFis;
    qryDadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDadIte.Open;
    Result := Not qryDadIte.IsEmpty;

    If blnCadLoc And fEmptyStr(qryDadIte.FieldByName('LOT_LOCFIS').AsString) And
                              (qryDadIte.FieldByName('LOT_NUMLOT').AsString <> 'A DEFINIR') Then
    Begin
      Result := False;
      pMensagemOk('Lote sem localização Física definida!')
    End Else If Not Result Then
    Begin
      Result := False;
      pMensagemOk('Lote não encontrado!')
    End;

    If (Result) Then
    Begin
      DadosLocOri.strORIPIC := IIF(qryDadIte.FIeldByName('LOC_PICKIN').AsString = 'S','S','');
      DadosLocOri.fltSALORI := qryDadIte.FieldByName('LOT_SALDOS').AsFloat + qryDadIte.FieldByName('LOT_SAL_ML').AsFloat;
      DadosLocOri.ftltMAXORI := qryDadIte.FieldByName('LOT_CAPACI').AsFloat;
      DadosLocOri.fltREPORI := qryDadIte.FieldByName('LOT_PONREP').AsFloat;
      DadosLocOri.strLOCORI:= qryDadIte.FieldByName('LOT_LOCFIS').AsString;

      DadosLocOri.dtaDTAVAL := qryDadIte.FieldByName('LOT_DTAVAL').AsDateTime;

      DadosLocOri.fltSALORIRES := 0;
      DadosLocOri.fltSALORIDIS := 0;
      If (qryDadIte.FieldByName('LOC_CRITIC').AsString <> 'S') Then
      Begin
        DadosLocOri.fltSALORIRES := fGetSaldoResLotDor(edtCodIte.Text, strLocFis, VS_strCodEmp);
        DadosLocOri.fltSALORIDIS := qryDadIte.FieldByName('LOT_SALDOS').AsFloat +
                                                       qryDadIte.FieldByName('LOT_SAL_ML').AsFloat -
                                                   TSaldoReservado.New(
                                                     TReservaParametros.New()
                                                       .EmpresaItem(VS_strCodEmp)
                                                       .CodigoItem(qryDadIte.FieldByName('LOT_CODITE').AsString)
                                                       .CodEmpresa(VS_strCodEmp)
                                                       .NumeroLote(qryDadIte.FieldByName('LOT_NUMLOT').AsString)
                                                     ).fGetQuantidade();
      End;

    End
    Else
      pLimparaRecDadosLocOri
  Finally
    FreeAndNil(qryDadIte);
  End;
End;

procedure TfrmTrocaOrigemMovimentacaoProgramada.FormCreate(Sender: TObject);
begin
  inherited;
  blnCadLoc := fCfgSis('CADLOC', varBoolean);
  objCadLote := TCadLot.Create(Self);
  qryUpdate := fCriaQuery;
end;

procedure TfrmTrocaOrigemMovimentacaoProgramada.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objCadLote);
  FreeAndNil(qryUpdate);
end;

procedure TfrmTrocaOrigemMovimentacaoProgramada.FormShow(Sender: TObject);
begin
  inherited;
  fValidarLocalizacaoDestino(edtCodite.Text, edtLocFisDes.Text);
end;

procedure TfrmTrocaOrigemMovimentacaoProgramada.pAtualizaOrigem;
begin
  qryUpdate.SQL.Clear;
  qryUpdate.SQL.Add('UPDATE MOVLOT SET MLT_LOTORI = :LOTORI, MLT_QTDMOV = :QTDMOV WHERE AUTOINCREM = "'+strIncremOrigem+'"');
  qryUpdate.ParamByName('LOTORI').AsString := cdsItens.FieldByName('LOT_NUMLOT').AsString;
  qryUpdate.ParamByName('QTDMOV').AsFloat  := cdsItens.FieldByName('QTD_TRANSF').AsFloat;
  qryUpdate.ExecSQL;
end;

procedure TfrmTrocaOrigemMovimentacaoProgramada.pInsereMovimentacao;
begin
  qryUpdate.SQL.Clear;
  MovimentacaoProgramada.pGravarMovLotAbastPicking(qryIns,
                                                   cdsItens.FieldByName('ITE_CODITE').AsString,
                                                   cdsItens.FieldByName('LOT_NUMLOT').AsString,
                                                   cdsItens.FieldByName('LOT_LOCFIS').AsString,
                                                   cdsItens.FieldByName('LOC_CODLOC').AsString,
                                                   strOpeDes,
                                                   cdsItens.FieldByName('QTD_TRANSF').AsFloat,
                                                   cdsItens.FieldByName('LOT_DTAVAL').AsDateTime);




end;

procedure TfrmTrocaOrigemMovimentacaoProgramada.pLimparaDados;
begin
  pLimparaRecDadosLocOri;
  dbeLotOri.Clear;
  dbeSalOri.Clear;
  dbeSalOriRes.Clear;
  dbeSalOriDis.Clear;
  dbeMaxOri.Clear;
  dbeQtdIte.Clear;
end;

procedure TfrmTrocaOrigemMovimentacaoProgramada.pLimparaRecDadosLocOri;
begin
  DadosLocOri.strORIPIC := '';
  DadosLocOri.strLOCORI := '';
  DadosLocOri.fltSALORI := 0;
  DadosLocOri.fltSALORIRES := 0;
  DadosLocOri.ftltMAXORI := 0;
  DadosLocOri.fltREPORI := 0;
  DadosLocOri.fltSALORIDIS := 0;
  DadosLocOri.dtaDTAVAL := 0;
End;

function TfrmTrocaOrigemMovimentacaoProgramada.fFormataValor(Valor: Double; Format: String): String;
begin
  Result := FormatFloat(Format, StrToFloat(AnsiReplaceStr(FloatToStr(Valor), '.', '')));
end;


function TfrmTrocaOrigemMovimentacaoProgramada.fValidarLocalizacaoDestino(const strCodIte,strLocDes: String): Boolean;
Var
  qryDadIte: TUniQuery;
Begin
  fltMaxDes := 0;
  qryDadIte := fCriaQuery(Self);
  Try
    qryDadIte.SQL.Add('SELECT I.ITE_CODITE,I.ITE_DESITE, LOT_SALDOS FROM CADLOT       ');
    qryDadIte.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = LOT_CODITE');
    qryDadIte.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE= LOT_CODITE ');
    qryDadIte.SQL.Add('                    AND G.ITE_CODEMP = LOT_CODEMP');
    qryDadIte.SQL.Add(' LEFT  JOIN CADLOC   ON   LOC_CODLOC = LOT_LOCFIS ');
    qryDadIte.SQL.Add('                    AND   LOT_CODEMP = LOC_CODEMP ');
    qryDadIte.SQL.Add('WHERE LOT_CODEMP = :CODEMP ');
    qryDadIte.SQL.Add('  AND LOT_LOCFIS = :LOCFIS ');
    qryDadIte.SQL.Add('  AND LOT_CODITE <> :CODITE');
    qryDadIte.ParamByName('LOCFIS').AsString := strLocDes;
    qryDadIte.ParamByName('CODITE').AsString := strCodIte;
    qryDadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDadIte.Open;
    Result := (Not qryDadIte.IsEmpty);

    If (Result)  Then
    begin
      fltSaldoDestino :=  qryDadIte.FieldByName('LOT_SALDOS').AsFloat;
      qryDadIte.Close;
      qryDadIte.SQL.Clear;


      qryDadIte.SQL.Add('SELECT I.LCI_QTDMAX AS QTDMAX');
      qryDadIte.SQL.Add('  FROM CADLOC B ');
      qryDadIte.SQL.Add(' LEFT JOIN LOCITE I ON LCI_LOCFIS = B.AUTOINCREM ');
      qryDadIte.SQL.Add('WHERE B.LOC_CODLOC = :CODLOC');
      qryDadIte.SQL.Add('  AND I.LCI_CODITE = :CODITE');

      qryDadIte.ParamByName('CODITE').AsString := strCodIte;
      qryDadIte.ParamByName('CODLOC').AsString := strLocDes;
      qryDadIte.Open;

      if not qryDadIte.IsEmpty then
        fltMaxDes := qryDadIte.FieldByName('QTDMAX').AsFloat -  fltSaldoDestino;
    end;

  Finally
    FreeAndNil(qryDadIte);
  End;
End;

function TfrmTrocaOrigemMovimentacaoProgramada.fValidarQuantidade: Boolean;
var fltQtdAgregada: Double;
Begin
  fltQtdAgregada := 0;
  If cxgItensView.DataController.Summary.FooterSummaryValues[0] <> null Then
    fltQtdAgregada := cxgItensView.DataController.Summary.FooterSummaryValues[0];
  If fStrToFloat(dbeQtdIte.Text) <= 0 Then
    raise Exception.Create('A quantidade transferida deve ser maior que zero!');

  If fStrToFloat(dbeQtdIte.Text) > fStrToFloat(dbeSalOriDis.Text) Then
    raise Exception.Create('A quantidade transferida deve ser menor ou igual ao saldo disponível!');

  If (fltMaxDes > 0) And
     (fStrToFloat(dbeQtdIte.Text) + fltQtdAgregada > fltMaxDes) Then
    raise Exception.Create('A quantidade a transferir é maior que a quantidade máxima da localização do destino. ' +
                           'Realize o ajuste no cadastro "Mapeamento de localização física" e depois tente novamente.');

  Result := True;
End;




end.

