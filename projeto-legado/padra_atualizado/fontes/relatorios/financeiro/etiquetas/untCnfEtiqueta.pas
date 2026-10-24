unit untCnfEtiqueta;

interface

uses
  Windows, Classes, Controls, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, MemoFocus,
  Uni, DBEditFocus, ComCtrls, Buttons, ExtCtrls, DB, Menus, AppEvnts,
  BitBtnLockedIncrem, Mask, DBCtrls, untTypesSistema, frxClass,
  frxExportCSVTestabilidade;

type
  TCnfEti = Record
    strTipEti: String;
    strIdenti: String;
    intLinImp: Integer;
    intQtdCol: Integer;
    intMargem: Integer;
    strChrAnt: String;
    strDesCam: String;
    strChrDep: String;
    intCol001: Integer;
    intCol002: Integer;
    intCol003: Integer;
    intCol004: Integer;
    intCol005: Integer;

  end;

type
  TfrmCnfEtiqueta = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    lblTitulo: TLabel;
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbeTipEti: TDBEditFocus;
    dbeIdenti: TDBEditFocus;
    dbeLinImp: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbeChrAnt: TDBEditFocus;
    dbeChrDep: TDBEditFocus;
    memDesCam: TMemoFocus;
    pnlBotoesCnf: TPanel;
    dbgConfigs: TDBGridCitel;
    Label4: TLabel;
    dbeCol001: TDBEditFocus;
    Label9: TLabel;
    dbeCol002: TDBEditFocus;
    Label10: TLabel;
    dbeCol003: TDBEditFocus;
    Label11: TLabel;
    dbeCol004: TDBEditFocus;
    Label12: TLabel;
    dbeCol005: TDBEditFocus;
    Label13: TLabel;
    dbeQtdCol: TDBEditFocus;
    popConfig: TPopupMenu;
    mnuIncluir: TMenuItem;
    N2: TMenuItem;
    mnuEditaReg: TMenuItem;                      
    N1: TMenuItem;
    mnuDeletaReg: TMenuItem;
    Label14: TLabel;
    dbeLinTop: TDBEditFocus;
    dtsTabela: TDataSource;
    btnIrGrid: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnNovaConf: TBitBtnLocked;
    btnCamDisp: TBitBtnLocked;
    procedure btnNovaConfClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgConfigsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuIncluirClick(Sender: TObject);
    procedure mnuEditaRegClick(Sender: TObject);
    procedure mnuDeletaRegClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIrGridClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCamDispClick(Sender: TObject);
  private
    { Private declarations }
    procedure pIncluirRegistro;
    procedure pDeletaRegistro;
    procedure pEditaRegistro;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pHabilitaEdits(blnHabilita: Boolean);
    procedure pSubstituirValores;

    {*****************************************}
    {* PROCEDURES ATRIBUIDAS AOS EVENTOS DA  *}
    {* qryTemporaria                         *}
    {**************************************MV*}
    procedure pAtualizaDados(DataSet: TDataSet);

    procedure pMostraCamposDiponiveis;
    procedure pMostraCamposDiponiveisItensCPF;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    tipTipEti: TTiposEtiqueta;
    { Public declarations }
  end;

var
  frmCnfEtiqueta: TfrmCnfEtiqueta;

implementation

uses SysUtils, Forms, Dialogs, StrUtils,
  untFuncoesRel, untFuncoesSimples;

{$R *.dfm}

{ TfrmCnfEtiquetas }

function TfrmCnfEtiqueta.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeTipEti) Then
    Begin

    End

    Else If (Sender = dbeIdenti) Or (Sender = dbeLinImp) Or
            (Sender = dbeQtdCol) Or (Sender = dbeCol001) Or
            (Sender = dbeCol002) Or (Sender = dbeCol003) Or
            (Sender = dbeCol004) Or (Sender = dbeCol005) Or
            (Sender = dbeMargem)                         Then
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

procedure TfrmCnfEtiqueta.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    FieldByName('CNF_TIPETI').DisplayLabel := 'Tipo';
    FieldByName('CNF_IDENTI').DisplayLabel := 'Identi';
    FieldByName('CNF_LINIMP').DisplayLabel := 'Linha';
    FieldByName('CNF_COL001').DisplayLabel := 'Coluna 001';
    FieldByName('CNF_COL002').DisplayLabel := 'Coluna 002';
    FieldByName('CNF_COL003').DisplayLabel := 'Coluna 003';
    FieldByName('CNF_COL004').DisplayLabel := 'Coluna 004';
    FieldByName('CNF_COL005').DisplayLabel := 'Coluna 005';
    FieldByName('CNF_MARGEM').DisplayLabel := 'Margem';
    FieldByName('CNF_QTDCOL').DisplayLabel := 'Qtd. Colunas';
    FieldByName('CNF_CHRANT').DisplayLabel := 'Chr. Antes';
    FieldByName('CNF_CHRDEP').DisplayLabel := 'Crh. Depois';
  End;
