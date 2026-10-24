unit untAlteracaoEntregaFutura;

interface

uses
  Windows, Forms, Classes, Controls, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, Uni,
  AppEvnts, Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids,
  Buttons, ExtCtrls, ComboBoxFocus, untControleEntregaRomaneio, BitBtnLockedIncrem,
  MemDS, DBAccess, Provider, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, untCadLote, strUtils;

type
  TfrmAlteracaoEntregaFutura = class(TfrmPaiOrdena)
    Panel3: TPanel;
    Label27: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label2: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnConfirma: TBitBtnLocked;
    lblMotFut: TLabel;
    lblDtaFut: TLabel;
    mskDtaFut: TMaskEditFocus;
    btnCancelaItem: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    lblTipoDocumento: TLabel;
    cmbMotEntFut: TComboBoxFocus;
    pnlAviso: TPanel;
    mmoAviso: TMemo;
    pnlLegenda: TPanel;
    lblLegenda: TLabel;
    btnAlteracaoLote: TBitBtnLocked;
    lblCliBus: TLabel;
    cmbCliBus: TComboBoxFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbMotEntFutChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mskDtaFutKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlteracaoLoteClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objCadLot : TCadLot;
    objConEnt: TControleEntregaRomaneio;
    qryCadEmp: TUniQuery;
    qryCadCli: TUniQuery;

    procedure pCarregaEmpresa;
    procedure pCarregaCliente;
    procedure pAlterandoEntFut(blnAlterando: Boolean);
    procedure pAlteraParaEntregaFutura;
    procedure pMostraAviso;
    procedure pAlteraMotivoPrevisao(dtaEntFut: TDate);
    procedure pLimparTela;
    procedure pCalcularColunaSaldoDisponivel;
    function fGravarRequisicaoCompra(strCodIte: String; strCodCli: String;
      strCodVen: String; fltQtdEnt: Double; strNumDoc: String;
      strEspDoc: String; strEmpDoc: String): Boolean;
    function fProcessamentoRequisicaoCompra: Boolean;
    function fValidaObrigaLoteADefinirEntregaFutura: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fGetActiveControl: TWinControl; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; override;

    procedure pRefresh; override;
    procedure pAcaoAdd; override;
  public
    { Public declarations }
  end;

const
  DATA_VAZIA = '31/12/9999';

implementation

uses SysUtils, Variants, Graphics, untConstantes, untFuncoesSimples,
  untPesqAux, untPai, untConsultas, untFuncFat, untFatAltLoteEntFut, untTypesSistema, untFuncoes,
  untSaldoLojas, untFatRequisicaoCompras, untFuncoesGenerica;

{$R *.dfm}

{ TfrmPaiOrdena1 }

function TfrmAlteracaoEntregaFutura.fGetActiveControl: TWinControl;
begin

  Result := Nil;
  
  If (Not Assigned(ActiveControl)) Then
    Exit;

  If ActiveControl.Parent = pnlTail Then
  Begin
    Exit;
  End;

  pLimparTela;
end;

function TfrmAlteracaoEntregaFutura.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  D.DET_NUMDOC, ';
  Result := Result + '  D.DET_ESPDOC, ';
  Result := Result + '  D.DET_CODEMP, ';
  Result := Result + '  D.DET_CODCLI, ';
  Result := Result + '  D.DET_CODVEN, ';
  Result := Result + '  D.DET_SERIE_, ';
  Result := Result + '  D.DET_CODITE, ';
  Result := Result + '  D.DET_DESCRI, ';
  Result := Result + '  D.DET_REFERE, ';
  Result := Result + '  D.DET_QTDITE - IFNULL(D.DET_QTDENT, 0) AS DET_QTDITE, ';
  Result := Result + '  D.DET_UNITAR, ';
  Result := Result + '  ((D.DET_TOTITE / D.DET_QTDITE) * (D.DET_QTDITE - IFNULL(D.DET_QTDENT, 0))) AS DET_TOTITE, ';
  Result := Result + '  D.DET_ENTFUT, ';
  Result := Result + '  D.DET_MOTFUT AS DET_MOTANT, ';
  Result := Result + '  D.DET_MOTFUT, ';
  Result := Result + '  D.DET_DTAFUT, ';
  Result := Result + '  D.DET_DTAFUT AS DET_DTAANT, ';
  Result := Result + '  D.AUTOINCREM, ';
  Result := Result + '  ITE_DIAFOR, ';
  Result := Result + '  D.DET_UNIDAD, ';
  Result := Result + '  T.DET_CLIBUS, ';
  Result := Result + '  D.DET_NUMLOT, ';
  Result := Result + '  I.ITE_CNV_ML, ';
  Result := Result + '  (G.ITE_SALDOS + ' + fGetSQLSomaCamposEntregaFutura('G') + ') AS ITE_SALFIS, ';
  Result := Result + '  0.0000 AS SALDIS, ';
  Result := Result + '  "" AS COD_REQEXC, ';
  Result := Result + '  0  AS INS_REQCMP ';
  Result := Result + 'FROM ';
  Result := Result + '  MOVDET D ';
  Result := Result + '  INNER JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER ';
  Result := Result + '  INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE ';
  Result := Result + '  INNER JOIN ITEGER G ON G.ITE_CODITE = D.DET_CODITE ';
  Result := Result + '                     AND G.ITE_CODEMP = D.DET_CODEMP ';
  Result := Result + 'WHERE ';
  Result := Result + '  DET_NUMDOC = :NUMDOC AND ';
  Result := Result + '  DET_ESPDOC = :ESPDOC AND ';
  Result := Result + '  DET_CODEMP = :CODEMP AND ';
  Result := Result + '  DET_CODCLI = :CODCLI AND ';
  Result := Result + '  IFNULL(DET_SERIE_, "") = :SERIE_ AND ';
  Result := Result + '  DET_TIP_FC = "C"     AND ';
  Result := Result + '  ( (RIGHT( DET_CLAFIS, 3 ) = "117") OR (DET_FILKAR = 0) ) AND ';
  Result := Result + '  DET_PROEMB <> "S" AND ';
  Result := Result + '  DET_QTDENT < DET_QTDITE ';
