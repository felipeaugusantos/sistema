unit untCnfNotaFiscal;

interface

uses
  Windows, Classes, Controls, Forms, StdCtrls, untPaiSimples, Menus, ComCtrls,
  Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, MemoFocus, DBEditFocus, DB, AppEvnts,
  BitBtnLockedIncrem, Mask, DBCtrls;

type
  TCnfNot = Record
    strTipNot: String;
    strIdenti: String;
    intLinImp: Integer;
    intLiTopo: Integer;
    intColImp: Integer;
    intMargem: Integer;
    strDesDob: String;
    strChrAnt: String;
    strDesCam: String;
    strChrDep: String;
  end;

type
  TfrmCnfNotaFiscal = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    lblTitulo: TLabel;
    pnlDados: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbeIdenti: TDBEditFocus;
    dbeLinImp: TDBEditFocus;
    dbeColImp: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbeChrAnt: TDBEditFocus;
    dbeChrDep: TDBEditFocus;
    memDesCam: TMemoFocus;
    pnlBotoesCnf: TPanel;
    dbgConfigs: TDBGridCitel;
    popConfig: TPopupMenu;
    mnuIncluir: TMenuItem;
    N2: TMenuItem;
    mnuEditaReg: TMenuItem;
    N1: TMenuItem;
    mnuDeletaReg: TMenuItem;
    Label1: TLabel;
    dbeDesDob: TDBEditFocus;
    DBELITOPO: TDBEditFocus;
    Label9: TLabel;
    dtsTabela: TDataSource;
    btnIrGrid: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnNovaConf: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnNovaConfClick(Sender: TObject);
    procedure btnIrGridClick(Sender: TObject);
    procedure mnuEditaRegClick(Sender: TObject);
    procedure mnuDeletaRegClick(Sender: TObject);
    procedure popConfigPopup(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgConfigsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure pHabilitaEdits(blnHabilita: Boolean);
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pAfterOpen(DataSet: TDataSet);

    procedure pIncluirRegistro;
    procedure pDeletaRegistro;
    procedure pEditaRegistro;
    { Private declarations }
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strTipNot: String;
  end;

var
  frmCnfNotaFiscal: TfrmCnfNotaFiscal;

implementation

uses SysUtils, untFuncoesSimples, untConstantes;

{$R *.dfm}

{ TfrmPaiSimples1 }

function TfrmCnfNotaFiscal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeIdenti) Or
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

    Else If (Sender = dbeDesDob) Then
    Begin

      If (Not fEmptyStr(dbeDesDob.Text)) Then
      Begin

        If (Pos(dbeDesDob.Text, 'S_N_') <= 0) Then
        Begin
          Result := False;
        End;

      End;

    End

    Else If (Sender = memDesCam) Then
    Begin
{      If fEmptyStr(memDesCam.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&O k']);
        Result := False;
      End;}
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCnfNotaFiscal.FormCreate(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CNF_NF ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CNF_TIPNOT = :TIPNOT AND ';
  strSQL := strSQL + '  CNF_CODEMP = :CODEMP ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_IDENTI, ';
  strSQL := strSQL + '  CNF_LINIMP, ';
  strSQL := strSQL + '  CNF_COLIMP, ';
  strSQL := strSQL + '  CNF_CODSEQ ';

  qryTabela := fCriarQuery(strSQL, Self);
  qryTabela.AfterScroll := pAtualizaDados;
  qryTabela.AfterOpen := pAfterOpen;
  dtsTabela.DataSet := qryTabela;
end;

procedure TfrmCnfNotaFiscal.pHabilitaEdits(blnHabilita: Boolean);
begin
  pnlDados.Enabled    := blnHabilita;
  dbgConfigs.Enabled  := Not blnHabilita;
  btnNovaConf.Enabled := Not blnHabilita;
  btnConfirma.Enabled := blnHabilita;
end;

procedure TfrmCnfNotaFiscal.FormShow(Sender: TObject);
begin
  qryTabela.ParamByName('TIPNOT').AsString := strTipNot;
  qryTabela.ParamByName('CODEMP').AsString := VS_strCodEmp;
  fAbrirTabela(qryTabela);
  pHabilitaEdits(False);
end;

procedure TfrmCnfNotaFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryTabela);
end;

procedure TfrmCnfNotaFiscal.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    FieldByName('CNF_CODSEQ').DisplayLabel := 'Sequencial';
    FieldByName('CNF_MARGEM').DisplayLabel := 'Margem';
    FieldByName('CNF_TIPNOT').DisplayLabel := 'Tipo de Nota';
    FieldByName('CNF_IDENTI').DisplayLabel := 'ID';
    FieldByName('CNF_DESDOB').DisplayLabel := 'Desdobro';
    FieldByName('CNF_LINIMP').DisplayLabel := 'Linha';
    FieldByName('CNF_COLIMP').DisplayLabel := 'Coluna';
    FieldByName('CNF_CHRANT').DisplayLabel := 'Chr anterior';
    FieldByName('CNF_CHRDEP').DisplayLabel := 'Chr Posterior';
  End;
end;

procedure TfrmCnfNotaFiscal.pAtualizaDados(DataSet: TDataSet);
begin
  memDesCam.Texto := qryTabela.FieldByName('CNF_DESCAM').AsString;
end;

procedure TfrmCnfNotaFiscal.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmCnfNotaFiscal.btnNovaConfClick(Sender: TObject);
begin
  inherited;
  pHabilitaEdits(True);
  pSetFocus(dbeIdenti);
  qryTabela.Insert;
  qryTabela.FieldByName('CNF_TIPNOT').AsString := strTipNot;
  qryTabela.FieldByName('CNF_CODEMP').AsString := VS_strCodEmp;
end;

procedure TfrmCnfNotaFiscal.btnIrGridClick(Sender: TObject);
begin
  inherited;
  qryTabela.Cancel;

  pAtualizaDados(Nil);
  pHabilitaEdits(False);
  pSetFocus(dbgConfigs);
end;

procedure TfrmCnfNotaFiscal.pEscapePressed;
begin
  inherited;
  btnIrGrid.Click;
end;

procedure TfrmCnfNotaFiscal.pDeletaRegistro;
begin
  If (Not qryTabela.IsEmpty) And
     (fMensagem('', 'Confirma exclusão do registro?', ['&Não', '&Sim']) = 2) Then
  Begin
    qryTabela.Delete;
  End;
end;

procedure TfrmCnfNotaFiscal.pEditaRegistro;
begin
  qryTabela.Edit;
  pHabilitaEdits(True);

  If dbgConfigs.SelectedField.FieldName = 'CNF_IDENTI' Then
    pSetFocus(dbeIdenti)
  Else If dbgConfigs.SelectedField.FieldName = 'CNF_LITOPO' Then
    pSetFocus(DBELITOPO)
  Else If dbgConfigs.SelectedField.FieldName = 'CNF_MARGEM' Then
    pSetFocus(dbeMargem)
  Else If dbgConfigs.SelectedField.FieldName = 'CNF_LINIMP' Then
    pSetFocus(dbeLinImp)
  Else If dbgConfigs.SelectedField.FieldName = 'CNF_COLIMP' Then
    pSetFocus(dbeColImp)
  Else If dbgConfigs.SelectedField.FieldName = 'CNF_CHRANT' Then
    pSetFocus(dbeChrAnt)
  Else If dbgConfigs.SelectedField.FieldName = 'CNF_CHRDEP' Then
    pSetFocus(dbeChrDep)
  Else If dbgConfigs.SelectedField.FieldName = 'CNF_DESDOB' Then
    pSetFocus(dbeDesDob);
end;

procedure TfrmCnfNotaFiscal.pIncluirRegistro;
  Var
    blnCopiaDescri: Boolean;
    intRetMsg: Integer;
    tmpCnfNot: TCnfNot;
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
      tmpCnfNot.strTipNot := FieldByName('CNF_TIPNOT').AsString;
      tmpCnfNot.strIdenti := FieldByName('CNF_IDENTI').AsString;
      tmpCnfNot.intLinImp := FieldByName('CNF_LINIMP').AsInteger;
      tmpCnfNot.intLiTopo := FieldByName('CNF_LITOPO').AsInteger;
      tmpCnfNot.intColImp := FieldByName('CNF_COLIMP').AsInteger;
      tmpCnfNot.intMargem := FieldByName('CNF_MARGEM').AsInteger;
      tmpCnfNot.strChrAnt := FieldByName('CNF_CHRANT').AsString;
      tmpCnfNot.strDesDob := FieldByName('CNF_DESDOB').AsString;


      If blnCopiaDescri Then
        tmpCnfNot.strDesCam := FieldByName('CNF_DESCAM').AsString
      Else
        tmpCnfNot.strDesCam := '';

      tmpCnfNot.strChrDep := FieldByName('CNF_CHRDEP').AsString;

      Insert;
      FieldByName('CNF_TIPNOT').AsString  := tmpCnfNot.strTipNot;
      FieldByName('CNF_IDENTI').AsString  := tmpCnfNot.strIdenti;
      FieldByName('CNF_LINIMP').AsInteger := tmpCnfNot.intLinImp;
      FieldByName('CNF_LITOPO').AsInteger := tmpCnfNot.intLiTopo;
      FieldByName('CNF_COLIMP').AsInteger := tmpCnfNot.intColImp;
      FieldByName('CNF_MARGEM').AsInteger := tmpCnfNot.intMargem;
      FieldByName('CNF_CHRANT').AsString  := tmpCnfNot.strChrAnt;
      FieldByName('CNF_CHRDEP').AsString  := tmpCnfNot.strChrDep;
      FieldByName('CNF_DESDOB').AsString  := tmpCnfNot.strDesDob;
      FieldByName('CNF_DESCAM').AsString  := tmpCnfNot.strDesCam;
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

procedure TfrmCnfNotaFiscal.mnuEditaRegClick(Sender: TObject);
begin
  inherited;
  pEditaRegistro;
end;

procedure TfrmCnfNotaFiscal.mnuDeletaRegClick(Sender: TObject);
begin
  inherited;
  pDeletaRegistro;
end;

procedure TfrmCnfNotaFiscal.popConfigPopup(Sender: TObject);
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

procedure TfrmCnfNotaFiscal.btnConfirmaClick(Sender: TObject);
  Var
    intRecNo: Integer;
begin
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
        If (qryTabela.FindField('AUTOINCREM') <> Nil) Then
          qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CNFBOL', VS_strCodEmp);

      qryTabela.Post;
      pHabilitaEdits(False);
      
//      fFecharTabela(qryTabela);
//      fAbrirTabela(qryTabela);

      pSetFocus(dbgConfigs);
      qryTabela.RecNo := intRecNo;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[ Gravação da Configuração de Boletos ]');
    End;
  End;
end;

procedure TfrmCnfNotaFiscal.dbgConfigsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
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

end.


