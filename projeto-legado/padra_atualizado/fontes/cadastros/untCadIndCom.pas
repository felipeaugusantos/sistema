unit untCadIndCom;

interface

uses
  Windows, Classes, Controls, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, EditFocus, Grids, DBGridCitel, DBGrids, DB, Uni, BitBtnLockedIncrem,
  untComIndBussines, UniClientDataSet, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadIndCom = class(TfrmPai)
    pnlMetaAtingida: TPanel;
    pnlFaturamento: TPanel;
    pnlMetasNAtingidas: TPanel;
    dbgComAt: TDBGridCitel;
    edtDescri: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dbeComNt: TDBGridCitel;
    edtDescriNA: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtValIni: TEditFocus;
    edtValFin: TEditFocus;
    edtPerCom: TEditFocus;
    edtValIniNA: TEditFocus;
    edtValFinNA: TEditFocus;
    edtPerComNA: TEditFocus;
    edtMeta: TEditFocus;
    dtsComIAT: TDataSource;
    dtsComINT: TDataSource;
    btnAdicionarAt: TBitBtnLocked;
    btnAdicionarNt: TBitBtnLocked;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btnGravar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure dbgComAtKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeComNtKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAdicionarAtClick(Sender: TObject);
    procedure edtMetaExit(Sender: TObject);
    procedure btnAdicionarNtClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtMetaEnter(Sender: TObject);
    procedure dbgComAtDblClick(Sender: TObject);
    procedure dbeComNtDblClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtDescriNAEnter(Sender: TObject);
    procedure edtValIniNAEnter(Sender: TObject);
    procedure edtValFinNAEnter(Sender: TObject);
    procedure edtPerComNAEnter(Sender: TObject);
    procedure edtDescriEnter(Sender: TObject);
    procedure edtValIniEnter(Sender: TObject);
    procedure edtValFinEnter(Sender: TObject);
    procedure edtPerComEnter(Sender: TObject);
  private
    { Private declarations }
    objComIndBussines: TComIndBussines;

    cdsComIAt: TUniClientDataSet;
    cdsComINt: TUniClientDataSet;
    intUltAutIncAti,
    intUltAutIncNAt: Integer;

    fltValIniAtiOld,
    fltValFinAtiOld,
    fltValIniNAtOld,
    fltValFinNAtOld: Double;

    strAutIncAti,
    strAutIncNAt: String;

    blnAtingida: Boolean;
    procedure pLimparCampos;
    procedure pSetaEhAtingida(blnSimNao: Boolean);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, Forms, untFuncoesSimples, untConstantes, untTypesSistema;

{$R *.dfm}

procedure TfrmCadIndCom.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtDescri);
end;

procedure TfrmCadIndCom.FormCreate(Sender: TObject);
  function fGeraAutInc(cdsDados: TUniClientDataSet): Integer;
    Var
      intCont: Integer;
  Begin
    Result := 0;
    
    Try
      With cdsDados Do
      Begin
        TFloatField(FieldByName('COM_VALINI')).DisplayFormat := '#,##0.00';
        TFloatField(FieldByName('COM_VALFIN')).DisplayFormat := '#,##0.00';
        TFloatField(FieldByName('COM_PERCOM')).DisplayFormat := '#,##0.00';

        If Not IsEmpty Then
        Begin
          IndexFieldNames := '';

          intCont := 1;
          First;

          While Not Eof Do
          Begin
            Edit;
            FieldByName('AUTOINCREM').AsInteger := intCont;
            Post;

            Inc(intCont);
            Next;
          End;

          IndexFieldNames := 'COM_DESCRI;COM_VALINI;COM_VALFIN';
          Result := intCont;
        End;
      End;
    Except
      On E:Exception Do
        pMensagensErro('', E.Message);
    End;
  End;
begin
  inherited;

  fltValIniAtiOld := 0;
  fltValFinAtiOld := 0;
  fltValIniNAtOld := 0;
  fltValFinNAtOld := 0;
  strAutIncAti    := '';
  strAutIncNAt    := '';

  objComIndBussines := TComIndBussines.Create;

  cdsComIAt := objComIndBussines.fGetClientComIndAti;
  cdsComINt := objComIndBussines.fGetClientComIndNAt;

  intUltAutIncAti := fGeraAutInc(cdsComIAt);
  intUltAutIncNAt := fGeraAutInc(cdsComINt);

  dtsComIAT.DataSet := cdsComIAt;
  dtsComINT.DataSet := cdsComINt;

  edtMeta.Text := FloatToStrF(objComIndBussines.fGetMetaFaturamento, ffNumber, 12, 2);

