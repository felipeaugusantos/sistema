unit untAltEfetivacaoPrecosTab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  ImgList, Uni,  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  System.ImageList, untPreAlt_Trigger;

type
  TfrmAltEfetivacaoPrecosTab = class(TfrmPai)
    ImageList1: TImageList;
    lsvTabDis: TListView;
    pgbBarra: TProgressBar;
    btnConfirma: TBitBtnLocked;
    btnCancel: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    qryPreAlt: TUniQuery;
    function fGravaPrecos(strCodTab: String): Boolean;
    function  fApagaIteTab(strCodTab, strCodEmp: String): Boolean;
    function  fRetSQLItens: String;
    procedure pSetaParametrosItens(Var qryGenIte: TUniQuery; strCodTab, strCodEmp: String);
  public
    { Public declarations }
  end;

var
  frmAltEfetivacaoPrecosTab: TfrmAltEfetivacaoPrecosTab;

implementation

uses untFuncoesSimples, untPreAlt, untFuncoesAuxiliares, Data.DB;

{$R *.dfm}

procedure TfrmAltEfetivacaoPrecosTab.btnCancelClick(Sender: TObject);
var
  lsiItem: TListItem;
begin
  inherited;
  If lsvTabDis.SelCount > 0 Then
  Begin
    lsiItem := lsvTabDis.ItemFocused;
    If fMensagem('Confirmação','Confirma o cancelamento da efetivação da Tabela "' + lsvTabDis.Items[lsvTabDis.ItemIndex].SubItems[0] + '"?', ['&Sim', '&Não'], 2) = 1 Then
    begin
      If fApagaIteTab(lsiItem.Caption, VS_strCodEmp) Then
      Begin
        fMensagem('Informação', 'Cancelamento realizado com sucesso!',['&OK']);
        Self.Close;
      End;
    End;
  End
  Else
    fMensagem('Informação','Nenhuma Tabela foi selecionada',['&OK']);
end;

procedure TfrmAltEfetivacaoPrecosTab.btnConfirmaClick(Sender: TObject);
var
  lsiItem: TListItem;
begin
  inherited;
  If lsvTabDis.SelCount > 0 Then
  Begin
    lsiItem := lsvTabDis.ItemFocused;
    If fMensagem('Confirmação','Confirma efetivação da Tabela "' + lsvTabDis.Items[lsvTabDis.ItemIndex].SubItems[0] + '"?', ['&Sim', '&Não'], 2) = 1 Then
    begin
      If fGravaPrecos(lsiItem.Caption) Then
      Begin
        fMensagem('Informação', 'Preços atualizados com sucesso',['&OK']);
        Self.Close;
      End;
    End;
  End
  Else
    fMensagem('Informação','Nenhuma Tabela foi selecionada',['&OK']);
end;

function TfrmAltEfetivacaoPrecosTab.fApagaIteTab(strCodTab, strCodEmp: String): Boolean;
Var
  qryGenIte: TUniQuery;
begin

  Try

    qryGenIte := fCriaQuery(Self);

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQLItens);
      pSetaParametrosItens(qryGenIte, strCodTab, strCodEmp);
      Open;
      First;

      While Not Eof Do
      Begin
        fVerificaIntegridade(Self.Name,'ITETAB', qryGenIte, True, False);
        Next;
      End;

    End;

    With qryGenIte Do
    Begin
      SQL.Clear;
      SQL.Add(' DELETE FROM ');
      SQL.Add('  ITETAB     ');
      SQL.Add(' WHERE PRE_CODTAB = :CODTAB AND ');
      SQL.Add('       PRE_CODEMP = :CODEMP ');

      ParamByName('CODTAB').AsString := strCodTab;
      ParamByName('CODEMP').AsString := strCodEmp;

      ExecSQL;
    End;

    Result := True;

  Finally
    FreeAndNil(qryGenIte);
  End;


end;

function TfrmAltEfetivacaoPrecosTab.fGravaPrecos(strCodTab: String): Boolean;
Var
  qryGenIte  : TUniQuery;
  qryGenIt2  : TUniQuery;
  strEmpresas: String;
  strAgrupadorPreAlt: String;
