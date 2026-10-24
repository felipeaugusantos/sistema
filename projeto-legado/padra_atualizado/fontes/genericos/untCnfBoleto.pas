unit untCnfBoleto;

interface

uses

  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, ComCtrls, Uni,
  Buttons, ExtCtrls, EditFocus, MemoFocus, Mask, DBCtrls, DBEditFocus,
  DB, StrUtils, Menus, AppEvnts, BitBtnLockedIncrem;


type
  TCnfBol = Record
    strCodBco: String;
    strIdenti: String;
    intLinImp: Integer;
    intColImp: Integer;
    intMargem: Integer;
    strChrAnt: String;
    strDesCam: String;
    strChrDep: String;
  end;

type
  TfrmCnfBoleto = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlDados: TPanel;
    pnlBotoesCnf: TPanel;
    dbgConfigs: TDBGridCitel;
    lblTitulo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbeCodBco: TDBEditFocus;
    dbeIdenti: TDBEditFocus;
    dbeLinImp: TDBEditFocus;
    dbeColImp: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbeChrAnt: TDBEditFocus;
    dbeChrDep: TDBEditFocus;
    memDesCam: TMemoFocus;
    popConfig: TPopupMenu;
    mnuEditaReg: TMenuItem;
    N1: TMenuItem;
    mnuDeletaReg: TMenuItem;
    N2: TMenuItem;
    mnuIncluir: TMenuItem;
    edtNomBan: TEditFocus;
    dtsCnfGen: TDataSource;
    btnIrGrid: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnNovaConf: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure dbgConfigsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure memDesCamKeyPress(Sender: TObject; var Key: Char);
    procedure btnNovaConfClick(Sender: TObject);
    procedure btnIrGridClick(Sender: TObject);
    procedure mnuEditaRegClick(Sender: TObject);
    procedure mnuDeletaRegClick(Sender: TObject);
    procedure popConfigPopup(Sender: TObject);
    procedure dbeCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure mnuIncluirClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    qryConBco: TUniQuery;

    procedure pSubstituirValores;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCarregaBanco;
    procedure pHabilitaEdits(blnHabilita: Boolean);

    procedure pIncluirRegistro;
    procedure pDeletaRegistro;
    procedure pEditaRegistro;

    {*****************************************}
    {* PROCEDURES ATRIBUIDAS AOS EVENTOS DA  *}
    {* qryTemporaria                         *}
    {**************************************MV*}
    procedure pAtualizaDados(DataSet: TDataSet);
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnCnfBol: Boolean;
  end;

var
  frmCnfBoleto: TfrmCnfBoleto;

implementation


uses untFuncoesSimples, untPesqAux, untConstantes, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCnfBoleto }

function TfrmCnfBoleto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodBco) Then
    Begin
      If fEmptyStr(dbeCodBco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Banco deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaBanco;
        If qryConBco.FieldByName('BCO_CODBCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Banco não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeIdenti) Or
            (Sender = dbeLinImp) Or
            (Sender = dbeColImp) Or
            (Sender = dbeMargem) Then
    Begin
      If fEmptyStr((Sender As TDBEditFocus).Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel +
                              ' deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = memDesCam) Then
    Begin
      If fEmptyStr(memDesCam.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCnfBoleto.pCarregaBanco;
begin
  pPesquisaCadBco(qryConBco, qryConBco, dbeCodBco.Text);
  With qryConBco Do
  Begin
    edtNomBan.Text := FieldByName('BCO_NOMBCO').AsString;
  End;
end;

procedure TfrmCnfBoleto.FormCreate(Sender: TObject);
begin
  inherited;
  blnCnfBol := True;
  qryConBco := fCriaQuery(Self);
end;

procedure TfrmCnfBoleto.pHabilitaEdits(blnHabilita: Boolean);
begin
  pnlDados.Enabled    := blnHabilita;
  dbgConfigs.Enabled  := Not blnHabilita;
  btnNovaConf.Enabled := Not blnHabilita;
  btnConfirma.Enabled := blnHabilita;
end;

procedure TfrmCnfBoleto.dbgConfigsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Shift = [ssShift]) And (Key = VK_RWIN) Then
  Begin
    pSubstituirValores;
  End;

  If (Key = VK_Return) Then
  Begin
    pEditaRegistro;
  End
  Else If (Key = VK_Escape) Then
  Begin
    Close;
  End
  Else If (Key = VK_Delete) Then
  Begin
    pDeletaRegistro;
  End
  Else If (Key = VK_Insert) Then
  Begin
    pIncluirRegistro;
  End;
end;

procedure TfrmCnfBoleto.FormShow(Sender: TObject);
  var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + IIF(blnCnfBol, ' CNFBOL ', ' CNFCHQ ');
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CNF_CODEMP = :CODEMP ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_CODBCO, CNF_IDENTI, CNF_LINIMP, CNF_COLIMP ';

  qryTabela := fCriarQuery(strSQL, Self);
  qryTabela.AfterScroll := pAtualizaDados;
  qryTabela.AfterOpen := pAfterOpen;
  qryTabela.ParamByName('CODEMP').Value := VS_strCodEmp;
  qryTabela.Open;
  dtsCnfGen.DataSet := qryTabela;

  pHabilitaEdits(False);

  If Not blnCnfBol Then
  Begin
    Self.Caption := 'Configuração de Cheque';
    lblTitulo.Caption := 'CONFIGURAÇÃO DE CHEQUE';
  End;
end;

procedure TfrmCnfBoleto.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    FieldByName('CNF_CODBCO').DisplayLabel := 'Banco';
    FieldByName('CNF_IDENTI').DisplayLabel := 'ID';
    FieldByName('CNF_LINIMP').DisplayLabel := 'Linha';
    FieldByName('CNF_COLIMP').DisplayLabel := 'Coluna';
    FieldByName('CNF_MARGEM').DisplayLabel := 'Margem';
    FieldByName('CNF_CHRANT').DisplayLabel := 'Chr Antes';
    FieldByName('CNF_CHRDEP').DisplayLabel := 'Chr Depois';
    FieldByName('CNF_DESCAM').DisplayLabel := 'Descrição';
  End;
end;

procedure TfrmCnfBoleto.pAtualizaDados(DataSet: TDataSet);
begin
  memDesCam.Texto := qryTabela.FieldByName('CNF_DESCAM').AsString;
  pCarregaBanco;
end;

procedure TfrmCnfBoleto.memDesCamKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = #13 Then
  Begin
    If memDesCam.Lines.Count = MAX_LINHAS_MEMO Then
    Begin
      Key := #0;
      SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  Begin
    Key := AnsiUpperCase(Key)[1];
  End;
end;

procedure TfrmCnfBoleto.btnNovaConfClick(Sender: TObject);
begin
  pHabilitaEdits(True);
  pSetFocus(dbeCodBco);
  qryTabela.Insert;
end;

procedure TfrmCnfBoleto.btnIrGridClick(Sender: TObject);
begin
  qryTabela.Cancel;

  pAtualizaDados(Nil);
  pHabilitaEdits(False);
  pSetFocus(dbgConfigs);
end;

procedure TfrmCnfBoleto.pEscapePressed;
begin
  btnIrGrid.Click;
end;

procedure TfrmCnfBoleto.pDeletaRegistro;
begin
  If (Not qryTabela.IsEmpty) And
     (fMensagem('', 'Confirma exclusão do registro?', ['&Não', '&Sim']) = 2) Then
  Begin
    qryTabela.Delete;
  End;
end;

procedure TfrmCnfBoleto.pEditaRegistro;
begin
  qryTabela.Edit;
  pHabilitaEdits(True);
  pSetFocus(dbeCodBco);
end;

procedure TfrmCnfBoleto.mnuEditaRegClick(Sender: TObject);
begin
  inherited;
  pEditaRegistro;
end;

procedure TfrmCnfBoleto.mnuDeletaRegClick(Sender: TObject);
begin
  inherited;
  pDeletaRegistro;
end;

procedure TfrmCnfBoleto.popConfigPopup(Sender: TObject);
  Var
    intContador: Integer;
    blnHabilita: Boolean;
begin
  inherited;
  blnHabilita := Not qryTabela.IsEmpty;

  For intContador := 0 To popConfig.Items.Count -1 Do
  Begin
    popConfig.Items[intContador].Enabled := blnHabilita;
  End;
end;

procedure TfrmCnfBoleto.dbeCodBcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, dbeCodBco, edtNomBan, qryTabela, Key, arrBancos) Then
  Begin
    if fValidaCampos(dbeCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;
end;

{*****************************************}
{* FAZ UMA CÓPIA DO REGISTRO ATUAL       *}
{**************************************MV*}
procedure TfrmCnfBoleto.pIncluirRegistro;
  Var
    blnCopiaDescri: Boolean;
    intRetMsg: Integer;
    tmpCnfBco: TCnfBol;
begin
  blnCopiaDescri := False;
  {*****************************************}
  {* CASO A TABELA ESTIVER VAZIA, SAI      *}
  {**************************************MV*}
  If qryTabela.IsEmpty Then
  Begin
    Exit;
  End;

  intRetMsg := fMensagem('', 'Copia Descrição?', ['&Sim', '&Não', '&Cancelar']);

  Case intRetMsg Of
    1: blnCopiaDescri := True;
    2: blnCopiaDescri := False;
    3: Exit;
  End;

  Try

    With qryTabela Do
    Begin

      tmpCnfBco.strCodBco := FieldByName('CNF_CODBCO').AsString;
      tmpCnfBco.strIdenti := FieldByName('CNF_IDENTI').AsString;
      tmpCnfBco.intLinImp := FieldByName('CNF_LINIMP').AsInteger;
      tmpCnfBco.intColImp := FieldByName('CNF_COLIMP').AsInteger;
      tmpCnfBco.intMargem := FieldByName('CNF_MARGEM').AsInteger;
      tmpCnfBco.strChrAnt := FieldByName('CNF_CHRANT').AsString;

      If blnCopiaDescri Then
        tmpCnfBco.strDesCam := FieldByName('CNF_DESCAM').AsString
      Else
        tmpCnfBco.strDesCam := '';

      tmpCnfBco.strChrDep := FieldByName('CNF_CHRDEP').AsString;

      Insert;
      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem(IIF(blnCnfBol, 'CNFBOL', 'CNFCHQ'), VS_strCodEmp);
      FieldByName('CNF_CODBCO').AsString  := tmpCnfBco.strCodBco;
      FieldByName('CNF_IDENTI').AsString  := tmpCnfBco.strIdenti;
      FieldByName('CNF_LINIMP').AsInteger := tmpCnfBco.intLinImp;
      FieldByName('CNF_COLIMP').AsInteger := tmpCnfBco.intColImp;
      FieldByName('CNF_MARGEM').AsInteger := tmpCnfBco.intMargem;
      FieldByName('CNF_CHRANT').AsString  := tmpCnfBco.strChrAnt;
      FieldByName('CNF_CHRDEP').AsString  := tmpCnfBco.strChrDep;
      FieldByName('CNF_DESCAM').AsString  := tmpCnfBco.strDesCam;
      FieldByName('CNF_CODEMP').AsString  := VS_strCodEmp;
      Post;
      pAtualizaDados(Nil);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pIncluirRegistro]');

      qryTabela.Cancel;
    End;
  End;
end;

procedure TfrmCnfBoleto.mnuIncluirClick(Sender: TObject);
begin
  inherited;
  pIncluirRegistro;
end;

procedure TfrmCnfBoleto.pSubstituirValores;
  Var
    strSubsDe, strSubsPara: String;
begin
  strSubsDe := InputBox('Substituição', 'Digite o texto a ser subtituido: ', '');

  If Not fEmptyStr(strSubsDe) Then
  Begin
    strSubsPara := InputBox('Substituição', 'Digite o novo texto: ', '');
    If Not fEmptyStr(strSubsPara) Then
    Begin

      With qryTabela Do
      Begin

        First;
        While Not Eof Do
        Begin
          Edit;
          FieldByName('CNF_CHRANT').AsString := AnsiReplaceStr(FieldByName('CNF_CHRANT').AsString, strSubsDe, strSubsPara);
          FieldByName('CNF_DESCAM').AsString := AnsiReplaceStr(FieldByName('CNF_DESCAM').AsString, strSubsDe, strSubsPara);
          FieldByName('CNF_CHRDEP').AsString := AnsiReplaceStr(FieldByName('CNF_CHRDEP').AsString, strSubsDe, strSubsPara);
          Post;
          Next;
        End;

      End;

    End;
  End;
end;

procedure TfrmCnfBoleto.btnConfirmaClick(Sender: TObject);
  Var
    intRecNo : Integer;
    strSQL   : String;
    qryGenBol: TUniQuery;

begin
  Try

    qryGenBol := fCriaQuery(Self);

    Try

      intRecNo := qryTabela.RecNo;

      If Not (qryTabela.State = dsBrowse) Then
      Begin

        If Not fVerificaCampos Then
          Exit;

        qryTabela.FieldByName('CNF_DESCAM').AsString := memDesCam.Text;

        {*****************************************}
        {* GRAVA O CAMPO AUTO INCREMENTO         *}
        {**************************************MV*}
        If qryTabela.State = dsInsert Then
        Begin
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  IFNULL(MAX(AUTOINCREM), 0) + 1 AS VALOR ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + IIF(blnCnfBol, ' CNFBOL ', ' CNFCHQ ');

          With qryGenBol Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            Open;
            qryTabela.FieldByName('AUTOINCREM').AsString := FieldByName('VALOR').AsString;
            qryTabela.FieldByName('CNF_CODEMP').AsString     := VS_strCodEmp;
            Close;
          End;

        End;

        qryTabela.Post;
        pHabilitaEdits(False);

        fFecharTabela(qryTabela);
        fAbrirTabela(qryTabela);

        pSetFocus(dbgConfigs);
        qryTabela.RecNo := intRecNo;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[ Gravação da Configuração de Boletos ]');
      End;

    End;

  Finally
    FreeAndNil(qryGenBol);
  End;
end;

end.