end;

function TfrmAlteracaoEntregaFutura.fSetParametros: Boolean;
begin
  With qryConsulta Do
  Try
    ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    ParamByName('CODCLI').AsString := edtCodCli.Text;
    If ((edtEspDoc.Text = 'IF') And (fCfgSis('USNFCE', varBoolean) Or fUsaSat)) Then
      ParamByName('SERIE_').AsString := fCfgSis('SERNFC')
    Else
      ParamByName('SERIE_').AsString := fCfgSis('SERFSC');

    Result := TRUE;
  Except
    Result := FALSE;
  End;
end;

function TfrmAlteracaoEntregaFutura.fGravarRequisicaoCompra(strCodIte: String;
  strCodCli: String; strCodVen: String; fltQtdEnt: Double; strNumDoc: String;
  strEspDoc: String; strEmpDoc: String): Boolean;
  Var
    cdsMovRcd : TUniClientDataSet;
    qryMovRcd : TUniQuery;
    strCodSeq : String;
begin
  qryMovRcd := fCriaQuery();
  Try
    qryMovRcd.SQL.Add('SELECT * FROM MOVRCD WHERE FALSE');
    qryMovRcd.Open;

    cdsMovRcd := fCriaClientDatset(qryMovRcd, True);
    Try
      cdsMovRcd.Insert;
      cdsMovRcd.FieldByName('RCD_CODITE').AsString := strCodIte;
      cdsMovRcd.FieldByName('RCD_DESITE').AsString := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodIte]);;
      cdsMovRcd.FieldByName('RCD_OBSERV').AsString := 'Requisição de compra gerada através da rotina de "Alteração de Entrega Futura"';
      cdsMovRcd.FieldByName('RCD_CODEMP').AsString := VS_strCodEmp;
      cdsMovRcd.FieldByName('RCD_QTDITE').AsFloat  := fltQtdEnt;
      cdsMovRcd.FieldByName('RCD_DOCPDV').AsString := strNumDoc;
      cdsMovRcd.FieldByName('RCD_ESPPDV').AsString := strEspDoc;
      cdsMovRcd.FieldByName('RCD_EMPPDV').AsString := strEmpDoc;
      cdsMovRcd.Post;

      Result := TfrmFatRequisicaoCompras.
                  fGravaRequisicaoCompra(strCodSeq, strCodCli, strCodVen,
                                         EmptyStr, cdsMovRcd, False);
    Finally
      FreeAndNil(cdsMovRcd);
    End;
  Finally
    FreeAndNil(qryMovRcd);
  End;
end;

