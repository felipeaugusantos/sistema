unit untCadSalBalancoLote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, untModulo,
  untCadLote, untCadSalBalanco,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmCadSalBalancoLote = class(TfrmPaiOrdena)
    qryCadIte: TUniQuery;
    cdsConsultaTOT_SALBAL: TAggregateField;
    cdsConsultaMIN_DTABAL: TAggregateField;
    edtSalTot: TEditFocus;
    Label1: TLabel;
    edtMinDta: TEditFocus;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    lblSalTotML: TLabel;
    edtSalTotML: TEditFocus;
    cdsConsultaTOT_SALBALML: TAggregateField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure dbgConsultaExit(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbgConsultaEnter(Sender: TObject);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    procedure pMostraTotal;
    Function fValidaSaldos: Boolean;

    Function fGravaLotes(cdsSalLot: TUniClientDataSet): Boolean;

  public
    { Public declarations }
    objCadLot: TCadLot;
    strCodIte: String;
    blnItemTintaMaquina: boolean;

    frmCadSalBalanco: TfrmCadSalBalanco;
    
    procedure pAbreConsulta;
    procedure pAjustaTela;

  protected
    procedure pSetaProviderFlags;override;
    function fGetSql(blnLike: Boolean): String; Override;
  end;

var
  frmCadSalBalancoLote: TfrmCadSalBalancoLote;

implementation

uses untFuncoesSimples, untCadLoteItens;

{$R *.dfm}

function TfrmCadSalBalancoLote.fGetSql(blnLike: Boolean): String;
Begin
  Result := objCadLot.fSqlLotIte(strCodIte);
end;

procedure TfrmCadSalBalancoLote.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  qryCadIte.Close;

end;

procedure TfrmCadSalBalancoLote.pMostraTotal;
Begin
  edtSalTot.Text := FloatToStrF(TAggregateField(cdsConsulta.FieldByName('TOT_SALBAL')).Value, ffNumber, 12, 4);
  edtSalTotML.Text := FloatToStrF(TAggregateField(cdsConsulta.FieldByName('TOT_SALBALML')).Value, ffNumber, 12, 4);
  edtMinDta.Text := DateToStr(TAggregateField(cdsConsulta.FieldByName('MIN_DTABAL')).Value);
End;

procedure TfrmCadSalBalancoLote.pSetaProviderFlags;
var i : integer;
begin
  for i := 0 To qryConsulta.Fields.Count -1 do
  begin
    qryConsulta.fields[i].ProviderFlags := [pfInUpdate];
  end;
  qryConsulta.FieldByName('LOT_NUMLOT').ProviderFlags := [pfInKey, pfInWhere];
  qryConsulta.FieldByName('LOT_CODITE').ProviderFlags := [pfInKey, pfInWhere];
  qryConsulta.FieldByName('LOT_CODEMP').ProviderFlags := [pfInKey, pfInWhere];
end;

procedure TfrmCadSalBalancoLote.FormShow(Sender: TObject);
begin
  inherited;

  blnSempreRelerBanco := False;
  blnTemSelecao       := False;

  lflLastField.intIndCol := 3;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftDateTime;

  dbgConsulta.Columns[0].Title.Caption := 'Número do ' + objCadLot.strTitLab;

  pAjustaTela;

end;

procedure TfrmCadSalBalancoLote.pAbreConsulta;
Begin
  fAbreConsulta(True);

  (cdsConsulta.FieldByName('LOT_SALDOS') As TFloatField).DisplayFormat := '#0.0000';
  (cdsConsulta.FieldByName('LOT_SALBAL') As TFloatField).DisplayFormat := '#0.0000';
  (cdsConsulta.FieldByName('LOT_SAL_ML') As TFloatField).DisplayFormat := '#0.0000';
  (cdsConsulta.FieldByName('LOT_ML_BAL') As TFloatField).DisplayFormat := '#0.0000';

  pMostraTotal;
End;

procedure TfrmCadSalBalancoLote.pAjustaTela;
begin
  If Not blnItemTintaMaquina Then
  Begin
    dbgConsulta.Columns[4].Visible := False;
    dbgConsulta.Columns[5].Visible := False;
    dbgConsulta.Columns[1].Width := 110;
    dbgConsulta.Columns[1].Width := 110;
    lblSalTotML.Visible := False;
    edtSalTotML.Visible := False;
  End
  Else
  Begin
    dbgConsulta.Columns[4].Visible := True;
    dbgConsulta.Columns[5].Visible := True;
    dbgConsulta.Columns[1].Width := 100;
    dbgConsulta.Columns[1].Width := 100;
    lblSalTotML.Visible := True;
    edtSalTotML.Visible := True;
  End;
end;

procedure TfrmCadSalBalancoLote.btnIncluirClick(Sender: TObject);
  Var
    frmCadLoteItens : TfrmCadLoteItens;
begin
  inherited;

  Try
    pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
    If Assigned(frmCadLoteItens) Then
    Begin
      cdsConsulta.Tag := 1;
      frmCadLoteItens.cdsSalLot := cdsConsulta;
      frmCadLoteItens.ShowModal;
      FreeAndNil(frmCadLoteItens);
      cdsConsulta.Tag := 0;
    End;

  Except
    cdsConsulta.Tag := 0;
  End;
end;

Function TfrmCadSalBalancoLote.fValidaSaldos: Boolean;
Begin
  With cdsConsulta Do
  Try
    Begin
      DisableControls;
      First;
      While Not eof Do
      Begin
        Edit;
        Post;
        Next;
      End;
      EnableControls;
      Result := True;
    End;
  Except
    Result := False;
    EnableControls;
  End;
End;

Function TfrmCadSalBalancoLote.fGravaLotes(cdsSalLot: TUniClientDataSet): Boolean;
Begin
  Try
    fStartTransaction;

    cdsSalLot.DisableControls;

    cdsSalLot.First;
    While Not cdsSalLot.Eof Do
    Begin
      if cdsSalLot.FieldbyName('LOT_SALBAL').OldValue <> cdsSalLot.FieldbyName('LOT_SALBAL').Value then
      begin
        fGravaLogContEst(strLoginUsuarioLogado,
                         strCodIte,
                         cdsSalLot.FieldbyName('LOT_NUMLOT').AsString,
                         cdsSalLot.FieldbyName('LOT_SALBAL').AsFloat,
                         0,
                         '',
                         cdsSalLot.FieldbyName('LOT_SALDOS').AsFloat);
      end;

      cdsSalLot.Edit;
      cdsSalLot.FieldbyName('LOT_DTABAL').AsDateTime  := StrToDateTime(frmCadSalBalanco.mskDtaIni.Text);
      cdsSalLot.FieldbyName('LOT_SALDOS').AsFloat     := cdsSalLot.FieldbyName('LOT_SALBAL').AsFloat;
      cdsSalLot.FieldbyName('LOT_SAL_ML').AsFloat     := cdsSalLot.FieldbyName('LOT_ML_BAL').AsFloat;
      cdsSalLot.Post;
      cdsSalLot.Next;
    End;

    Result := cdsSalLot.ApplyUpdates(-1) = 0;

    If Not Result Then
    Begin
      pMensagemOk('Erro ao atualizar lotes!');
      Result := False;
      fRollBack;
    End

    Else If Not frmCadSalBalanco.fSalvaSaldos(
       TAggregateField(cdsSalLot.FieldByName('TOT_SALBAL')).Value,
       IIF(blnItemTintaMaquina,TAggregateField(cdsSalLot.FieldByName('LOT_ML_BAL')).Value,0),
       StrToDateTime(frmCadSalBalanco.mskDtaIni.Text),
       True) Then
    Begin
      Result := False;
      fRollBack;
    End Else
    begin
      fCommit;
      Result := True;

      frmCadSalBalanco.pMostraLote(False);
    End;

    cdsSalLot.EnableControls;
  Except
    On E: Exception Do
    Begin
      Result := False;
      cdsSalLot.EnableControls;
      fRollBack;
      pMensagensErro(E.Message, '[fGravaLotes]');
    End;
  End;

End;

procedure TfrmCadSalBalancoLote.btnGravarClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.State = dsEdit Then
    cdsConsulta.post;

  pLimpaPesquisa;

  If fValidaSaldos And frmCadSalBalanco.fValidaData And (fMensagem('', 'Confirma a gravação dos saldos?', ['&Sim', '&Não']) = 1) Then
    fGravaLotes(cdsConsulta);

end;

procedure TfrmCadSalBalancoLote.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Const
    COL_SALDO_BALANCO = 2;
    COL_SALDO_BALANCO_ML = 5;
begin
  inherited;

  Case Key Of
    VK_F10:    btnGravar.Click;
    VK_RETURN: If (Not pnlPesquisa.Visible) Then
               Begin
                 Case dbgConsulta.SelectedIndex Of
                   COL_SALDO_BALANCO  : If (cdsConsulta.State = dsEdit) Then
                                        Begin
                                          cdsConsulta.post;
                                          cdsConsulta.Next;
                                          If cdsConsulta.Eof Then
                                            pSetFocus(btnGravar);
                                        End;
                   COL_SALDO_BALANCO_ML : If (cdsConsulta.State = dsEdit) Then
                                          Begin
                                            cdsConsulta.post;
                                            cdsConsulta.Next;
                                            If cdsConsulta.Eof Then
                                              pSetFocus(btnGravar);
                                          End;
                 End;
               End;
  End;

end;

procedure TfrmCadSalBalancoLote.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;

  pMostraTotal;
end;

procedure TfrmCadSalBalancoLote.dbgConsultaExit(Sender: TObject);
begin
  inherited;

  If cdsConsulta.State = dsEdit Then
    cdsConsulta.post;

end;

procedure TfrmCadSalBalancoLote.btnSairClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.Active Then
    cdsConsulta.Close;

end;

procedure TfrmCadSalBalancoLote.dbgConsultaEnter(Sender: TObject);
begin
  inherited;

  cdsConsulta.FieldByName('LOT_SALBAL').FocusControl;
end;

procedure TfrmCadSalBalancoLote.cdsConsultaBeforePost(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If FieldByName('LOT_SALBAL').AsFloat < 0 Then
    Begin
      fMensagem('', 'O Saldo não pode ser negativo!', ['&Ok']);
      Cancel;
      Abort;
      Exit;
    End;

  End;

end;

end.
