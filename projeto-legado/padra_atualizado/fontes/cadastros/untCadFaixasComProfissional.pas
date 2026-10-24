unit untCadFaixasComProfissional;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Mask, DBCtrls, DBEditFocus, UniDataSetProvider, UniClientDataSet, Uni,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, Provider,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFaixasComProfissional = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    pnlFaixas: TPanel;
    Label12: TLabel;
    edtVlrIni: TEditFocus;
    Label1: TLabel;
    edtVlrFin: TEditFocus;
    Label2: TLabel;
    edtPerCom: TEditFocus;
    cxgFaiDesDBTableView1: TcxGridDBTableView;
    cxgFaiDesLevel1: TcxGridLevel;
    cxgFaiDes: TcxGrid;
    cxgFaiDesDBTableView1Column1: TcxGridDBColumn;
    cxgFaiDesDBTableView1Column2: TcxGridDBColumn;
    cxgFaiDesDBTableView1Column3: TcxGridDBColumn;
    dtsFaiDiv: TDataSource;
    Label4: TLabel;
    cdsFaiDiv: TUniClientDataSet;
    dspFaiDiv: TUniDataSetProvider;
    dtsTabela: TDataSource;
    cxStyleRepository: TcxStyleRepository;
    cxsWhite: TcxStyle;
    cxsGreen: TcxStyle;
    edtNomDiv: TEditFocus;
    edtCodDiv: TEditFocus;
    dbeCodDiv: TDBEditFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgFaiDesDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtVlrIniExit(Sender: TObject);
    procedure edtVlrFinExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtPerComExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryFaiDiv: TUniQuery;
    qryCadDiv: TUniQuery;

    intRecNo: Integer;

    function fValidaFaixa(fltValor: Double): Boolean;

    procedure pCarregaFaixa;
    procedure pLimpaEdits;
    procedure pAbreFaixas(strCodigo: String);
    procedure pSalvaReferencia;
    Procedure pAdicionaFaixa(fltValIni, fltValFin, fltPerCom: Double);
    procedure pCarregaCadDiv;

    function fTemFaixaCadastrada: Boolean;
  public
    { Public declarations }
    strCodDiv : String;
  protected
    { Protected declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;


implementation

uses SysUtils, Math, Forms, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadFaixasComProfissional.pInicializaIndices;
Begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('FAI_CODEMP');
  stlCamInd.Add('FAI_CODDIV');

  stlDesInd.Add('Empresa');
  stlDesInd.Add('Código (Profissional)');
end;

procedure TfrmCadFaixasComProfissional.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pnlFaixas.Enabled   := True;
  btnIncluir.Enabled  := False;
  btnAlterar.Enabled  := False;
  btnExcluir.Enabled  := False;  
  pSetFocus(edtVlrIni);
end;

procedure TfrmCadFaixasComProfissional.pLimpaEdits;
Begin
  edtVlrIni.Clear;
  edtVlrFin.Clear;
  edtPerCom.Clear;

  intRecNo := -1;
End;

procedure TfrmCadFaixasComProfissional.pSalvaReferencia;
  Var
    qryAux : TUniQuery;
Begin
  qryAux := fCriaQuery(Self);

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add('DELETE FROM FAIDIV');
    SQL.Add('WHERE (FAI_CODDIV = :CODDIV) ');
    SQL.Add('AND   (FAI_VLRINI = 0) ');
    SQL.Add('AND   (FAI_VLRFIN = 0) ');
    SQL.Add('AND   (FAI_PERCOM = 0) ');
    ParamByName('CODDIV').AsString := qryTabela.FieldByName('FAI_CODDIV').AsString;
    ExecSQL;
  End;

  FreeAndNil(qryAux);

  With cdsFaiDiv Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FAIDIV', VS_strCodEmp);

      Post;
      Next;
    End;
    EnableControls;
  End;

End;

procedure TfrmCadFaixasComProfissional.btnCancelaClick(Sender: TObject);
begin
  inherited;

  cdsFaiDiv.CancelUpdates;

  pLimpaEdits;
  pAbreFaixas(edtCodDiv.Text);

  pnlFaixas.Enabled  := False;
  btnIncluir.Enabled := Not fTemFaixaCadastrada;
  btnAlterar.Enabled := Not btnIncluir.Enabled;
  btnExcluir.Enabled := Not btnIncluir.Enabled;
end;

procedure TfrmCadFaixasComProfissional.btnExcluirClick(Sender: TObject);
  Var
    qryAux : TUniQuery;
Begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  blnExcluiu := False;

  Try
    inherited;

    If blnExcluiu Then
    Begin
      pLimpaEdits;

      qryAux := fCriaQuery(Self);

      With qryAux Do
      Begin
        SQL.Clear;
        SQL.Add('DELETE FROM FAIDIV');
        SQL.Add('WHERE (FAI_CODDIV = :CODDIV) ');
        ParamByName('CODDIV').AsString := strCodDiv;
        ExecSQL;
      End;

      fCommit;
      FreeAndNil(qryAux);

      pAbreFaixas(strCodDiv);
      btnIncluir.Enabled := Not fTemFaixaCadastrada;
      btnAlterar.Enabled := Not btnIncluir.Enabled;
      btnExcluir.Enabled := Not btnIncluir.Enabled;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;
end;

procedure TfrmCadFaixasComProfissional.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If cdsFaiDiv.IsEmpty Then
  Begin
    pMensagemOk('Informe as faixas de faturamento!');
    pSetFocus(edtVlrIni);
  End
  Else
  Begin
    Try
      inherited;

      pSalvaReferencia;

      If blnGravou Then
      Begin
        cdsFaiDiv.ApplyUpdates(0);
        fCommit;
      End
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[btnGravarClick]');
      End;
    End;

    pnlFaixas.Enabled  := False;
    btnIncluir.Enabled := Not fTemFaixaCadastrada;
    btnAlterar.Enabled := Not btnIncluir.Enabled;
    btnExcluir.Enabled := Not btnIncluir.Enabled;
  End;

end;

procedure TfrmCadFaixasComProfissional.btnIncluirClick(Sender: TObject);
begin
  inherited;

  btnIncluir.Enabled := False;
  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;  
  pAbreFaixas(strCodDiv);
  pnlFaixas.Enabled := True;
  pSetFocus(edtVlrIni);
end;

procedure TfrmCadFaixasComProfissional.pAbreFaixas(strCodigo: String);
Begin
  With qryFaiDiv, SQL Do
  Begin
    cdsFaiDiv.Close;
    Close;

    Clear;
    Add('SELECT * FROM FAIDIV');
    Add('WHERE');

    If fEmptyStr(strCodigo) Then
      Add('FALSE')
    Else
    Begin
      Add('FAI_CODDIV = ' + QuotedStr(strCodigo));
    End;

    dspFaiDiv.DataSet := qryFaiDiv;
    cdsFaiDiv.SetProvider(dspFaiDiv);

    Open;

    pSetaClient(qryFaiDiv);
    pSetaClient(cdsFaiDiv);

    cdsFaiDiv.IndexFieldNames := 'FAI_VLRINI';
    cdsFaiDiv.Open;

    TFloatField(cdsFaiDiv.FieldbyName('FAI_VLRINI')).DisplayFormat := '#0.00';
    TFloatField(cdsFaiDiv.FieldbyName('FAI_VLRFIN')).DisplayFormat := '#0.00';
    TFloatField(cdsFaiDiv.FieldbyName('FAI_PERCOM')).DisplayFormat := '#0.00';    
  End;
End;

procedure TfrmCadFaixasComProfissional.pCarregaCadDiv;
begin
  qryCadDiv := fCriaQuery(Nil);
  With qryCadDiv Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT * FROM CADDIV WHERE DIV_CODDIV = :CODDIV');
    ParamByName('CODDIV').AsString := edtCodDiv.Text;
    Open;

    edtNomDiv.Text := FieldByName('DIV_NOMDIV').AsString;    
  End;

  FreeAndNil(qryCadDiv);
end;

procedure TfrmCadFaixasComProfissional.pCarregaFaixa;
Begin
  If Not pnlFaixas.Enabled Then
    Exit;

  With cdsFaiDiv Do
  Begin
    If IsEmpty Then
      Exit;

    edtVlrIni.Text := FormatFloat('#0.00', FieldByName('FAI_VLRINI').AsFloat);
    edtVlrFin.Text := FormatFloat('#0.00', FieldByName('FAI_VLRFIN').AsFloat);
    edtPerCom.Text := FormatFloat('#0.00', FieldByName('FAI_PERCOM').AsFloat);

    intRecNo := RecNo;

    pSetFocus(edtVlrIni);
  End;
End;

procedure TfrmCadFaixasComProfissional.cxgFaiDesDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: pCarregaFaixa;
  End;
end;

procedure TfrmCadFaixasComProfissional.edtVlrFinExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtVlrFin.Text) Then
    edtVlrFin.Text := FormatFloat('#,##0.00', fStrToFloat(edtVlrFin.Text));