end;

procedure TfrmCadIndCom.FormDestroy(Sender: TObject);
begin
  inherited;

  objComIndBussines.Destroy;

  If Assigned(cdsComIAt) Then
    FreeAndNil(cdsComIAt);

  If Assigned(cdsComINt) Then
    FreeAndNil(cdsComINt);

  fRollBack;
end;

procedure TfrmCadIndCom.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_RETURN Then
  Begin
    If dbgComAt.Focused Then
      dbgComAtDblClick(Nil)
    Else If dbeComNt.Focused Then
      dbeComNtDblClick(Nil);
  End;
end;

procedure TfrmCadIndCom.dbgComAtDblClick(Sender: TObject);
begin
  inherited;

  If Not cdsComIAt.IsEmpty Then
  Begin
    cdsComIAt.Edit;
    strAutIncAti    := cdsComIAt.FieldByName('AUTOINCREM').AsString;
    fltValIniAtiOld := cdsComIAt.FieldByName('COM_VALINI').AsFloat;
    fltValFinAtiOld := cdsComIAt.FieldByName('COM_VALFIN').AsFloat;
    edtDescri.Text  := cdsComIAt.FieldByName('COM_DESCRI').AsString;
    edtValIni.Text  := FloatToStrF(cdsComIAt.FieldByName('COM_VALINI').AsFloat, ffNumber, 12, 2);
    edtValFin.Text  := FloatToStrF(cdsComIAt.FieldByName('COM_VALFIN').AsFloat, ffNumber, 12, 2);
    edtPerCom.Text  := FloatToStrF(cdsComIAt.FieldByName('COM_PERCOM').AsFloat, ffNumber, 12, 2);
    pSetFocus(edtDescri);

    pnlMetasNAtingidas.Enabled := False;
    dbgComAt.Enabled := False;
  End;
end;


procedure TfrmCadIndCom.dbgComAtKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  Var
    cdsTmp: TUniClientDataSet;
begin
  inherited;

  Case Key Of
    VK_DELETE:
      Begin
        If Not cdsComIAt.IsEmpty Then
        Begin
          {**************************************}
          {* CLONA E DEPOIS REMOVE O AUTOINCREM *}
          {* POIS NÃO EXISTE NESSA TABELA       *}
          {***********************************FC*}
          cdsTmp := TUniClientDataSet.Create(Self);
          pCloneDataSet(cdsTmp, cdsComIAt);
          cdsTmp.Locate('AUTOINCREM', cdsComIAt.FieldByName('AUTOINCREM').AsString, []);
          cdsTmp.Fields.Remove(cdsTmp.Fields[0]);
          fVerificaIntegridade(Self.Name, 'COMIAT', cdsTmp, True, False);
          FreeAndNil(cdsTmp);

          cdsComIAt.Delete;
        End;
      End;
  End;
end;

procedure TfrmCadIndCom.dbeComNtDblClick(Sender: TObject);
begin
  inherited;

  If Not cdsComINt.IsEmpty Then
  Begin
    cdsComINt.Edit;
    strAutIncNAt     := cdsComINt.FieldByName('AUTOINCREM').AsString;
    fltValIniNAtOld  := cdsComINt.FieldByName('COM_VALINI').AsFloat;
    fltValFinNAtOld  := cdsComINt.FieldByName('COM_VALFIN').AsFloat;
    edtDescriNA.Text := cdsComINt.FieldByName('COM_DESCRI').AsString;
    edtValIniNA.Text := FloatToStrF(cdsComINt.FieldByName('COM_VALINI').AsFloat, ffNumber, 12, 2);
    edtValFinNA.Text := FloatToStrF(cdsComINt.FieldByName('COM_VALFIN').AsFloat, ffNumber, 12, 2);
    edtPerComNA.Text := FloatToStrF(cdsComINt.FieldByName('COM_PERCOM').AsFloat, ffNumber, 12, 2);
    pSetFocus(edtDescriNA);
    pnlMetaAtingida.Enabled := False;
    dbeComNt.Enabled := False;
  End;