function TfrmAlteracaoEntregaFutura.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtNumDoc) Then
  Begin

    If fEmptyStr(edtNumDoc.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O número do documento deve ser preenchido!', ['&Ok']);
      Result := False;
    End;

  End
  Else If (Sender = edtEspDoc) Then
  Begin
    If fEmptyStr(edtEspDoc.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A espécie do documento deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtCodEmp) Then
  Begin
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A empresa deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaEmpresa;
      If (qryCadEmp.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodCli) Then
  Begin
    If fEmptyStr(edtCodCli.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O cliente deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaCliente;
      If (qryCadCli.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        dbgConsulta.Enabled := True;
        fAbreConsulta(True);

        If (Not cdsConsulta.IsEmpty) Then
        Begin
          if (Pos('117',fRetornaInformacaoVenda(edtNumDoc.text, edtEspDoc.text, edtCodEmp.text, 'CLAFIS')) > 0) Or
             (Pos('116',fRetornaInformacaoVenda(edtNumDoc.text, edtEspDoc.text, edtCodEmp.text, 'CLAFIS')) > 0) then
          begin
            fMensagem('ATENÇÃO!', 'Documento de baixa de entrega futura não pode ser alterado!', ['&Ok']);
            Result := False;
            pLimparTela;
          end;

          If (Not cdsConsulta.IsEmpty) Then
          Begin
            If (cdsConsulta.FieldByName('DET_ENTFUT').AsSTring = 'N') Then
            Begin
              If fCfgSis('HEFCOE', varBoolean) Then
                pAlteraParaEntregaFutura
              Else
              Begin
                fMensagem('ATENÇÃO!', 'Este documento não é de entrega futura e sendo assim, não pode ser alterado por esta rotina.', ['&Ok']);
                Result := False;
                pLimparTela;
              End;
            End;

            lflLastField.intIndCol := 0;
            lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
            lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
            lflLastField.ftyTipCam := ftString;

            if not cdsConsulta.IsEmpty then
            begin
              cdsConsulta.DisableControls;
              cdsConsulta.First;
              While (Not cdsConsulta.Eof) Do
              Begin
                If (cdsConsulta.FieldByName('DET_ENTFUT').AsString = 'S') Then
                  pAddListaQuery;
                cdsConsulta.Next;
              End;
              cdsConsulta.First;
              cdsConsulta.EnableControls;
              pAlterandoEntFut(False);
            end;

            pSetFocus(edtCodCli);
            dbgConsulta.Repaint;
            Application.ProcessMessages;
          End;
          
        End;
      End;
    End;
  End

  Else If (Sender = mskDtaFut) And mskDtaFut.Enabled And blnBuscaPorChave Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaFut.Text)) Then
    Begin
      fMensagem('','A data de entrega futura deve ser preenchida!', ['&OK']);
      Result := False;
    End
    Else

    Case cmbMotEntFut.ItemIndex Of
      0: Begin
           If (cdsConsulta.FieldByName('DET_DTAFUT').AsString = DATA_VAZIA) Or (cdsConsulta.FieldByName('DET_DTAFUT').AsString <> cdsConsulta.FieldByName('DET_DTAANT').AsString) Then
           Begin
             If StrToDate(mskDtaFut.Text) < VS_DATE + cdsConsulta.FieldByName('ITE_DIAFOR').AsInteger Then
             Begin
               fMensagem('','A data deve ser maior ou igual a ' +
                  DateToStr(VS_DATE + cdsConsulta.FieldByName('ITE_DIAFOR').AsInteger) + '!', ['&OK']);
               Result := False;
             End;
           End;
         End;

      1: mskDtaFut.Text := '31/12/9999';

      2: Begin
           If (cdsConsulta.FieldByName('DET_DTAFUT').AsString = DATA_VAZIA) Or (cdsConsulta.FieldByName('DET_DTAFUT').AsString <> cdsConsulta.FieldByName('DET_DTAANT').AsString) Then
           Begin
             If (StrToDate(mskDtaFut.Text) < VS_Date) Then
             Begin
               fMensagem('','A data deve ser maior ou igual a data atual!', ['&OK']);
              Result := False;
             End

             Else If Assigned(objConEnt) Then
             Begin
               If cdsConsulta.FieldByName('DET_MOTFUT').AsString = 'P' Then
               Begin
                 If Length(objConEnt.arrDtaOri) = 0 Then
                 Begin
                   objConEnt.fSetNumDoc(cdsConsulta.FieldByName('DET_NUMDOC').AsString,
                                        cdsConsulta.FieldByName('DET_ESPDOC').AsString,
                                        cdsConsulta.FieldByName('DET_CODEMP').AsString,
                                        cdsConsulta.FieldByName('DET_CODCLI').AsString);
                   objConEnt.pCarregaArrayDatasPeloDocFat(objConEnt.arrDtaOri);
                 End;

                 If (Not objConEnt.fDataExisteNaMatriz(StrToDateDef(mskDtaFut.Text, 0), objConEnt.arrDtaOri)) Then
                 Begin
                   If (Not objConEnt.fDataDisponivel(StrToDateDef(mskDtaFut.Text, 0))) Then
                   Begin
                     fMensagem('ATENÇÃO!', 'Data não disponível para entrega!', ['&Ok']);
                     Result := False;
                   End;
                 End;
               End;
             End;
           End;
         End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmAlteracaoEntregaFutura.fValidaObrigaLoteADefinirEntregaFutura: Boolean;
var
  LEntDef: String;
begin
  Result := False;

  LEntDef := fCfgSis('ENTDEF', varString);

  if (LEntDef = 'N') then
    Exit;

  if (LEntDef = 'F') and (cmbMotEntFut.ItemIndex <> IDX_MOTIVO_FALTA_PRODUTO) then
    Exit;

  if (cdsConsulta.FieldByName('DET_NUMLOT').AsString = 'A DEFINIR') then
    Exit;

  Result := True;
end;

procedure TfrmAlteracaoEntregaFutura.mskDtaFutKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (cmbMotEntFut.ItemIndex = 2) And
     Assigned(objConEnt) And
     fPesqControleEntrega(Self, mskDtaFut, Key) And
     fValidaCampos(mskDtaFut, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmAlteracaoEntregaFutura.pCalcularColunaSaldoDisponivel;
  Var
    objSalLoj: TSaldoLojas;
    recSaldos, recSaldosML: TRecSaldos;
    blnOrdPro: Boolean;
    intCalSal: Integer;
begin
  objSalLoj := TSaldoLojas.Create(Self);
  cdsConsulta.DisableControls;
  Try
    Try
      blnOrdPro := fCfgSis('ORDPRO', varBoolean);
      intCalSal := fCfgSis('CALSAL', varInteger);

      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin
        objSalLoj.pCalculaSaldos(cdsConsulta, recSaldos, recSaldosML,
                                 cdsConsulta.FieldByName('ITE_SALFIS').AsFloat,
                                 edtCodEmp.Text, edtCodEmp.Text,
                                 cdsConsulta.FieldByName('DET_CODITE').AsString,
                                 cdsConsulta.FieldByName('ITE_CNV_ML').AsFloat,
                                 True, False, blnOrdPro, intCalSal);

        cdsConsulta.Edit;
        cdsConsulta.FieldByName('SALDIS').AsFloat := recSaldos.fltSalDis;
        cdsConsulta.Post;

        cdsConsulta.Next;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmAlteracaoEntregaFutura.pCalcularColunaSaldoDisponivel]');
    End;
  Finally
    FreeAndNil(objSalLoj);
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmAlteracaoEntregaFutura.pCarregaCliente;
begin
  pPesquisaCadCli(Nil, qryCadCli, edtCodCli.Text);
  edtNomCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
end;

procedure TfrmAlteracaoEntregaFutura.pCarregaEmpresa;
begin
  pPesquisaCadEmp(Nil, qryCadEmp, edtCodEmp.Text);
  edtNomEmp.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmAlteracaoEntregaFutura.pLimparTela;
begin
  dbgConsulta.DataSource.DataSet.Close;

  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  stlListSelecao.Clear;
  lblTipoDocumento.Caption := '';
end;

procedure TfrmAlteracaoEntregaFutura.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumDoc);
end;