Begin
  qryGenIte := fCriaQuery(Self);
  qryGenIt2 := fCriaQuery(Self);

  Screen.Cursor := crSQLWait;

  Result := False;

  {**********************************}
  {* PEGA AS EMPRESAS COM PREMAT    *}
  {*******************************JB*}
  strEmpresas := fRetEmpresasUsamPrecoMatriz;

  With qryGenIte Do
  Begin
    SQL.Clear;
    SQL.Add(fRetSQLItens);
    pSetaParametrosItens(qryGenIte, strCodTab, VS_strCodEmp);
    Open;
    pgbBarra.Max      := RecordCount;
    pgbBarra.Position := 0;

    If Not IsEmpty Then
    Begin
      Try
        fStartTransaction;
        pPreAltDefineVariaveisAltPre(fNow, 'EFETIVACAO DE PRECOS - ' + lsvTabDis.Items[lsvTabDis.ItemIndex].SubItems[0], strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

        While Not Eof Do
        Begin
          With qryGenIt2 Do
          Begin
            SQL.Clear;
            SQL.Add(' UPDATE ITEGER ');
            SQL.Add('   SET         ');
            SQL.Add('    ITE_CODITE = ITE_CODITE,');
            SQL.Add('    ITE_PREALT = "'+strAgrupadorPreAlt+'", ');

            If Not qryGenIte.FieldByName('PRE_PRECOM').IsNull Then
            Begin
              SQL.Add('   ITE_PRECOM = :PRECOM,');
              ParamByName('PRECOM').AsFloat := qryGenIte.FieldByName('PRE_PRECOM').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_DESF01').IsNull Then
            Begin
              SQL.Add('   ITE_DESF01 = :DESF01,');
              ParamByName('DESF01').AsFloat := qryGenIte.FieldByName('PRE_DESF01').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_DESF02').IsNull Then
            Begin
              SQL.Add('   ITE_DESF02 = :DESF02,');
              ParamByName('DESF02').AsFloat := qryGenIte.FieldByName('PRE_DESF02').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_DESF03').IsNull Then
            Begin
              SQL.Add('   ITE_DESF03 = :DESF03,');
              ParamByName('DESF03').AsFloat := qryGenIte.FieldByName('PRE_DESF03').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_DESF04').IsNull Then
            Begin
              SQL.Add('   ITE_DESF04 = :DESF04,');
              ParamByName('DESF04').AsFloat := qryGenIte.FieldByName('PRE_DESF04').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_DESF05').IsNull Then
            Begin
              SQL.Add('   ITE_DESF05 = :DESF05,');
              ParamByName('DESF05').AsFloat := qryGenIte.FieldByName('PRE_DESF05').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_DESF06').IsNull Then
            Begin
              SQL.Add('   ITE_DESF06 = :DESF06,');
              ParamByName('DESF06').AsFloat := qryGenIte.FieldByName('PRE_DESF06').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_ICMENT').IsNull Then
            Begin
              SQL.Add('   ITE_ICMENT = :ICMENT,');
              ParamByName('ICMENT').AsFloat := qryGenIte.FieldByName('PRE_ICMENT').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_SUBFED').IsNull Then
            Begin
              SQL.Add('   ITE_SUBFED = :SUBFED,');
              ParamByName('SUBFED').AsFloat := qryGenIte.FieldByName('PRE_SUBFED').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_IPIENT').IsNull Then
            Begin
              SQL.Add('   ITE_IPIENT = :IPIENT,');
              ParamByName('IPIENT').AsFloat := qryGenIte.FieldByName('PRE_IPIENT').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_FREENT').IsNull Then
            Begin
              SQL.Add('   ITE_FREENT = :FREENT,');
              ParamByName('FREENT').AsFloat := qryGenIte.FieldByName('PRE_FREENT').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_VALFRE').IsNull Then
            Begin
              SQL.Add('   ITE_VALFRE = :VALFRE,');
              ParamByName('VALFRE').AsFloat := qryGenIte.FieldByName('PRE_VALFRE').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_ACRFIN').IsNull Then
            Begin
              SQL.Add('   ITE_ACRFIN = :ACRFIN,');
              ParamByName('ACRFIN').AsFloat := qryGenIte.FieldByName('PRE_ACRFIN').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_SUBSTI').IsNull Then
            Begin
              SQL.Add('   ITE_SUBSTI = :SUBSTI,');
              ParamByName('SUBSTI').AsFloat := qryGenIte.FieldByName('PRE_SUBSTI').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_DESADB').IsNull Then
            Begin
              SQL.Add('   ITE_DESADB = :DESADB,');
              ParamByName('DESADB').AsFloat := qryGenIte.FieldByName('PRE_DESADB').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_PRECUS_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_PRECUS = :PRECUS,');
              ParamByName('PRECUS').AsFloat := qryGenIte.FieldByName('PRE_PRECUS_NOV').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_OUTVAL').IsNull Then
            Begin
              SQL.Add('   ITE_OUTVAL = :OUTVAL,');
              ParamByName('OUTVAL').AsFloat := qryGenIte.FieldByName('PRE_OUTVAL').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_ICMSAI').IsNull Then
            Begin
              SQL.Add('   ITE_ICMSAI = :ICMSAI,');
              ParamByName('ICMSAI').AsFloat := qryGenIte.FieldByName('PRE_ICMSAI').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_IMPFED').IsNull Then
            Begin
              SQL.Add('   ITE_IMPFED = :IMPFED,');
              ParamByName('IMPFED').AsFloat := qryGenIte.FieldByName('PRE_IMPFED').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_DESMAX').IsNull Then
            Begin
              SQL.Add('   ITE_DESMAX = :DESMAX,');
              ParamByName('DESMAX').AsFloat := qryGenIte.FieldByName('PRE_DESMAX').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_DESMGE').IsNull Then
            Begin
              SQL.Add('   ITE_DESMGE = :DESMGE,');
              ParamByName('DESMGE').AsFloat := qryGenIte.FieldByName('PRE_DESMGE').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_DESMSU').IsNull Then
            Begin
              SQL.Add('   ITE_DESMSU = :DESMSU,');
              ParamByName('DESMSU').AsFloat := qryGenIte.FieldByName('PRE_DESMSU').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_MARBR1_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_MARBR1 = :MARBR1,');
              ParamByName('MARBR1').AsFloat := qryGenIte.FieldByName('PRE_MARBR1_NOV').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_PREVE1_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_PREVE1 = :PREVE1,');
              ParamByName('PREVE1').AsFloat := qryGenIte.FieldByName('PRE_PREVE1_NOV').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_MARBR2_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_MARBR2 = :MARBR2,');
              ParamByName('MARBR2').AsFloat := qryGenIte.FieldByName('PRE_MARBR2_NOV').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_PREVE2_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_PREVE2 = :PREVE2,');
              ParamByName('PREVE2').AsFloat := qryGenIte.FieldByName('PRE_PREVE2_NOV').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_MARBR3_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_MARBR3 = :MARBR3,');
              ParamByName('MARBR3').AsFloat := qryGenIte.FieldByName('PRE_MARBR3_NOV').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_PREVE3_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_PREVE3 = :PREVE3,');
              ParamByName('PREVE3').AsFloat := qryGenIte.FieldByName('PRE_PREVE3_NOV').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_MARBR4_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_MARBR4 = :MARBR4,');
              ParamByName('MARBR4').AsFloat := qryGenIte.FieldByName('PRE_MARBR4_NOV').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_PREVE4_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_PREVE4 = :PREVE4,');
              ParamByName('PREVE4').AsFloat := qryGenIte.FieldByName('PRE_PREVE4_NOV').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_MARBR5_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_MARBR5 = :MARBR5,');
              ParamByName('MARBR5').AsFloat := qryGenIte.FieldByName('PRE_MARBR5_NOV').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_PREVE5_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_PREVE5 = :PREVE5,');
              ParamByName('PREVE5').AsFloat := qryGenIte.FieldByName('PRE_PREVE5_NOV').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_MARBR6_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_MARBR6 = :MARBR6,');
              ParamByName('MARBR6').AsFloat := qryGenIte.FieldByName('PRE_MARBR6_NOV').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_PREVE6_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_PREVE6 = :PREVE6,');
              ParamByName('PREVE6').AsFloat := qryGenIte.FieldByName('PRE_PREVE6_NOV').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_MARBR7_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_MARBR7 = :MARBR7,');
              ParamByName('MARBR7').AsFloat := qryGenIte.FieldByName('PRE_MARBR7_NOV').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_PREVE7_NOV').IsNull Then
            Begin
              SQL.Add('   ITE_PREVE7 = :PREVE7,');
              ParamByName('PREVE7').AsFloat := qryGenIte.FieldByName('PRE_PREVE7_NOV').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_COMTB1').IsNull Then
            Begin
              SQL.Add('   ITE_COMTB1 = :COMTB1,');
              ParamByName('COMTB1').AsFloat := qryGenIte.FieldByName('PRE_COMTB1').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_COMTB2').IsNull Then
            Begin
              SQL.Add('   ITE_COMTB2 = :COMTB2,');
              ParamByName('COMTB2').AsFloat := qryGenIte.FieldByName('PRE_COMTB2').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_COMTB3').IsNull Then
            Begin
              SQL.Add('   ITE_COMTB3 = :COMTB3,');
              ParamByName('COMTB3').AsFloat := qryGenIte.FieldByName('PRE_COMTB3').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_COMTB4').IsNull Then
            Begin
              SQL.Add('   ITE_COMTB4 = :COMTB4,');
              ParamByName('COMTB4').AsFloat := qryGenIte.FieldByName('PRE_COMTB4').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_COMTB5').IsNull Then
            Begin
              SQL.Add('   ITE_COMTB5 = :COMTB5,');
              ParamByName('COMTB5').AsFloat := qryGenIte.FieldByName('PRE_COMTB5').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_COMTB6').IsNull Then
            Begin
              SQL.Add('   ITE_COMTB6 = :COMTB6,');
              ParamByName('COMTB6').AsFloat := qryGenIte.FieldByName('PRE_COMTB6').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_COMTB7').IsNull Then
            Begin
              SQL.Add('   ITE_COMTB7 = :COMTB7,');
              ParamByName('COMTB7').AsFloat := qryGenIte.FieldByName('PRE_COMTB7').AsFloat;
            End;

            If Not qryGenIte.FieldByName('PRE_MARMIN').IsNull Then
            Begin
              SQL.Add('   ITE_MARMIN = :MARMIN,');
              ParamByName('MARMIN').AsFloat := qryGenIte.FieldByName('PRE_MARMIN').AsFloat;
            End;
            If Not qryGenIte.FieldByName('PRE_DESOPE').IsNull Then
            Begin
              SQL.Add('   ITE_DESOPE = :DESOPE,');
              ParamByName('DESOPE').AsFloat := qryGenIte.FieldByName('PRE_DESOPE').AsFloat;
            End;

            SQL.Text := Copy(SQL.Text, 1, Length(SQL.Text)-3);

            SQL.Add(' WHERE ITE_CODITE = :CODITE AND ');
            SQL.Add('       LOCATE(ITE_CODEMP, :CODEMP) > 0 ');

            ParamByName('CODITE').AsString := qryGenIte.FieldByName('PRE_CODITE').AsString;

            ParamByName('CODEMP').AsString := strEmpresas;

            ExecSQL;
            If (Not VS_blnPreAltViaTrigger) Then
              fGravaPreAlt(qryGenIte.FieldByName('PRE_CODITE').AsString,
                         qryGenIte.FieldByName('PRE_PRECUS').AsFloat,
                         qryGenIte.FieldByName('PRE_PRECUS_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE1').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE1_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR1').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR1_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE2').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE2_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR2').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR2_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE3').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE3_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR3').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR3_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE4').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE4_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR4').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR4_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE5').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE5_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR5').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR5_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE6').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE6_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR6').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR6_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE7').AsFloat,
                         qryGenIte.FieldByName('PRE_PREVE7_NOV').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR7').AsFloat,
                         qryGenIte.FieldByName('PRE_MARBR7_NOV').AsFloat,

                         qryGenIte.FieldByName('PRE_PRECOM_ANT').AsFloat,
                         qryGenIte.FieldByName('PRE_PRECOM').AsFloat,

                         'EFETIVACAO DE PRECOS - ' +
                         lsvTabDis.Items[lsvTabDis.ItemIndex].SubItems[0],

                         Nil,
                         '',
                         strLoginUsuarioLogado);

            pAtualizaItensGrupoPrecos(qryGenIte.FieldByName('PRE_CODITE').AsString,
                                      'EFETIVACAO DE PRECOS - ' +
                                      lsvTabDis.Items[lsvTabDis.ItemIndex].SubItems[0], strAgrupadorPreAlt);

          End;

          pgbBarra.StepBy(1);
          Next;
        End;

        {*****************************************}
        {* APAGA OS REGISTROS DA TABELA ITETAB Q *}
        {* JÁ FORAM ATUALIZADOS NA TABELA ITEGER *}
        {**************************************RV*}
        Result := fApagaIteTab(strCodTab, VS_strCodEmp);

        If (Result) Then
          fCommit
        Else
          fRollBack;

        Screen.Cursor := crDefault;
      Except
        on E: Exception do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[fGravaPrecos]');
          Result := False;
        End;
      End;
    End;
  End;

  Screen.Cursor := crDefault;

  FreeAndNil(qryGenIte);
  FreeAndNil(qryGenIt2);
  strAgrupadorPreAlt := '';