end;

procedure TfrmCadIndCom.dbeComNtKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  Var
    cdsTmp: TUniClientDataSet;
begin
  inherited;

  Case Key Of
    VK_DELETE:
      Begin
        If Not cdsComINt.IsEmpty Then
        Begin
          {**************************************}
          {* CLONA E DEPOIS REMOVE O AUTOINCREM *}
          {* POIS NÃO EXISTE NESSA TABELA       *}
          {***********************************FC*}
          cdsTmp := TUniClientDataSet.Create(Self);
          pCloneDataSet(cdsTmp, cdsComINt);
          cdsTmp.Locate('AUTOINCREM', cdsComINt.FieldByName('AUTOINCREM').AsString, []);
          cdsTmp.Fields.Remove(cdsTmp.Fields[0]);
          fVerificaIntegridade(Self.Name, 'COMINT', cdsTmp, True, False);
          FreeAndNil(cdsTmp);

          cdsComINt.Delete;
        End;
      End;
  End;
end;

procedure TfrmCadIndCom.btnAdicionarAtClick(Sender: TObject);
  Var
    objTipoAcao: TAcaoObjeto;
begin
  inherited;

  pSetaEhAtingida(True);

  If fEmptyStr(strAutIncAti) Then
    objTipoAcao := aoInserindo
  Else
    objTipoAcao := aoEditando;

  If fVerificaCampos And
     objComIndBussines.fValidaFaixaValor(fStrToFloat(edtValIni.Text),
                                         fStrToFloat(edtValFin.Text),
                                         fltValIniAtiOld,
                                         fltValFinAtiOld,
                                         objTipoAcao,
                                         'COMIAT',
                                         strAutIncAti,
                                         cdsComIAt) Then
  Begin
    Try
      If objTipoAcao <> aoEditando Then
      Begin
        cdsComIAt.Append;
        cdsComIAt.FieldByName('AUTOINCREM').AsInteger := intUltAutIncAti;
      End
      Else
        cdsComIAt.Edit;
        
      cdsComIAt.FieldByName('COM_DESCRI').AsString := edtDescri.Text;
      cdsComIAt.FieldByName('COM_VALINI').AsFloat  := fStrToFloat(edtValIni.Text);
      cdsComIAt.FieldByName('COM_VALFIN').AsFloat  := fStrToFloat(edtValFin.Text);
      cdsComIAt.FieldByName('COM_PERCOM').AsFloat  := fStrToFloat(edtPerCom.Text);

      If fEmptyStr(edtMeta.Text) Then
        edtMeta.Text := '0,00';

      cdsComIAt.FieldByName('COM_METFAT').AsFloat  := fStrToFloat(edtMeta.Text);
      cdsComIAt.Post;
      
      Inc(intUltAutIncAti);
      fltValIniAtiOld := 0;
      fltValFinAtiOld := 0;
      strAutIncAti := '';
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadIndCom.btnAdicionarAtClick]');
    End;

    pLimparCampos;
    pSetFocus(edtDescri);
    pnlMetasNAtingidas.Enabled := True;
    dbgComAt.Enabled := True;
  End;
end;

procedure TfrmCadIndCom.edtDescriEnter(Sender: TObject);
begin
  inherited;
  pSetaEhAtingida(True);
end;

procedure TfrmCadIndCom.edtDescriNAEnter(Sender: TObject);
begin
  inherited;
  pSetaEhAtingida(False);
end;

procedure TfrmCadIndCom.edtMetaEnter(Sender: TObject);
begin
  inherited;

  If cdsComIAt.RecordCount <= 0 Then
  Begin
    fMensagem('','Para digitar uma meta de faturamento deve primeiro haver pelo menos uma faixa de índice.', ['&OK']);
    edtMeta.Text := '0,00';
    pSetFocus(edtDescri);
  End;

end;

procedure TfrmCadIndCom.edtMetaExit(Sender: TObject);
begin
  inherited;

  If fStrToFloat(edtMeta.Text) > 0 Then
  Begin

    Try
      cdsComIAt.First;
      While Not cdsComIAt.Eof Do
      Begin
        cdsComIAt.Edit;
        cdsComIAt.FieldByName('COM_METFAT').AsFloat := fStrToFloat(edtMeta.Text);
        cdsComIAt.Post;

        cdsComIAt.Next;
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadIndCom.edtMetaExit]');
    End;

  End;