procedure TfrmAlteracaoEntregaFutura.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Assigned(objCadLot) Then
    FreeAndNil(objCadLot);

  inherited;
end;

procedure TfrmAlteracaoEntregaFutura.FormCreate(Sender: TObject);
begin
  inherited;
  objCadLot := TCadLot.Create(Self);
  qryCadEmp := fCriaQuery(Self);
  qryCadCli := fCriaQuery(Self);

  lblTipoDocumento.Caption := '';

  If fCfgSis('DIAENT', varBoolean) Then
    objConEnt := TControleEntregaRomaneio.Create
  Else
    objConEnt := Nil;

  If (fCfgSis('CTLEST') = '1') Then
    btnAlteracaoLote.Caption := '[F9] Alteração de Lote'
  Else
    btnAlteracaoLote.Caption := '[F9] Alteração de Armazém';

  If fCfgSis('CLBUEF',varBoolean) Then
  Begin
    fFindColumnByName(dbgConsulta,'DET_CLIBUS').Visible := True;

    lblCliBus.Visible := True;
    cmbCliBus.Visible := True;
  End
  Else
  Begin
    fFindColumnByName(dbgConsulta,'DET_CLIBUS').Visible := False;

    lblCliBus.Visible := False;
    cmbCliBus.Visible := False;
  End;
end;

procedure TfrmAlteracaoEntregaFutura.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(objConEnt) Then
    FreeAndNil(objConEnt);

end;

procedure TfrmAlteracaoEntregaFutura.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin

    If (ActiveControl) = dbgConsulta Then
    Begin
      pnlHeader.Enabled := True;
      pnlTail.Visible   := False;
      pLimparTela;
      pSetFocus(edtNumDoc);
      Key := 0;
      Exit;
    End;
    
    If (pnlTail.Visible) Then
    Begin
      pAlterandoEntFut(False);
      Key := 0;
      Exit;
    End;
    
    Inherited;
  End
  Else
    Inherited;
end;

procedure TfrmAlteracaoEntregaFutura.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := False;
end;

procedure TfrmAlteracaoEntregaFutura.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoEntregaFutura.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoEntregaFutura.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  If Column.Index = lflLastField.intIndCol then
  Begin
    dbgConsulta.Canvas.Brush.Color:= clInfoBk;
    dbgConsulta.Canvas.Font.Color:= clWindowText;
    dbgConsulta.Canvas.FillRect(Rect);
  End;    