end;

procedure TfrmAltEfetivacaoPrecosTab.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fFecharTabela(qryPreAlt);
end;

procedure TfrmAltEfetivacaoPrecosTab.FormCreate(Sender: TObject);
begin
  inherited;
  qryPreAlt := fCriarQuery('SELECT * FROM PREALT WHERE FALSE', Self);
  fAbrirTabela(qryPreAlt);
end;

procedure TfrmAltEfetivacaoPrecosTab.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    btnSairClick(Sender);
end;

procedure TfrmAltEfetivacaoPrecosTab.FormShow(Sender: TObject);
var
  lsvLista : TListItem;
  qryGenIte: TUniQuery;
begin
  inherited;
  Try
    qryGenIte := fCriaQuery(Self);
    With qryGenIte Do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add('   PRE_CODTAB, PRE_DESCRI, COUNT(*) AS QTD ');
      SQL.Add(' FROM ');
      SQL.Add('   ITETAB ');
      SQL.Add(' WHERE (PRE_CODEMP = :CODEMP) ');
      SQL.Add(' GROUP BY PRE_CODTAB ');
      SQL.Add(' ORDER BY PRE_CODTAB ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      If Not IsEmpty Then
      Begin
        lsvTabDis.Clear;
        While Not EOF Do
        Begin
          lsvLista            := lsvTabDis.Items.Add;
          lsvLista.ImageIndex := 0;
          lsvLista.StateIndex := 3;
          lsvLista.Caption    := FieldByName('PRE_CODTAB').AsString;
          lsvLista.SubItems.Add(FieldByName('PRE_DESCRI').AsString);
          lsvLista.SubItems.Add(FieldByName('QTD').AsString);
          Next;
        End;
        pSetFocus(lsvTabDis);
      End
      Else
      Begin
        fMensagem('Atenção', 'Nenhuma Tabela de alteração de preços está cadastrada',['&OK']);
        lsvTabDis.Clear;
        Self.Close;
      End;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmAltEfetivacaoPrecosTab.fRetSQLItens: String;
begin
  Result := '';
  Result := Result + 'SELECT   ';
  Result := Result + '  *      ';
  Result := Result + 'FROM     ';
  Result := Result + '  ITETAB ';
  Result := Result + 'WHERE    ';
  Result := Result + '  PRE_CODTAB = :CODTAB AND ';
  Result := Result + '  PRE_CODEMP = :CODEMP     ';
end;

procedure TfrmAltEfetivacaoPrecosTab.pSetaParametrosItens(
  var qryGenIte: TUniQuery; strCodTab, strCodEmp: String);
begin
  With qryGenIte Do
  Begin
    ParamByName('CODTAB').AsString := strCodTab;
    ParamByName('CODEMP').AsString := strCodEmp;
  End;
end;

end.