end;

procedure TfrmCnfEtiqueta.pAtualizaDados(DataSet: TDataSet);
begin
  memDesCam.Texto := qryTabela.FieldByName('CNF_DESCAM').AsString;
end;

procedure TfrmCnfEtiqueta.pDeletaRegistro;
begin
  If (Not qryTabela.IsEmpty) And
     (fMensagem('', 'Confirma exclusão do registro?', ['&Não', '&Sim']) = 2) Then
  Begin
    qryTabela.Delete;
  End;
end;

procedure TfrmCnfEtiqueta.pEditaRegistro;
begin
  qryTabela.Edit;

  If tipTipEti = etiItensCPF Then
  Begin
    qryTabela.FieldByName('CNF_TIPETI').AsString := 'IOC';
  End;

  pHabilitaEdits(True);
  
  If tipTipEti = etiItensCPF Then
    pSetFocus(dbeIdenti)
  Else
    pSetFocus(dbeTipEti);
end;

procedure TfrmCnfEtiqueta.pEscapePressed;
begin
  btnIrGrid.Click;
end;

procedure TfrmCnfEtiqueta.pHabilitaEdits(blnHabilita: Boolean);
begin
  pnlDados.Enabled    := blnHabilita;
  dbgConfigs.Enabled  := Not blnHabilita;
  btnNovaConf.Enabled := Not blnHabilita;
  btnConfirma.Enabled := blnHabilita;
end;

procedure TfrmCnfEtiqueta.pIncluirRegistro;
  Var
    blnCopiaDescri: Boolean;
    intRetMsg: Integer;
    tmpCnfEti: TCnfEti;
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

      tmpCnfEti.strTipEti := FieldByName('CNF_TIPETI').AsString;
      tmpCnfEti.strIdenti := FieldByName('CNF_IDENTI').AsString;
      tmpCnfEti.intLinImp := FieldByName('CNF_LINIMP').AsInteger;
      tmpCnfEti.intQtdCol := FieldByName('CNF_QTDCOL').AsInteger;
      tmpCnfEti.intMargem := FieldByName('CNF_MARGEM').AsInteger;
      tmpCnfEti.strChrAnt := FieldByName('CNF_CHRANT').AsString;
      tmpCnfEti.strDesCam := FieldByName('CNF_DESCAM').AsString;
      tmpCnfEti.strChrDep := FieldByName('CNF_CHRDEP').AsString;
      tmpCnfEti.intCol001 := FieldByName('CNF_COL001').AsInteger;
      tmpCnfEti.intCol002 := FieldByName('CNF_COL002').AsInteger;
      tmpCnfEti.intCol003 := FieldByName('CNF_COL003').AsInteger;
      tmpCnfEti.intCol004 := FieldByName('CNF_COL004').AsInteger;
      tmpCnfEti.intCol005 := FieldByName('CNF_COL005').AsInteger;

      If blnCopiaDescri Then
        tmpCnfEti.strDesCam := FieldByName('CNF_DESCAM').AsString
      Else
        tmpCnfEti.strDesCam := '';

      tmpCnfEti.strChrDep := FieldByName('CNF_CHRDEP').AsString;

      Insert;

      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('CNFBOL', VS_strCodEmp);
      FieldByName('CNF_CODEMP').AsString  := VS_strCodEmp;

      FieldByName('CNF_TIPETI').AsString  := tmpCnfEti.strTipEti;
      FieldByName('CNF_IDENTI').AsString  := tmpCnfEti.strIdenti;
      FieldByName('CNF_LINIMP').AsInteger := tmpCnfEti.intLinImp;
      FieldByName('CNF_QTDCOL').AsInteger := tmpCnfEti.intQtdCol;
      FieldByName('CNF_MARGEM').AsInteger := tmpCnfEti.intMargem;
      FieldByName('CNF_CHRANT').AsString  := tmpCnfEti.strChrAnt;
      FieldByName('CNF_DESCAM').AsString  := tmpCnfEti.strDesCam;
      FieldByName('CNF_CHRDEP').AsString  := tmpCnfEti.strChrDep;
      FieldByName('CNF_COL001').AsInteger := tmpCnfEti.intCol001;
      FieldByName('CNF_COL002').AsInteger := tmpCnfEti.intCol002;
      FieldByName('CNF_COL003').AsInteger := tmpCnfEti.intCol003;
      FieldByName('CNF_COL004').AsInteger := tmpCnfEti.intCol004;
      FieldByName('CNF_COL005').AsInteger := tmpCnfEti.intCol005;

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