{  With dbgConsulta.Canvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    If blnTemSelecao And fInLista Then
    Begin

      If Brush.Color = clHighLight Then
      Begin
        Font.Color := clHighLightText;
      End Else
      Begin
        Brush.Color := clAqua;
      End;

    End;
  End;}

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmAlteracaoEntregaFutura.btnConfirmaClick(Sender: TObject);
  Var
    qryAux: TUniQuery;
    stlItens: TStringList; //ITENS QUE SAIRAM DA ENTREGA FUTURA

    procedure pMudarEntFut;
    begin
      If Assigned(objConEnt) Then
      Begin
        If cdsConsulta.FieldByName('DET_MOTFUT').AsString = 'P' Then
          objConEnt.pAlteraDataEntregaDocumento(cdsConsulta.FieldByName('DET_DTAFUT').AsDateTime);
      End;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE MOVDET ');
      qryAux.SQL.Add('SET ');
      qryAux.SQL.Add('  DET_ENTFUT = :ENTFUT, ');
      qryAux.SQL.Add('  DET_MOTFUT = :MOTFUT, ');
      qryAux.SQL.Add('  DET_DTAFUT = :DTAFUT ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  AUTOINCREM = :AUTINC ');

      qryAux.ParamByName('ENTFUT').AsString := 'S';
      qryAux.ParamByName('MOTFUT').AsString := cdsConsulta.FieldByName('DET_MOTFUT').AsString;

      If cdsConsulta.FieldByName('DET_DTAFUT').Value <> Null then
        qryAux.ParamByName('DTAFUT').AsDateTime := cdsConsulta.FieldByName('DET_DTAFUT').AsDateTime
      Else
        qryAux.ParamByName('DTAFUT').Value := Null;

      qryAux.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
      qryAux.ExecSQL;

      If (cdsConsulta.FieldByName('DET_MOTANT').AsString = 'F') And (cdsConsulta.FieldByName('DET_MOTFUT').AsString = 'P') Then
      Begin
        qryAux.SQL.Clear;
        qryAux.SQL.Add('UPDATE ');
        qryAux.SQL.Add(' MOVTRI ');
        qryAux.SQL.Add('SET ');
        qryAux.SQL.Add('  DET_TIPFUT = "FP" ');
        qryAux.SQL.Add('WHERE ');
        qryAux.SQL.Add('  DET_SEQGER = :AUTINC ');
        qryAux.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
        qryAux.ExecSQL;
      End;

      If (cdsConsulta.FieldByName('INS_REQCMP').AsInteger = 1) And
         (fMotivoEntFutToIndex(cdsConsulta.FieldByName('DET_MOTFUT').AsString) = 0) Then
      Begin
        fGravarRequisicaoCompra(cdsConsulta.FieldByName('DET_CODITE').AsString,
                                cdsConsulta.FieldByName('DET_CODCLI').AsString,
                                cdsConsulta.FieldByName('DET_CODVEN').AsString,
                                cdsConsulta.FieldByName('DET_QTDITE').AsFloat,
                                cdsConsulta.FieldByName('DET_NUMDOC').AsString,
                                cdsConsulta.FieldByName('DET_ESPDOC').AsString,
                                cdsConsulta.FieldByName('DET_CODEMP').AsString);
      End;

      If (Not fEmptyStr(cdsConsulta.FieldByName('COD_REQEXC').AsString)) And
         (fMotivoEntFutToIndex(cdsConsulta.FieldByName('DET_MOTFUT').AsString) > 0) Then
      Begin
        pExcluiRequisicaoCompra(cdsConsulta.FieldByName('COD_REQEXC').AsString, VS_strCodEmp, Self.Name);
      End;

      If fCfgSis('CLBUEF',varBoolean) Then
      Begin      
        qryAux.SQL.Clear;
        qryAux.SQL.Add('UPDATE ');
        qryAux.SQL.Add(' MOVTRI ');
        qryAux.SQL.Add('SET ');
        qryAux.SQL.Add('  DET_CLIBUS = :CLIBUS ');
        qryAux.SQL.Add('WHERE ');
        qryAux.SQL.Add('  DET_SEQGER = :AUTINC ');
        qryAux.ParamByName('CLIBUS').AsString := cdsConsulta.FieldByName('DET_CLIBUS').AsString;
        qryAux.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
        qryAux.ExecSQL;
      End;

      pGravarLogFut(Self.Name,
                    cdsConsulta.FieldByName('DET_NUMDOC').AsString,
                    cdsConsulta.FieldByName('DET_ESPDOC').AsString,
                    cdsConsulta.FieldByName('DET_CODEMP').AsString,
                    cdsConsulta.FieldByName('DET_CODCLI').AsString,
                    cdsConsulta.FieldByName('DET_SERIE_').AsString,
                    cdsConsulta.FieldByName('DET_CODITE').AsString,
                    strLoginUsuarioLogado,
                    VS_Date,
                    fTime(),
                    cdsConsulta.FieldByName('DET_MOTANT').AsString,
                    cdsConsulta.FieldByName('DET_MOTFUT').AsString,
                    cdsConsulta.FieldByName('DET_DTAANT').AsString,
                    cdsConsulta.FieldByName('DET_DTAFUT').AsString);

      ReprocessarItem(cdsConsulta.FieldByName('DET_CODITE').AsString, '');
    end;

    procedure pAtualizaMovGer;
    begin

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE ');
      qryAux.SQL.Add('  MOVGER ');
      qryAux.SQL.Add('SET ');
      qryAux.SQL.Add('  GER_ENTFUT = :ENTFUT ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('  GER_CODCLI = :CODCLI ');

      qryAux.ParamByName('ENTFUT').AsString := 'S';

      qryAux.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      qryAux.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;
      qryAux.ParamByName('CODCLI').AsString := edtCodCli.Text;
      qryAux.ExecSQL;
      qryAux.Close;
    end;

begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;
    
  qryAux         := fCriaQuery(Self);
  stlItens       := TStringList.Create;

  Try
    cdsConsulta.First;
    fStartTransaction;

    If Assigned(objConEnt) Then
    Begin
      objConEnt.fSetNumDoc(cdsConsulta.FieldByName('DET_NUMDOC').AsString,
                           cdsConsulta.FieldByName('DET_ESPDOC').AsString,
                           cdsConsulta.FieldByName('DET_CODEMP').AsString,
                           cdsConsulta.FieldByName('DET_CODCLI').AsString);
      objConEnt.pCarregaArrayDatasPeloDocFat(objConEnt.arrDtaOri);
    End;  

    While (Not cdsConsulta.Eof) Do
    Begin
      pMudarEntFut;
      cdsConsulta.Next;
    End;

    If Assigned(objConEnt) Then
    Begin
      objConEnt.pCarregaArrayDatasPeloDocFat(objConEnt.arrDtaEnt);

      objConEnt.fProcessaArrayDatasControleEntregaRomaneio;                                   
    End;

    pAtualizaMovGer;
    fCommit;

    fMensagem('', 'Alteração concluída com sucesso!', ['&Ok']);
    fGetActiveControl;

    If (Assigned(ActiveControl)) Or (ActiveControl.Parent <> pnlTail) Then
      pSetFocus(edtNumDoc);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[Gravação dos Arquivos]');
    End;
  End;

  FreeAndNil(stlItens);
  FreeAndNil(qryAux);

end;

procedure TfrmAlteracaoEntregaFutura.pAcaoAdd;
begin
  inherited;
end;

procedure TfrmAlteracaoEntregaFutura.btnAlteracaoLoteClick(Sender: TObject);
Var
  strMotFutBKP: String;
  strCliBusBKP: String;
  strDtaFutBKP: TDateTime;
  intREQCMPBKP: Integer;
  intRecNo: Integer;
begin
  inherited;

  If Not (cdsConsulta.Active And (cdsConsulta.RecordCount > 0)) Then
    Exit;

  If Not (btnAlteracaoLote.Visible And btnAlteracaoLote.Enabled) Then
    Exit;

  Try
    Try
      pCriarFormularios(TfrmFatAltLoteEntFut, frmFatAltLoteEntFut);
      frmFatAltLoteEntFut.pSetProduto(cdsConsulta.FieldByName('DET_CODITE').AsString + ' - ' + cdsConsulta.FieldByName('DET_DESCRI').AsString);
      frmFatAltLoteEntFut.pSetReferencia(cdsConsulta.FieldByName('DET_REFERE').AsString);
      frmFatAltLoteEntFut.pSetUnidade(fRetSiglaUnidade(cdsConsulta.FieldByName('DET_UNIDAD').AsString));
      frmFatAltLoteEntFut.pSetQuantidade(cdsConsulta.FieldByName('DET_QTDITE').AsFloat);
      frmFatAltLoteEntFut.pSetSituacao(fMotivoSiglaToEntFut(cdsConsulta.FieldByName('DET_MOTFUT').AsString));
      frmFatAltLoteEntFut.pSetDtaPrevisao(DateToStr(cdsConsulta.FieldByName('DET_DTAFUT').AsDateTime));
      frmFatAltLoteEntFut.pSetLoteAtual(cdsConsulta.FieldByName('DET_NUMLOT').AsString);
      frmFatAltLoteEntFut.pSetEmpresa(cdsConsulta.FieldByName('DET_CODEMP').AsString);
      frmFatAltLoteEntFut.pSetTabela('MOVDET');
      frmFatAltLoteEntFut.pSetAutInc(cdsConsulta.FieldByName('AUTOINCREM').AsString);
      frmFatAltLoteEntFut.pSetMotFut(cdsConsulta.FieldByName('DET_MOTFUT').AsString);
      If (frmFatAltLoteEntFut.ShowModal = mrOk) Then
      Begin
        If (frmFatAltLoteEntFut.fGravar) Then
        Begin
          fMensagem('AVISO','Alteração do ' + frmFatAltLoteEntFut.fGetTitulo + ' realizada com sucesso!', ['&OK']);
          strMotFutBKP := cdsConsulta.FieldByName('DET_MOTFUT').AsString;
          strCliBusBKP := cdsConsulta.FieldByName('DET_CLIBUS').AsString;
          strDtaFutBKP := cdsConsulta.FieldByName('DET_DTAFUT').AsDateTime;
          intREQCMPBKP := cdsConsulta.FieldByName('INS_REQCMP').AsInteger;

          intRecNo := cdsConsulta.RecNo;

          fAbreConsulta(True);

          If intRecNo > cdsConsulta.RecordCount Then
            Exit;

          cdsConsulta.RecNo := intRecNo;

          cdsConsulta.Edit;
          cdsConsulta.FieldByName('DET_MOTFUT').AsString := strMotFutBKP;
          cdsConsulta.FieldByName('DET_CLIBUS').AsString := strCliBusBKP;
          cdsConsulta.FieldByName('DET_DTAFUT').AsDateTime := strDtaFutBKP;
          cdsConsulta.FieldByName('INS_REQCMP').AsInteger := intREQCMPBKP;
          cdsConsulta.Post;
        End;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmAlteracaoEntregaFutura.btnAlteracaoLoteClick]');
    End;
  Finally
    pFreeAndNil(frmFatAltLoteEntFut);
  End;
