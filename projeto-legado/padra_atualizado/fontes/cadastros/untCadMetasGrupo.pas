unit untCadMetasGrupo;

interface

uses
  Windows, Classes, Controls, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids,
  Buttons, ExtCtrls, untModulo, BitBtnLockedIncrem, MemDS, DBAccess, Provider,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmCadMetasGrupo = class(TfrmPaiOrdena)
    qryCadGru: TUniQuery;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label1: TLabel;
    edtPerGru: TEditFocus;
    qryCadGruGRU_CODGRU: TStringField;
    qryCadGruGRU_DESGRU: TStringField;
    cdsConsultaMET_CODGRU: TStringField;
    cdsConsultaMET_PERGRU: TFloatField;
    cdsConsultaGRU_DESGRU: TStringField;
    cdsConsultaAUTOINCREM: TStringField;
    cdsConsultaMET_CODEMP: TStringField;
    cdsConsultaMET_MESANO: TStringField;
    cdsConsultaMET_CODVEN: TStringField;
    cdsConsultaTOT_PERGRU: TAggregateField;
    Label3: TLabel;
    edtTotPer: TEditFocus;
    btnExcluir: TBitBtnLocked;
    rdgDefineLinhaGrupo: TRadioGroup;
    cdsConsultaMET_DEFTIP: TStringField;
    cdsConsultaDescrDefLinGru: TStringField;
    lblMarGru: TLabel;
    edtMarGru: TEditFocus;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure cdsConsultaBeforeDelete(DataSet: TDataSet);
    procedure cdsConsultaCalcFields(DataSet: TDataSet);
    procedure rdgDefineLinhaGrupoClick(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaRegistro;
    function  fInsereRegistro: Boolean;
    function  fExisteMargemPreenchida: Boolean;
    function  fRetTotPerGru: Double;
  public
    { Public declarations }
    cdsCadMet: TUniClientDataSet;
    strMesAno: String;

    Procedure pLimpaDados(blnSetFocus: Boolean = True);
    procedure pAbreConsulta;

    function  fValidaTotalGrupo: Boolean;

  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadMetasGrupo: TfrmCadMetasGrupo;

implementation

uses SysUtils, Variants, Math, untPai, untConsultas, untFuncoesSimples, untTypesSistema,
  untCadMetasValor;

{$R *.dfm}

function TfrmCadMetasGrupo.fExisteMargemPreenchida: Boolean;
begin
  Result := False;
  cdsConsulta.DisableControls;
  Try
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If fFormataFloat(cdsConsulta.FieldByName('MET_MARGRU').AsFloat, 2) > 0 Then
      Begin
        Result := True;
        Break;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.EnableControls;
  End;
end;

function TfrmCadMetasGrupo.fGetSql(blnLike: Boolean): String;
Begin
  Result := '';
  Result := Result + ' SELECT * FROM DETMET ';
  Result := Result + ' WHERE MET_MESANO = ' + QuotedStr(strMesAno);
End;

procedure TfrmCadMetasGrupo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = '-' Then
    Key := #0;
end;

procedure TfrmCadMetasGrupo.pAbreConsulta;
Begin
  fAbreConsulta;
End;

procedure TfrmCadMetasGrupo.FormShow(Sender: TObject);
begin
  inherited;

  blnTemPesquisa      := False;
  blnSempreRelerBanco := False;
  blnTemSelecao       := False;
  
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;                

  If cdsConsulta.Active Then
    cdsConsulta.CancelUpdates;

  fAbreConsulta;

  btnMudaOrdem.Visible := False;
  btnPesquisar.Visible := False;
  btnSair.Visible      := False;
end;

procedure TfrmCadMetasGrupo.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, False) Then
      pSetFocus(rdgDefineLinhaGrupo);
  End;
end;

Procedure TfrmCadMetasGrupo.pLimpaDados(blnSetFocus: Boolean = True);
Begin

  If blnSetFocus Then
  Begin
    blnMudarFoco := False;
    pSetFocus(mskLinhaGrupo);
  End;  

  mskLinhaGrupo.Clear;
  edtDesGrupo.Clear;
  edtPerGru.Text := FormatFloat('#,##0.00', 0);
  edtMarGru.Text := FormatFloat('#,##0.00', 0);
End;

procedure TfrmCadMetasGrupo.rdgDefineLinhaGrupoClick(Sender: TObject);
begin
  inherited;
  lblMarGru.Visible := rdgDefineLinhaGrupo.ItemIndex = 0;
  edtMarGru.Visible := rdgDefineLinhaGrupo.ItemIndex = 0;
end;

function TfrmCadMetasGrupo.fRetTotPerGru: Double;
Begin
  If TAggregateField(cdsConsulta.FieldByName('TOT_PERGRU')).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(cdsConsulta.FieldByName('TOT_PERGRU')).Value;