procedure TfrmCnfEtiqueta.pSubstituirValores;
  Var
    strSubsDe, strSubsPara: String;
    qryAux: TUniQuery;
begin
  strSubsDe := InputBox('Substituição', 'Digite o texto a ser subtituido: ', '');
  If Not fEmptyStr(strSubsDe) Then
  Begin
    strSubsPara := InputBox('Substituição', 'Digite o novo texto: ', '');
    If Not fEmptyStr(strSubsPara) Then
    Begin

      With qryAux Do
      Begin
        qryAux := fCriarQuery('SELECT * FROM CNFETI ORDER BY CNF_TIPETI, CNF_IDENTI, CNF_LINIMP, CNF_COL001');

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
      FreeAndNil(qryAux);

    End;
  End;
end;

procedure TfrmCnfEtiqueta.btnNovaConfClick(Sender: TObject);
begin
  inherited;
  pHabilitaEdits(True);
  pSetFocus(dbeTipEti);
  qryTabela.Insert;

  If tipTipEti = etiItensCPF Then
  Begin
    qryTabela.FieldByName('CNF_TIPETI').AsString := 'IOC';
    pSetFocus(dbeIdenti);
  End;
  
end;

procedure TfrmCnfEtiqueta.btnCamDispClick(Sender: TObject);
begin
  inherited;

  If btnCamDisp.Visible Then
    pMostraCamposDiponiveis;
  
end;

procedure TfrmCnfEtiqueta.btnConfirmaClick(Sender: TObject);
  Var
    intRecNo : Integer;
    strSQL   : String;
    qryGenEti: TUniQuery;

begin
  Try

    qryGenEti := fCriaQuery(Self);

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
          strSQL := strSQL + '  MAX(AUTOINCREM) + 1 AS VALOR ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CNFETI ';

          With qryGenEti Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            Open;

            qryTabela.FieldByName('AUTOINCREM').AsString := FieldByName('VALOR').AsString;
            qryTabela.FieldByName('CNF_CODEMP').AsString := Vs_strCodEmp;

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
    FreeAndNil(qryGenEti);
  End;

end;

procedure TfrmCnfEtiqueta.dbgConfigsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure TfrmCnfEtiqueta.mnuIncluirClick(Sender: TObject);
begin
  inherited;
  pIncluirRegistro;
end;

procedure TfrmCnfEtiqueta.mnuEditaRegClick(Sender: TObject);
begin
  inherited;
  pEditaRegistro;
end;

procedure TfrmCnfEtiqueta.mnuDeletaRegClick(Sender: TObject);
begin
  inherited;
  pDeletaRegistro;
end;

procedure TfrmCnfEtiqueta.FormCreate(Sender: TObject);
begin
  inherited;
  tipTipEti := etiVazio;
end;

procedure TfrmCnfEtiqueta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_F1: btnCamDisp.Click;
  End;

end;

procedure TfrmCnfEtiqueta.pMostraCamposDiponiveis;
Begin
  Case tipTipEti Of
    etiItensCPF: pMostraCamposDiponiveisItensCPF;
  End;
End;

procedure TfrmCnfEtiqueta.pMostraCamposDiponiveisItensCPF;
Begin

 If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(138, 6406, [],
                        ['INICAM','CODLAY'],
                        ['11',
                        'ETQ->'],
                        nil,
                        nil,
                        True);
  End;

End;

procedure TfrmCnfEtiqueta.FormShow(Sender: TObject);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CNFETI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CNF_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

  If tipTipEti = etiItensCPF Then
    strSQL := strSQL + ' AND CNF_TIPETI = "IOC" ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_TIPETI, CNF_IDENTI, CNF_LINIMP, CNF_COL001 ';

  qryTabela := fCriarQuery(strSQL, Self);
  qryTabela.AfterScroll := pAtualizaDados;
  qryTabela.AfterOpen := pAfterOpen;
  dtsTabela.DataSet := qryTabela;

  fAbrirTabela(qryTabela);
  pHabilitaEdits(False);

  If tipTipEti = etiItensCPF Then
  Begin
    dbeTipEti.ReadOnly := True;
    dbeTipEti.TabStop  := False;
  End;

  btnCamDisp.Visible := tipTipEti In [etiItensCPF];
end;

procedure TfrmCnfEtiqueta.btnIrGridClick(Sender: TObject);
begin
  inherited;
  If qryTabela.UpdatesPending Then
    qryTabela.CancelUpdates;
  qryTabela.Cancel;

  pAtualizaDados(Nil);
  pHabilitaEdits(False);
  pSetFocus(dbgConfigs);
end;

end.