end;

procedure TfrmAlteracaoEntregaFutura.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  //Remove a seleção
  pAddListaQuery;
  pAlterandoEntFut(False);
end;

procedure TfrmAlteracaoEntregaFutura.pAlterandoEntFut(blnAlterando: Boolean);
begin
  If blnAlterando Then
  Begin
    If fHaDevolucaoDesteDocumento(edtNumDoc.Text, edtEspDoc.Text,
                                  edtCodEmp.Text, edtCodCli.Text,
                                  cdsConsulta.FieldByName('DET_CODITE').AsString,
                                  'alterado') Then
      Exit;
  End;

  pnlTail.Visible     := blnAlterando;
  dbgConsulta.Enabled := Not blnAlterando;
  pnlHeader.Enabled   := Not blnAlterando;
  pnlBotoes.Enabled   := Not blnAlterando;

  cmbMotEntFut.ItemIndex := fMotivoEntFutToIndex(cdsConsulta.FieldByName('DET_MOTFUT').AsString);
  mskDtaFut.Text    := cdsConsulta.FieldByName('DET_DTAFUT').AsString;
  mskDtaFut.Enabled := cmbMotEntFut.ItemIndex <> 1;

  If fCfgSis('CLBUEF',varBoolean) Then
    cmbCliBus.ItemIndex    := IIf(cdsConsulta.FieldByName('DET_CLIBUS').AsString = 'S', 1, 0);  

  If (blnAlterando) Then
    pSetFocus(cmbMotEntFut)
  Else
    pSetFocus(dbgConsulta);

  blnMudarFoco := True;

  pMostraAviso;