end;

procedure TfrmCadIndCom.edtPerComEnter(Sender: TObject);
begin
  inherited;
  pSetaEhAtingida(True);
end;

procedure TfrmCadIndCom.edtPerComNAEnter(Sender: TObject);
begin
  inherited;
  pSetaEhAtingida(False);
end;

procedure TfrmCadIndCom.edtValFinEnter(Sender: TObject);
begin
  inherited;
  pSetaEhAtingida(True);
end;

procedure TfrmCadIndCom.edtValFinNAEnter(Sender: TObject);
begin
  inherited;
  pSetaEhAtingida(False);
end;

procedure TfrmCadIndCom.edtValIniEnter(Sender: TObject);
begin
  inherited;
  pSetaEhAtingida(True);
end;

procedure TfrmCadIndCom.edtValIniNAEnter(Sender: TObject);
begin
  inherited;
  pSetaEhAtingida(False);
end;

procedure TfrmCadIndCom.btnAdicionarNtClick(Sender: TObject);
  Var
    objTipoAcao: TAcaoObjeto;
begin
  inherited;

  pSetaEhAtingida(False);

  If fEmptyStr(strAutIncNAt) Then
    objTipoAcao := aoInserindo
  Else
    objTipoAcao := aoEditando;

  If fVerificaCampos And
     objComIndBussines.fValidaFaixaValor(fStrToFloat(edtValIniNA.Text),
                                         fStrToFloat(edtValFinNA.Text),
                                         fltValIniNAtOld,
                                         fltValFinNAtOld,
                                         objTipoAcao,
                                         'COMINT',
                                         strAutIncNAt,
                                         cdsComINt) Then
  Begin
    Try
      If objTipoAcao <> aoEditando Then
      Begin
        cdsComINt.Append;
        cdsComINt.FieldByName('AUTOINCREM').AsInteger := intUltAutIncAti;
      End
      Else
        cdsComINt.Edit;
        
      cdsComINt.FieldByName('COM_DESCRI').AsString := edtDescriNA.Text;
      cdsComINt.FieldByName('COM_VALINI').AsFloat  := fStrToFloat(edtValIniNA.Text);
      cdsComINt.FieldByName('COM_VALFIN').AsFloat  := fStrToFloat(edtValFinNA.Text);
      cdsComINt.FieldByName('COM_PERCOM').AsFloat  := fStrToFloat(edtPerComNA.Text);
      cdsComINt.Post;

      Inc(intUltAutIncNAt);
      fltValIniNAtOld := 0;
      fltValFinNAtOld := 0;
      strAutIncNAt := '';
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadIndCom.btnAdicionarNtClick]');
    End;

    pLimparCampos;
    pSetFocus(edtDescriNA);
    pnlMetaAtingida.Enabled := True;
    dbeComNt.Enabled := True;
  End;
end;

procedure TfrmCadIndCom.btnGravarClick(Sender: TObject);
  Var
    blnGravou: Boolean;
begin
  inherited;

  If (Not fEmptyStr(strAutIncAti)) Or
     (Not fEmptyStr(strAutIncNAt)) Then
  Begin
    fMensagem('', 'Existem itens sendo alterados!', ['&O K']);

    If Not fEmptyStr(strAutIncAti) Then
      pSetFocus(edtDescri)
    Else If Not fEmptyStr(strAutIncNAt) Then
      pSetFocus(edtDescriNA);
      
    Exit;
  End;

  If fMensagem('', 'Deseja confirmar a gravação?', ['&Sim', '&Não']) = 1 Then
  Begin
    cdsComIAt.DisableControls;
    cdsComINt.DisableControls;

    pLimparCampos;
    blnGravou := False;

    If objComIndBussines.fGravaMetaAtingida(cdsComIAt) Then
      If objComIndBussines.fGravaMetaNaoAtingida(cdsComINt) Then
        blnGravou := True;

    fStartTransaction;
    Try
      If blnGravou Then
      Begin
        fCommit;
        fMensagem('', 'Faixa de índices salvas com sucesso!', ['&O K']);
      End
      Else
      Begin
        fRollBack;
        fMensagem('', 'Falha ao gravar a Faixa de índices!', ['&O K']);
      End;
    Finally
      cdsComIAt.EnableControls;
      cdsComINt.EnableControls;
      Application.ProcessMessages;
    End;

  End;