End;

function TfrmCadMetasGrupo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesGru,
    strCodGru: String;
    blnBloqueia: Boolean;
begin
  Result      := True;
  blnBloqueia := False;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskLinhaGrupo) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskLinhaGrupo.Text)) Then
      Begin
        fMensagem('', 'Informe o Grupo de Produtos para a meta!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        strCodGru := fTiraCaracEspeciais(mskLinhaGrupo.Text);
        strDesGru := fRetNomeLinhaGrupo(strCodGru);

        If fEmptyStr(strDesGru) Then
        Begin
          fMensagem('', 'Grupo de Produtos não encontrado!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtDesGrupo.Text := strDesGru;

          With cdsConsulta Do
          Begin
            {**********************************************************}
            {* LOCALIZA REGISTROS ADICIONADOS COM A MESMA LINHA       *}
            {* QUE FOI DIGITADA NO mskLinhaGrupo E TESTA              *}
            {******************************************************MM**}
            If (RecordCount > 0) Then
            Begin
              First;
              While Not EOF DO
              Begin
                If (Copy(FieldByName('MET_CODGRU').AsString,1,3) = Copy(strCodGru,1,3)) Then
                Begin
                  if ((Copy(strCodGru,4,3) <> '000') And (Copy(FieldByName('MET_CODGRU').AsString,4,3) = '000')) Or
                     ((Copy(strCodGru,4,3)  = '000') And (Copy(FieldByName('MET_CODGRU').AsString,4,3)<> '000')) Then
                  Begin
                    blnBloqueia := True;
                  End;
                End;

                Next;
              End;
            End;

            {**********************************************************}
            {* BLOQUEIA A INSERÇÃO DE UM GRUPO CASO SUA LINHA         *}
            {* JÁ TENHA SIDO INSERIDA OU BLOQUEIA A INSERÇÃO DE       *}
            {* UMA LINHA CASO UM GRUPO DA MESMA JÁ TENHA SIDO INSERIDO*}
            {******************************************************MM**}
            If (blnBloqueia) Then
            Begin
              If (Copy(strCodGru,4,3) <> '000') Then
              Begin
                fMensagem('', 'A Linha deste Grupo já foi inserida!', ['&Ok']);
                Result := False;
                Exit;
              End
              Else If (Copy(strCodGru,4,3) = '000') Then
              Begin
                fMensagem('', 'Um Grupo desta Linha já foi inserido!', ['&Ok']);
                Result := False;
                Exit;
              End;
            End;
          End;

          If blnBuscaPorChave Then
          Begin
            strCodGru := fTiraCaracEspeciais(mskLinhaGrupo.Text);

            If cdsConsulta.Locate('MET_CODGRU', strCodGru, []) Then
              pCarregaRegistro
            Else
            Begin
              edtPerGru.Text :=  FormatFloat('#,##0.00', 100 - fRetTotPerGru);
              edtMarGru.Text :=  FormatFloat('#,##0.00', 0);
            End;
          End;
        End;
      End;

    End

    Else If (Sender = edtPerGru) Then
    Begin
      If (fStrToFloat(edtPerGru.Text) <= 0) Or
         (fStrToFloat(edtPerGru.Text) > 100) Then
      Begin
        fMensagem('', 'O percentual deve ser maior que zero e menor ou igual a 100!', ['&Ok']);
        Result := False;
      End

      Else If (Not edtMarGru.Visible) And fValidaCampos(mskLinhaGrupo, False) Then
      Begin
        Result := fInsereRegistro;
      End;
    End

    Else If (Sender = edtMarGru) And edtMarGru.Visible Then
    Begin
      If (fStrToFloat(edtMarGru.Text) < 0) Or
         (fStrToFloat(edtMarGru.Text) > 100) Then
      Begin
        fMensagem('', 'A margem deve ser entre 0 e 100!', ['&Ok']);
        Result := False;
      End

      Else If fValidaCampos(mskLinhaGrupo, False) Then
      Begin
        Result := fInsereRegistro;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender)

  Else If blnMudarFoco Then
  Begin
    blnMudarFoco := False;
    SelectNext(Sender, True, True);
  End;
end;

procedure TfrmCadMetasGrupo.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.Active And (Not cdsConsulta.IsEmpty) Then
  Begin
    If fPergunta('Confirma a exclusão da meta para o grupo?') Then
      cdsConsulta.Delete;
  End;
end;

procedure TfrmCadMetasGrupo.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadGru.Open;
end;

procedure TfrmCadMetasGrupo.pCarregaRegistro;
Begin
  With cdsConsulta Do
  Begin
    mskLinhaGrupo.Text := FieldByName('MET_CODGRU').AsString;
    edtDesGrupo.Text   := FieldByName('GRU_DESGRU').AsString;
    edtPerGru.Text     := FormatFloat('#,##0.00', FieldByName('MET_PERGRU').AsFloat);
    edtMarGru.Text     := FormatFloat('#,##0.00', FieldByName('MET_MARGRU').AsFloat);
    rdgDefineLinhaGrupo.ItemIndex := iif( FieldByName('MET_DEFTIP').AsString = 'F', 0, 1);
  End;
End;

function TfrmCadMetasGrupo.fInsereRegistro: Boolean;
  Var
    strCodGru: String;
begin
  Result := True;
  strCodGru := fTiraCaracEspeciais(mskLinhaGrupo.Text);

  cdsConsulta.Tag := 1;

  With cdsConsulta Do
  If Locate('MET_CODGRU', strCodGru, []) Then
  Begin
    If RoundTo(fRetTotPerGru - FieldByName('MET_PERGRU').AsFloat + fStrToFloat(edtPerGru.Text), -2) > 100 Then
    Begin
      fMensagem('', 'A Soma dos grupos dever igual a 100%!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      Edit;
      FieldByName('MET_PERGRU').AsFloat  := fStrToFloat(edtPerGru.Text);
      FieldByName('MET_MARGRU').AsFloat  := IIF(edtMarGru.Visible, fStrToFloat(edtMarGru.Text), 0);
      FieldByName('MET_DEFTIP').AsString := IIF(rdgDefineLinhaGrupo.ItemIndex = 0, 'F', 'M');
      Post;
    End;
  End
  Else
  Begin
    If RoundTo(fRetTotPerGru + fStrToFloat(edtPerGru.Text), -2) > 100 Then
    Begin
      fMensagem('', 'A Soma dos grupos dever ser igual a 100!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      Insert;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DETMET', VS_strCodEmp);
      FieldByName('MET_MESANO').AsString := cdsCadMet.FieldByName('MET_MESANO').AsString;
      FieldByName('MET_CODVEN').AsString := cdsCadMet.FieldByName('MET_CODVEN').AsString;
      FieldByName('MET_CODEMP').AsString := VS_strCodEmp;
      FieldByName('MET_CODGRU').AsString := strCodGru;
      FieldByName('MET_PERGRU').AsFloat  := fStrToFloat(edtPerGru.Text);
      FieldByName('MET_MARGRU').AsFloat  := IIF(edtMarGru.Visible, fStrToFloat(edtMarGru.Text), 0);
      FieldByName('MET_DEFTIP').AsString := IIF(rdgDefineLinhaGrupo.ItemIndex = 0, 'F', 'M');
      Post;
    End;
  End;

  cdsConsulta.Tag := 0;

  If Result Then
    pLimpaDados;
end;

procedure TfrmCadMetasGrupo.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    frmCadMetasValor : TfrmCadMetasValor;
begin
  inherited;
  If Not Assigned(frmCadMetasValor) then
    pCriarFormularios(TfrmCadMetasValor, frmCadMetasValor);
  If key = VK_RETURN Then
  Begin
    pSetFocus(mskLinhaGrupo);
    pCarregaRegistro;
  End
  Else If (Shift = [ssAlt]) then
  Begin
    If (Key = Ord('B')) And Assigned(frmCadMetasValor) Then
      pSetFocus(frmCadMetasValor.dbgConsulta);
  End;

end;

procedure TfrmCadMetasGrupo.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  edtTotPer.Text := FormatFloat('#,##0.00', fRetTotPerGru);
end;

procedure TfrmCadMetasGrupo.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;

  edtTotPer.Text := FormatFloat('#,##0.00', fRetTotPerGru);

end;

procedure TfrmCadMetasGrupo.cdsConsultaBeforeDelete(DataSet: TDataSet);
begin
  inherited;

  edtTotPer.Text := FormatFloat('#,##0.00', fRetTotPerGru);

end;

procedure TfrmCadMetasGrupo.cdsConsultaCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('DescrDefLinGru').AsString := iif(DataSet.FieldByName('MET_DEFTIP').AsString = 'F', 'Valor Faturamento', 'Margem');
end;

function TfrmCadMetasGrupo.fValidaTotalGrupo: Boolean;
Begin
  Result := True;

  If (RoundTo(fRetTotPerGru, -2) <> 100) And (RoundTo(fRetTotPerGru, -2) <> 0) Then
  Begin
    fMensagem('', 'A Soma dos grupos deve ser igual a 100%!', ['&Ok']);
    Exit(False);
  End;

  If fExisteMargemPreenchida And
     cdsConsulta.Locate('MET_DEFTIP;MET_MARGRU', VarArrayOf(['F',0]), []) Then
  Begin
    fMensagem('', 'A Margem deve ser preenchida para todas as Linhas/Grupos definidas como "Valor Faturamento"!', ['&Ok']);
    Exit(False);
  End;
End;

end.