end;

procedure TfrmAlteracaoEntregaFutura.pAlteraMotivoPrevisao(dtaEntFut: TDate);
  Var
    intRecNo: Integer;
Begin
  With cdsConsulta Do
  Begin
    DisableControls;
    intRecNo := RecNo;
    First;

    While Not Eof Do
    Begin
      If FieldByName('DET_MOTFUT').AsString = 'P' Then
      Begin
        Edit;
        FieldByName('DET_DTAFUT').AsDateTime := dtaEntFut;
        Post;
      End;

      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;
End;

function TfrmAlteracaoEntregaFutura.fProcessamentoRequisicaoCompra : Boolean;
Var
    strRequisicaoCompra : String;
    strPedidosReqCompra : String;
begin
  Result := True;
  If (fCfgSis('TRAAME', varBoolean)) And
     (fMotivoEntFutToIndex(cdsConsulta.FieldByName('DET_MOTANT').AsString) = 0) And
     (cmbMotEntFut.ItemIndex > 0) Then
  Begin
    strRequisicaoCompra := fRetornaRequisicaoCompra(cdsConsulta.FieldByName('DET_NUMDOC').AsString,
                                                    cdsConsulta.FieldByName('DET_ESPDOC').AsString,
                                                    cdsConsulta.FieldByName('DET_CODEMP').AsString,
                                                    cdsConsulta.FieldByName('DET_CODITE').AsString);
    If (Not fEmptyStr(strRequisicaoCompra) And fEmptyStr(cdsConsulta.FieldByName('COD_REQEXC').AsString)) Then
    Begin
      strPedidosReqCompra := fPedidosRequisicaoCompra(strRequisicaoCompra, VS_strCodEmp);
      If (Not fEmptyStr(strPedidosReqCompra)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este registro está vinculado à requisição de compra "'+strRequisicaoCompra+'", '+
                              'que foi vinculada ao(s) pedido(s) de compra: '+strPedidosReqCompra+'. '+
                              'Para alterar o motivo, é necessário retirar a requisição do(s) pedido(s) de compra!', ['&Ok']);
        Exit(False);
      End
      Else
      Begin
        If (fMensagem('ATENÇÃO!', 'Este registro está vinculado à requisição de compra "'+strRequisicaoCompra+'", '+
                                  'porém sem pedido de compra vinculado. Se alterar o motivo esta requisição será excluída. '+
                                  'Confirma a alteração?', ['&Sim', '&Não']) = 1) Then
        Begin
          cdsConsulta.Edit;
          cdsConsulta.FieldByName('COD_REQEXC').AsString := strRequisicaoCompra;
          cdsConsulta.Post;
        End
        Else
          Exit(False);
      End;
    End;
  End;

  If (fCfgSis('QGRTMF', varBoolean)) And
     (fCfgSis('FALPRO', varBoolean) Or fCfgSis('FALVEN', varBoolean)) And
     (fMotivoEntFutToIndex(cdsConsulta.FieldByName('DET_MOTANT').AsString) > 0) And
     (cmbMotEntFut.ItemIndex = 0) And
     (cdsConsulta.FieldByName('INS_REQCMP').AsInteger = 0) Then
  Begin
    If (fMensagem('ATENÇÃO!', 'Se alterar o motivo será gerado uma requisição de compra. Confirma a alteração?', ['&Sim', '&Não']) = 1) Then
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('INS_REQCMP').AsInteger := 1;
      cdsConsulta.Post;
      Result := True;
    End
    Else
      Exit(False);
  End;
end;

procedure TfrmAlteracaoEntregaFutura.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  With cdsConsulta Do
  If fValidaCampos(mskDtaFut, True) And fProcessamentoRequisicaoCompra Then
  Begin
    Edit;
    FieldByName('DET_MOTFUT').AsString   := fMotivoEntFutToSigla(cmbMotEntFut.ItemIndex);
    FieldByName('DET_CLIBUS').AsString   := Copy(cmbCliBus.Text,1,1);
    FieldByName('DET_DTAFUT').AsDateTime := StrToDateDef(mskDtaFut.Text, 0);

    If (FieldByName('DET_DTAFUT').AsDateTime = 0) Then
      FieldByName('DET_DTAFUT').Value := Null;

    Post;

    If (FieldByName('DET_MOTFUT').AsString = 'P') And (Assigned(objConEnt)) Then
      pAlteraMotivoPrevisao(FieldByName('DET_DTAFUT').AsDateTime);

    pAlterandoEntFut(False);
  End;