end;

procedure TfrmCadFaixasComProfissional.edtVlrIniExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtVlrIni.Text) Then
    edtVlrIni.Text := FormatFloat('#,##0.00', fStrToFloat(edtVlrIni.Text));
end;

procedure TfrmCadFaixasComProfissional.edtPerComExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtPerCom.Text) Then
    edtPerCom.Text := FormatFloat('#,##0.00', fStrToFloat(edtPerCom.Text));
end;

procedure TfrmCadFaixasComProfissional.FormCreate(Sender: TObject);
begin
  inherited;

  intRecNo := -1;

  strNomeTabela := 'FAIDIV';
  strNomeCampo  := 'AUTOINCREM';

  qryTabela := fCriarQuery('SELECT * FROM FAIDIV WHERE FALSE', Self);

  dtsTabela.DataSet   := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodDiv;

  qryFaiDiv := fCriaQuery(Self);
end;

procedure TfrmCadFaixasComProfissional.FormShow(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(strCodDiv) Then
  Begin
    edtCodDiv.Text := strCodDiv;
    pCarregaCadDiv;
  End;

  pAbreFaixas(strCodDiv);
  btnIncluir.Enabled := Not fTemFaixaCadastrada;
  btnAlterar.Enabled := Not btnIncluir.Enabled;
  btnExcluir.Enabled := Not btnIncluir.Enabled;

  pSetFocus(btnSair);
end;

Procedure TfrmCadFaixasComProfissional.pAdicionaFaixa(fltValIni, fltValFin, fltPerCom: Double);
Begin
  with cdsFaiDiv Do
  Begin
    If (RecNo = intRecNo) Or Locate('FAI_VLRINI', fltValIni, []) Then
      Edit
    Else
      Insert;

    FieldByName('FAI_CODDIV').AsString := edtCodDiv.Text;
    FieldByName('FAI_CODEMP').AsString := VS_strCodEmp;
    FieldByName('FAI_VLRINI').AsFloat  := RoundTo(fltValIni, -2);
    FieldByName('FAI_VLRFIN').AsFloat  := RoundTo(fltValFin, -2);
    FieldByName('FAI_PERCOM').AsFloat  := RoundTo(fltPerCom, -2);

    Post;
    pLimpaEdits;
    pSetFocus(edtVlrIni);
  End;
End;

function TfrmCadFaixasComProfissional.fValidaFaixa(fltValor: Double): Boolean;
  Var
    intRecSav: Integer;
Begin
  Result := True;
  With cdsFaiDiv Do
  Begin
    intRecSav := RecNo;
    
    DisableControls;

    First;
    While Not Eof Do
    Begin
      If (intRecNo <> RecNo) And
         (RoundTo(fltValor, -2) >= RoundTo(FieldByName('FAI_VLRINI').AsFloat, -2)) And
         (RoundTo(fltValor, -2) <= RoundTo(FieldByName('FAI_VLRFIN').AsFloat, -2)) Then
      Begin
        Result := False;
        Break;
      End;

      Next;
    End;

    RecNo := intRecSav;
    EnableControls;
  End;
End;

function TfrmCadFaixasComProfissional.fTemFaixaCadastrada: Boolean;
Begin
  inherited;

  With qryTabela Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT *                   ');
    SQL.Add('FROM   FAIDIV              ');
    SQL.Add('WHERE FAI_CODDIV = :CODDIV ');
    ParamByName('CODDIV').AsString := strCodDiv;
    Open;

    Result := Not IsEmpty;
  End;
end;

function TfrmCadFaixasComProfissional.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*************************}
    {* % DESCONTO INICIAL    *)
    {*************************}
    If (Sender = edtVlrIni) Then
    Begin

      If fEmptyStr(edtVlrIni.Text) Then
      Begin
        pLimpaEdits;

        If btnGravar.CanFocus Then
        Begin
          blnMudarFoco := False;
          pSetFocus(btnGravar);
        End;
      End

      Else If (fStrToFloat(edtVlrIni.Text) < 0) Then
      Begin
        pMensagemOk('O valor inicial deve ser maior ou igual a zero!');
        Result := False;
      End Else
      Begin

        If blnBuscaPorChave Then
        Begin

          With cdsFaiDiv Do
          Begin

            If Locate('FAI_VLRINI', fStrToFloat(edtVlrIni.Text), []) Then
            Begin
              pCarregaFaixa;
            End

          End;

        End;

        If Not fValidaFaixa(fStrToFloat(edtVlrIni.Text)) Then
        Begin
          pMensagemOk('O valor inicial já está contido em outra faixa!');
          Result := False;
        End;

      End;

    End

    {*************************}
    {* % DESCONTO FINAL      *)
    {*************************}
    Else If (Sender = edtVlrFin) Then
    Begin

      If Not fEmptyStr(edtVlrIni.Text) Then
      Begin
        If (fStrToFloat(edtVlrFin.Text) < 0) Then
        Begin
          pMensagemOk('O Valor final deve ser maior ou igual a zero!');
          Result := False;
        End

        Else If fStrToFloat(edtVlrFin.Text) < fStrToFloat(edtVlrIni.Text) Then
        Begin
          pMensagemOk('O valor final deve ser maior ou igual ao valor inicial!');
          Result := False;
        End

        Else If Not fValidaFaixa(fStrToFloat(edtVlrFin.Text)) Then
        Begin
          pMensagemOk('O Valor final já está contido em outra faixa!');
          Result := False;
        End;
      End

      Else edtVlrFin.Clear;

    End

    {*************************}
    {* % COMISSÃO            *)
    {*************************}
    Else If (Sender = edtPerCom) Then
    Begin

      If Not fEmptyStr(edtVlrIni.Text) Then
      Begin
        If fEmptyStr(edtPerCom.Text) Then
          edtPerCom.Text := '0';

        If (StrToIntDef(edtPerCom.Text, 0) < 0) Or
           (StrToIntDef(edtPerCom.Text, 0) > 100) Then
        Begin
          pMensagemOk('A comissão deve ser maior ou igual a zero e maior ou igual a cem!');
          Result := False;
        End;

        If Result Then
        Begin
          pAdicionaFaixa(fStrToFloat(edtVlrIni.Text),
                         fStrToFloat(edtVlrFin.Text),
                         fStrToFloat(edtPerCom.Text));
          blnMudarFoco := False;
        End;

      End

      Else edtPerCom.Clear;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