end;

procedure TfrmCadIndCom.pLimparCampos;
begin
  edtDescri.Clear;
  edtDescriNA.Clear;

  edtValIni.Text   := '0,00';
  edtValIniNA.Text := '0,00';
  edtValFin.Text   := '0,00';
  edtValFinNA.Text := '0,00';
  edtPerCom.Text   := '0,00';
  edtPerComNA.Text := '0,00';
end;

procedure TfrmCadIndCom.pSetaEhAtingida(blnSimNao: Boolean);
begin
  blnAtingida := blnSimNao;
end;

function TfrmCadIndCom.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    aoTipoAcao: TAcaoObjeto;
begin
  Result := True;

  Try
    If blnAtingida Then
    Begin
      If Not fEmptyStr(strAutIncAti) Then
        aoTipoAcao := aoEditando
      Else
        aoTipoAcao := aoNone;

      If (Sender = edtDescri) Then
      Begin
        If fEmptyStr(edtDescri.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['&O K']);
          Result := False;
        End;
      End
      Else If (Sender = edtValIni) Then
      Begin
        If fStrToFloat(edtValIni.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O valor inicial deve ser maior que zero!', ['&O K']);
          Result := False;
        End
        Else If Not objComIndBussines.fValidaValorInvidual(fStrToFloat(edtValIni.Text),
                                                           fltValIniAtiOld,
                                                           aoTipoAcao,
                                                           'COMIAT',
                                                           strAutIncAti,
                                                           cdsComIAt) Then
          Result := False;
      End
      Else If (Sender = edtValFin) Then
      Begin
        If fStrToFloat(edtValFin.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O valor final deve ser maior que zero!', ['&O K']);
          Result := False;
        End
        Else If fStrToFloat(edtValIni.Text) > fStrToFloat(edtValFin.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O valor final deve ser maior que o valor inicial!', ['&O K']);
          Result := False;
        End
        Else If Not objComIndBussines.fValidaValorInvidual(fStrToFloat(edtValFin.Text),
                                                           fltValFinAtiOld,
                                                           aoTipoAcao,
                                                           'COMIAT',
                                                           strAutIncAti,
                                                           cdsComIAt) Then
          Result := False;
      End
      Else If (Sender = edtPerCom) Then
      Begin
        If fStrToFloat(edtPerCom.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O percentual de comissão deve ser maior que zero!', ['&O K']);
          Result := False;
        End;
      End;
    End
    Else
    Begin
      If fEmptyStr(strAutIncNAt) Then
        aoTipoAcao := aoEditando
      Else
        aoTipoAcao := aoNone;

      If (Sender = edtDescriNA) Then
      Begin
        If fEmptyStr(edtDescriNA.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['&O K']);
          Result := False;
        End;
      End
      Else If (Sender = edtValIniNA) Then
      Begin
        If fStrToFloat(edtValIniNA.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O valor inicial deve ser maior que zero!', ['&O K']);
          Result := False;
        End
        Else If Not objComIndBussines.fValidaValorInvidual(fStrToFloat(edtValIniNA.Text),
                                                           fltValIniNAtOld,
                                                           aoTipoAcao,
                                                           'COMINT',
                                                           strAutIncNAt,
                                                           cdsComINt) Then
          Result := False;
      End
      Else If (Sender = edtValFinNA) Then
      Begin
        If fStrToFloat(edtValFinNA.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O valor final deve ser maior que zero!', ['&O K']);
          Result := False;
        End
        Else If fStrToFloat(edtValIniNA.Text) > fStrToFloat(edtValFinNA.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O valor final deve ser maior que o valor inicial!', ['&O K']);
          Result := False;
        End
        Else If Not objComIndBussines.fValidaValorInvidual(fStrToFloat(edtValFinNA.Text),
                                                           fltValFinNAtOld,
                                                           aoTipoAcao,
                                                           'COMINT',
                                                           strAutIncNAt,
                                                           cdsComINt) Then
          Result := False;
      End
      Else If (Sender = edtPerComNA) Then
      Begin
        If fStrToFloat(edtPerComNA.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O percentual de comissão deve ser maior que zero!', ['&O K']);
          Result := False;
        End;
      End;
    End;
  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadIndCom.fValidaCampos]');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