end;

procedure TfrmAlteracaoEntregaFutura.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN Then
  Begin
    pAlterandoEntFut(True);
    Key := 0;
    Exit;
  End;

  inherited;

  If Key = VK_F10 Then
    btnConfirma.Click;

  If Key = VK_F9 Then
    btnAlteracaoLote.Click;
end;

function TfrmAlteracaoEntregaFutura.fAbreConsulta(blnLike: Boolean): Boolean;
begin
  Result := inherited fAbreConsulta(blnLike);
  cdsConsulta.IndexFieldNames := 'AUTOINCREM';

  If (cdsConsulta.IsEmpty) Then
  Begin
    fMensagem('', 'Não encontrei esse documento!', ['&Ok']);
    pSetFocus(edtNumDoc);
    Exit;
  End;

  TFloatField(cdsConsulta.FieldByName('DET_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsConsulta.FieldByName('SALDIS')).DisplayFormat     := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsConsulta.FieldByName('DET_UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

  pCalcularColunaSaldoDisponivel;

  If (cdsConsulta.FieldByName('DET_ENTFUT').AsString = 'S') Then
    lblTipoDocumento.Caption := 'DOCUMENTO DE ENTREGA FUTURA'
  Else
  Begin
    lblTipoDocumento.Caption := 'DOCUMENTO DE ENTREGA IMEDIATA';
  End;

end;

procedure TfrmAlteracaoEntregaFutura.pRefresh;
begin
  inherited;
  cdsConsulta.IndexFieldNames := 'AUTOINCREM';
end;

procedure TfrmAlteracaoEntregaFutura.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If (cdsConsulta.Active) And (Not cdsConsulta.IsEmpty) Then
    btnAlteracaoLote.Enabled := (Not fEmptyStr(cdsConsulta.FieldByName('DET_NUMLOT').AsString)) Or
                                (fEmptyStr(cdsConsulta.FieldByName('DET_NUMLOT').AsString) And (objCadLot.fExisteLote(cdsConsulta.FieldByName('DET_CODITE').AsString, VS_strCodEmp)));
end;

procedure TfrmAlteracaoEntregaFutura.cmbMotEntFutChange(Sender: TObject);
begin
  inherited;

  mskDtaFut.Enabled := cmbMotEntFut.ItemIndex <> 1;

  If fValidaObrigaLoteADefinirEntregaFutura Then
  Begin

    If fCfgSis('ENTDEF', varString) = 'F' Then
    Begin
      fMensagem('ATENÇÃO',IIF(fCfgSis('CTLEST') = '1', 'Lote', 'Armazém') + ' informado é inválido quando se trata de Entrega Futura - Falta Produto, utilizar "A DEFINIR"!',['&OK']);

      If cdsConsulta.FieldByName('DET_DTAFUT').AsString = DATA_VAZIA Then
        cmbMotEntFut.ItemIndex := IDX_MOTIVO_AGUARDANDO_CLIENTE
      Else
        cmbMotEntFut.ItemIndex := IDX_MOTIVO_PREVISAO_ENTREGA;
    End
    Else If fCfgSis('ENTDEF', varString) = 'S' Then
    Begin
      fMensagem('ATENÇÃO',IIF(fCfgSis('CTLEST') = '1', 'Lote', 'Armazém') + ' informado é inválido, o '+IIF(fCfgSis('CTLEST') = '1', 'Lote', 'Armazém')+' será alterado para "A DEFINIR"!',['&OK']);
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('DET_NUMLOT').AsString := 'A DEFINIR';
      cdsConsulta.Post;
    End;

    Exit;
  End;

  Case cmbMotEntFut.ItemIndex Of
    0: mskDtaFut.Text := DateToStr(VS_DATE + cdsConsulta.FieldByName('ITE_DIAFOR').AsInteger);
    1: mskDtaFut.Text := '31/12/9999';
    2: mskDtaFut.Text := DateToStr(VS_DATE);
  End;

  pMostraAviso;
end;

procedure TfrmAlteracaoEntregaFutura.pAlteraParaEntregaFutura;
begin
  If (fMensagem('ATENÇÃO!', 'Deseja transformar esse documento em entrega futura?' + sLineBreak +
                            'Caso afirmativo, não será possível desfazer a operação.', ['&Sim', '&Não'], 2) = 2) Then
  Begin
    fGetActiveControl;
    If (Assigned(ActiveControl)) Or (ActiveControl.Parent <> pnlTail) Then
      pSetFocus(edtNumDoc);
    Exit;
  End;

  cdsConsulta.DisableControls;
  Try
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('DET_ENTFUT').AsString := 'S';
      cdsConsulta.FieldByName('DET_MOTFUT').AsString := 'F';
      cdsConsulta.Post;

      cdsConsulta.Next;
    End;

    lblTipoDocumento.Caption := 'DOC. SERÁ TRANSFORMADO EM ENT. FUTURA';
  Finally
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmAlteracaoEntregaFutura.pMostraAviso;
Begin

  pnlAviso.Visible := (cmbMotEntFut.ItemIndex = 2) And Assigned(objConEnt) And pnlTail.Visible;

End;

end.
