unit untImportComisVendTabPreco;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
 System.Classes, Vcl.Graphics, strUtils, ComObj, untFatorPreco, Vcl.Controls,
 Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
 Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls,
 Vcl.Mask, FilenameEditFocus,untZClient, untFuncoesSimples, Uni, Data.DB,
 UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, cxButtons;

 type
  TRecTabPrecos = Record
    fltPreVen,
    fltMarBru,
    fltComiss: Double;
  End;

  TArrRecPrecos = Array[1..7] Of TRecTabPrecos;

  TfrmImportComisVendTabPreco = class(TfrmPai)
    pnlfundo: TPanel;
    Label1: TLabel;
    gpbRecalcular: TGroupBox;
    rdbMargem: TRadioButton;
    rdbPreVen: TRadioButton;
    btnGravar: TBitBtnLocked;
    pgbGeral: TProgressBar;
    edtPath: TFilenameEditFocus;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    function  fGetSqlBase: String;
    procedure pFormataCampo(Campo: string);
    procedure pCriarCds;
    function fCriarCdsLocalizaItens: TZClient;
    function fLocalizaItenCDS(qryLocaliza: TZClient; intLinha: Integer): boolean;
    procedure pLimparCDS;

    procedure btnGravarClick(Sender: TObject);
    procedure pSetaParamentros(intLinha: Integer; qrySQL: TUniQuery);
    procedure pInsereItensCDS(intLinha: integer);
    function  fTemTitulo: boolean;
    function  fValidaMargem(intTabPreco: Integer; cdsIte: TZClient; objPrecos: TArrRecPrecos): Boolean;
    function  fCalcularPrecos(cdsIte: TZClient): TArrRecPrecos;
    function  fRetPrecoCusto(fltPreCom,
                             fltDesF01,
                             fltDesF02,
                             fltDesF03,
                             fltDesF04,
                             fltDesF05,
                             fltDesF06,
                             fltICMEnt,
                             fltSubFed,
                             fltIpiEnt,
                             fltFreEnt,
                             fltAcrFin,
                             fltSubsti,
                             fltDesAdb: Double;
                             blnPreDol: Boolean;
                             fltTCIFCu,
                             fltTSCust,
                             fltDePiCo,
                             fltDeICMS,
                             fltFatReg: Double): Double;
    procedure btnHlpImpClick(Sender: TObject);

  private
    Excel : Variant;
    objFatPre: TFatorPreco;
    cdsItens : TZClient;
    qryLocalizaItem: TZClient;

    const cCodIte = 'A';
          cCodBar = 'B';
          cCodFab = 'C';
          cCodFor = 'D';
          cTab__1 = 'E';
          cTab__2 = 'F';
          cTab__3 = 'G';
          cTab__4 = 'H';
          cTab__5 = 'I';
          cTab__6 = 'J';
          cTab__7 = 'K';
    { Private declarations }
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmImportComisVendTabPreco: TfrmImportComisVendTabPreco;

implementation

{$R *.dfm}

uses untParCalculaPrecoCusto, untTConfiguracao, untImportComisVendTabPrecoConfirma;

procedure TfrmImportComisVendTabPreco.btnGravarClick(Sender: TObject);
  Var
    intValIni, intRes, intContador : Integer;
begin
  inherited;
  intRes := -1;
  If fVerificaCampos Then
  Begin
    {*******************************}
    { VERIRICA SE O ARQUIVO EXISTE  }
    {****************************LU*}
    If Not (FileExists(edtPath.Text)) Then
    Begin
      fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
      Exit;
    End;
    Try
       btnGravar.Enabled     := False;
       btnSair.Enabled       := False;
       btnHlpImp.Enabled     := False;
       edtPath.Enabled       := False;
       gpbRecalcular.Enabled := False;

       pnlInfo.Caption       := 'Aguarde... Carregando cadastro de Produtos...';
       Application.ProcessMessages;
       qryLocalizaItem := fCriarCdsLocalizaItens();

       pnlInfo.Caption       := 'Aguarde... Importando Tabelas de Comissão...';

       edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');
       Try
         pCriarCds;
         {**************************************}
         {* ABRE EXCEL E ARQUIVO XLS           *}
         {***********************************LU*}
         Excel := CreateOleObject('Excel.Application');
         Excel.Visible       := False;
         Excel.DisplayAlerts := False;
         Excel.WorkBooks.Open(Filename := edtPath.Text);

         {****************************************}
         {* VAI PARA A ULTIMA CELULA COM DADOS   *}
         {* PARA PEGAR A QUANTIDADE DE REGISTROS *}
         {*************************************LU*}
         {xlCellTypeLastCell. A última célula no intervalo usado = 11}
         Excel.Selection.SpecialCells(11).Select;

         pgbGeral.Max := Excel.ActiveCell.Row -1;

         pgbGeral.Position := 0;

         pLimparCDS;

         If fTemTitulo Then
           intValIni := 2
         Else
           intValIni := 1;

         For intContador := intValIni To (pgbGeral.Max + 1) Do
         Begin
           pInsereItensCDS(intContador);
           pgbGeral.StepBy(1);
           Application.ProcessMessages;
         End;

         try
           If not cdsItens.IsEmpty Then
           Begin
             pCriarFormularios(TfrmImportComisVendTabPrecoConfirma, frmImportComisVendTabPrecoConfirma);
             frmImportComisVendTabPrecoConfirma.blnPrecoVenda := rdbPreVen.Checked;
             intRes := frmImportComisVendTabPrecoConfirma.ShowModal(cdsItens);
           End;
         Finally
           FreeAndNil(frmImportComisVendTabPrecoConfirma);
         End;

         SetForegroundWindow(Handle);
         If intRes = mrOk Then
            fMensagem('Aviso', 'Importação concluída com sucesso!', ['&O k']);

         edtPath.Clear;
         btnGravar.Enabled     := True;
         btnSair.Enabled       := True;
         edtPath.Enabled       := True;
         gpbRecalcular.Enabled := True;
         pnlInfo.Caption       := '';
         pgbGeral.Position     := 0;
         pSetFocus(btnSair);

         cdsItens.Close;

       Except
         On E: Exception Do
         Begin

           pMensagensErro(E.Message, '[TfrmImportComisVendTabPreco.btnGravarClick]');
           pnlInfo.Caption       := '';
           pgbGeral.Position     := 0;
           pSetFocus(btnSair);
         End;
       End;
    Finally
      FreeAndNil(qryLocalizaItem);
      btnGravar.Enabled     := True;
      btnSair.Enabled       := True;
      btnHlpImp.Enabled     := True;
      edtPath.Enabled       := True;
      gpbRecalcular.Enabled := True;
      pnlInfo.Caption       := '';
      pgbGeral.Position     := 0;
    End;
  End;
  Try
    Excel.Quit;
  Except

  End;

end;

procedure TfrmImportComisVendTabPreco.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

destructor TfrmImportComisVendTabPreco.Destroy;
begin
  FreeAndNil(CdsItens);
  Excel := '';
  inherited;
end;

function TfrmImportComisVendTabPreco.fCalcularPrecos(cdsIte: TZClient): TArrRecPrecos;
  var
   fltPreCus: Double;
   i, intTabela: integer;
begin
  fltPreCus := fRetPrecoCusto(cdsItens.FieldByName('PRECOM').AsFloat,
                              cdsItens.FieldByName('DESF01').AsFloat,
                              cdsItens.FieldByName('DESF02').AsFloat,
                              cdsItens.FieldByName('DESF03').AsFloat,
                              cdsItens.FieldByName('DESF04').AsFloat,
                              cdsItens.FieldByName('DESF05').AsFloat,
                              cdsItens.FieldByName('DESF06').AsFloat,
                              cdsItens.FieldByName('ICMENT').AsFloat,
                              cdsItens.FieldByName('SUBFED').AsFloat,
                              cdsItens.FieldByName('IPIENT').AsFloat,
                              cdsItens.FieldByName('FREENT').AsFloat,
                              cdsItens.FieldByName('ACRFIN').AsFloat,
                              cdsItens.FieldByName('SUBSTI').AsFloat,
                              cdsItens.FieldByName('DESADB').AsFloat,
                              cdsItens.FieldByName('PREDOL').AsString = 'S',
                              cdsItens.FieldByName('TCIFCU').AsFloat,
                              cdsItens.FieldByName('TSCUST').AsFloat,
                              cdsItens.FieldByName('DEPICO').AsFloat,
                              cdsItens.FieldByName('DEICMS').AsFloat,
                              cdsItens.FieldByName('FATREG').AsFloat);
  For i := 1 To 7 do
   Result[i].fltComiss := cdsIte.FieldByName('COMTBN' +  IntToStr(i)).AsFloat;

  If rdbPreVen.Checked Then
  Begin
    For intTabela := 1 To 7 Do
    Begin
      Result[intTabela].fltComiss := cdsItens.FieldByName('COMTB' + IntToStr(intTabela)).AsFloat;
      Result[intTabela].fltMarBru := cdsItens.fieldbyname('MARBR' + IntToStr(intTabela)).AsFloat;
      If ((Not Assigned(objFatPre) Or (Assigned(objFatPre) And (Not objFatPre.fTabelaAtiva(intTabela))))) Or (intTabela = 1) Then
      Begin
        Result[intTabela].fltPreVen := fCalculaPrecoVenda(1,
                                                          fltPreCus + cdsItens.FieldByName('OUTVAL').AsFloat,
                                                          0,
                                                          Result[intTabela].fltMarBru,
                                                          cdsItens.FieldByName('ICMSAI').AsFloat,
                                                          cdsItens.FieldByName('IMPFED').AsFloat,
                                                          cdsItens.FieldByName('DESOPE').AsFloat,
                                                          Result[intTabela].fltComiss)
      End
      Else
      Begin
        Result[intTabela].fltPreVen := objFatPre.fCalculaPrecoVendaFator(cdsItens.fieldbyname('PREVE1').AsFloat, intTabela);
        Result[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                          fltPreCus + cdsItens.FieldByName('OUTVAL').AsFloat,
                                                          Result[intTabela].fltPreVen,
                                                          0,
                                                          cdsItens.FieldByName('ICMSAI').AsFloat,
                                                          cdsItens.FieldByName('IMPFED').AsFloat,
                                                          cdsItens.FieldByName('DESOPE').AsFloat,
                                                          Result[intTabela].fltComiss)
      End;
    End;
  End
  Else
  Begin
    For intTabela := 1 To 7 Do
    Begin
      Result[intTabela].fltPreVen := cdsItens.fieldbyname('PREVE' + IntToStr(intTabela)).AsFloat;
      Result[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                        fltPreCus + cdsItens.FieldByName('OUTVAL').AsFloat,
                                                        Result[intTabela].fltPreVen,
                                                        0,
                                                        cdsItens.FieldByName('ICMSAI').AsFloat,
                                                        cdsItens.FieldByName('IMPFED').AsFloat,
                                                        cdsItens.FieldByName('DESOPE').AsFloat,
                                                        Result[intTabela].fltComiss);
    End;
  End;
end;

function TfrmImportComisVendTabPreco.fCriarCdsLocalizaItens: TZClient;
  var
    strSql : String;
begin
  strSql := fGetSqlBase;
  strSql := strSql + '  FROM ITEGER G ';
  strSql := strSql + '  LEFT JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
  strSql := strSql + '  LEFT JOIN ITEBAR B ON B.BAR_CODITE = G.ITE_CODITE AND B.BAR_CODEMP = G.ITE_CODEMP ';
  strSql := strSql + ' WHERE G.ITE_CODEMP = ' + VS_strCodEmp;

  Result := TZClient.Create(Self, strSql);
  Result.fAbreClient(True, 'TfrmImportComisVendTabPreco.fCriarCdsLocalizaItens');
end;

function TfrmImportComisVendTabPreco.fGetSqlBase: String;
  var
    strSql: String;
  procedure pAddFieldsPorTabelaDePreco(strNomeBaseCampo: string);
  var
    i: integer;
  Begin
    for i := 1 to 7 do
    Begin
      strSql := strSql + (' G.ITE_' + strNomeBaseCampo + IntToStr(i) + ' AS ' + strNomeBaseCampo + IntToStr(i) + ', ');
      strSql := strSql + (' G.ITE_' + strNomeBaseCampo + IntToStr(i) + ' AS ' + strNomeBaseCampo + 'N' + IntToStr(i) + ', ');
    End;
  End;

begin
  strSql := strSql + ('SELECT ');

  // Margem Bruta
  pAddFieldsPorTabelaDePreco( 'MARBR');

  // Preco de Venda
  pAddFieldsPorTabelaDePreco( 'PREVE');

  // Comissao
  pAddFieldsPorTabelaDePreco( 'COMTB');

  strSql := strSql + ( 'G.ITE_CODITE AS CODITE,');
  strSql := strSql + ( 'G.ITE_CODITE AS CODITE,');
  strSql := strSql + (' G.ITE_PRECUS AS PRECUS ,');
  strSql := strSql + ( 'B.BAR_CODBAR AS CODBAR,');
  strSql := strSql + ( 'I.ITE_CODFOR AS CODFOR,');
  strSql := strSql + ( 'I.ITE_CODFAB AS CODFAB,');
  strSql := strSql + ( 'I.ITE_DESITE AS DESITE,');
  strSql := strSql + ( 'G.ITE_DESF01 AS DESF01,');
  strSql := strSql + ( 'G.ITE_DESF02 AS DESF02,');
  strSql := strSql + ( 'G.ITE_DESF03 AS DESF03,');
  strSql := strSql + ( 'G.ITE_DESF04 AS DESF04,');
  strSql := strSql + ( 'G.ITE_DESF05 AS DESF05,');
  strSql := strSql + ( 'G.ITE_DESF06 AS DESF06,');
  strSql := strSql + ( 'G.ITE_ICMENT AS ICMENT,');
  strSql := strSql + ( 'G.ITE_SUBFED AS SUBFED,');
  strSql := strSql + ( 'G.ITE_IPIENT AS IPIENT,');
  strSql := strSql + ( 'G.ITE_FREENT AS FREENT,');
  strSql := strSql + ( 'G.ITE_ACRFIN AS ACRFIN,');
  strSql := strSql + ( 'G.ITE_SUBSTI AS SUBSTI,');
  strSql := strSql + ( 'G.ITE_DESADB AS DESADB,');
  strSql := strSql + ( 'G.ITE_PREDOL AS PREDOL,');
  strSql := strSql + ( 'G.ITE_OUTVAL AS OUTVAL,');
  strSql := strSql + ( 'G.ITE_ICMSAI AS ICMSAI,');
  strSql := strSql + ( 'G.ITE_IMPFED AS IMPFED,');
  strSql := strSql + ( 'G.ITE_DESOPE AS DESOPE,');
  strSql := strSql + ( 'G.ITE_PRECOM AS PRECOM,');
  strSql := strSql + ( 'G.ITE_TCIFCU AS TCIFCU,');
  strSql := strSql + ( 'G.ITE_TSCUST AS TSCUST,');
  strSql := strSql + ( 'G.ITE_DEPICO AS DEPICO,');
  strSql := strSql + ( 'G.ITE_DEICMS AS DEICMS,');
  strSql := strSql + ( 'G.ITE_FATREG AS FATREG ');
  Result := strSql;
end;

function TfrmImportComisVendTabPreco.fLocalizaItenCDS(qryLocaliza: TZClient; intLinha: Integer): boolean;
  var
    strValor : String;
begin
  strValor := Format('%0.'+IntToStr(fTamCodIte)+'d', [StrToInt(Trim(Excel.Range[cCodIte + IntToStr(intLinha)].Value))]);
  Result := qryLocaliza.Locate('CODITE', strValor, []);
  If Not Result Then
     Result := qryLocaliza.Locate('CODBAR', Trim(Excel.Range[cCodBar + IntToStr(intLinha)].Value), []);
  If Not Result Then
     Result := qryLocaliza.Locate('CODFOR;CODFAB',
                                        VarArrayOf([Trim(Excel.Range[cCodFor + IntToStr(intLinha)].Value),
                                                    Trim(Excel.Range[cCodFab + IntToStr(intLinha)].Value)]), []);
end;

procedure TfrmImportComisVendTabPreco.pCriarCds;
var
  strSql: string;
begin
  strSql := fGetSqlBase;
  strSql := strSql + (', "" AS DESEXC,');
  strSql := strSql + (' 0 AS IMPORT');
  strSql := strSql + (' FROM ITEGER G');
  strSql := strSql + (' LEFT JOIN ITEBAR B ON B.BAR_CODITE = G.ITE_CODITE AND B.BAR_CODEMP = G.ITE_CODEMP');
  strSql := strSql + ('  LEFT JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE');
  strSql := strSql + ('  WHERE FALSE');

  cdsItens := TZClient.Create(Self, strSql);

  cdsItens.fAbreClient(True,'[TfrmImportComisVendTabPreco.pCriarCds]');

  // Margem Bruta
  pFormataCampo( 'MARBR');

  // Preco de Venda
  pFormataCampo( 'PREVE');

  // Comissao
  pFormataCampo( 'COMTB');

end;

procedure TfrmImportComisVendTabPreco.pFormataCampo(Campo: string);
  var
    i: integer;
begin
  Begin
    for i := 1 to 7 do
    Begin
      (cdsItens.FieldByName(Campo + IntToStr(i)) as TFloatField).DisplayFormat := '#,##0.00';
      (cdsItens.FieldByName(Campo + 'N' + IntToStr(i)) as TFloatField).DisplayFormat := '#,##0.00';
    End;
  End;

end;


procedure TfrmImportComisVendTabPreco.pInsereItensCDS(intLinha: integer);
  var
    recPrecos: TArrRecPrecos;
    i: integer;
begin
  cdsItens.Insert;
  try
    try
      If fLocalizaItenCDS(qryLocalizaItem, intLinha) Then
      Begin
        for i := 0 to qryLocalizaItem.Fields.Count -1 do
          cdsItens.FieldByName(qryLocalizaItem.Fields[i].FieldName).Value := qryLocalizaItem.Fields[i].Value;
        cdsItens.FieldByName('IMPORT').AsInteger := 1;
      End
      Else
      Begin
        cdsItens.FieldByName('IMPORT').AsInteger := 0;
        cdsItens.FieldByName('DESEXC').AsString := 'Produto não encontrado na Base de Dados.';
      End;

      cdsItens.FieldByName('COMTBN1').AsFloat := Excel.Range[cTab__1 + IntToStr(intLinha)].Value;
      cdsItens.FieldByName('COMTBN2').AsFloat := Excel.Range[cTab__2 + IntToStr(intLinha)].Value;
      cdsItens.FieldByName('COMTBN3').AsFloat := Excel.Range[cTab__3 + IntToStr(intLinha)].Value;
      cdsItens.FieldByName('COMTBN4').AsFloat := Excel.Range[cTab__4 + IntToStr(intLinha)].Value;
      cdsItens.FieldByName('COMTBN5').AsFloat := Excel.Range[cTab__5 + IntToStr(intLinha)].Value;
      cdsItens.FieldByName('COMTBN6').AsFloat := Excel.Range[cTab__6 + IntToStr(intLinha)].Value;
      cdsItens.FieldByName('COMTBN7').AsFloat := Excel.Range[cTab__7 + IntToStr(intLinha)].Value;

      recPrecos := fCalcularPrecos(cdsItens);

      //Novos Valores Para Margem e Preco Venda
      for i := 1 to 7 do
      Begin
        cdsItens.FieldByName('MARBRN' + IntToStr(i)).AsFloat := recPrecos[i].fltMarBru;
        cdsItens.FieldByName('PREVEN' + IntToStr(i)).AsFloat := recPrecos[i].fltPreVen;

        If not fValidaMargem(i, cdsItens, recPrecos) Then
        Begin
          If cdsItens.FieldByName('DESEXC').AsString <> '' Then
             cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + #$A#$D;
          cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + 'TABELA DE PREÇOS' +
                                                     IntToStr(i) + ': A SOMA DO "ICMS DE SAÍDA" + "IMPOSTOS FEDERAIS" + "DESPESAS OPERACIONAIS" + "MARGEM BRUTA" ' +
                                                     IIF(fCfgSis('PCMPRO') = '2', '+ COMISSÃO ', '') + ' NÃO PODEM SER SUPERIOR A 100%.';
          cdsItens.FieldByName('IMPORT').AsInteger := 2;
        end;
      End;

      If cdsItens.FieldByName('IMPORT').AsInteger = 0 Then
      Begin
        cdsItens.FieldByName('CODITE').AsString := Trim(Excel.Range[cCodIte + IntToStr(intLinha)].Value);
        cdsItens.FieldByName('CODFOR').AsString := Trim(Excel.Range[cCodFor + IntToStr(intLinha)].Value);
        cdsItens.FieldByName('CODBAR').AsString := Trim(Excel.Range[cCodBar + IntToStr(intLinha)].Value);
        cdsItens.FieldByName('CODFAB').AsString := Trim(Excel.Range[cCodFab + IntToStr(intLinha)].Value);
      end;
      cdsItens.Post;
    Except
      on E: Exception do
         pMensagensErro(E.Message, '[TfrmImportComisVendTabPreco.pInsereItensCDS]');
    End;
  Finally
  End
end;

procedure TfrmImportComisVendTabPreco.pLimparCDS;
begin
  cdsItens.First;
  while not cdsItens.Eof do
  Begin
    cdsItens.Delete;
  End;
end;

procedure TfrmImportComisVendTabPreco.pSetaParamentros(intLinha: Integer; qrySQL: TUniQuery);
var strValor: String;
begin
  with qrySql do
  Begin
    strValor := Trim(Excel.Range[cCodIte + IntToStr(intLinha)].Value);
    ParamByName('CODITE').AsString := Format('%0.'+IntToStr(fTamCodIte)+'d', [StrToInt(strValor)]);
    ParamByName('CODBAR').AsString := Trim(Excel.Range[cCodBar + IntToStr(intLinha)].Value);
    ParamByName('CODFOR').AsString := Trim(Excel.Range[cCodFor + IntToStr(intLinha)].Value);
    ParamByName('CODFAB').AsString := Trim(Excel.Range[cCodFab + IntToStr(intLinha)].Value);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
  End;
end;

function TfrmImportComisVendTabPreco.fRetPrecoCusto(fltPreCom,
                                               fltDesF01,
                                               fltDesF02,
                                               fltDesF03,
                                               fltDesF04,
                                               fltDesF05,
                                               fltDesF06,
                                               fltICMEnt,
                                               fltSubFed,
                                               fltIpiEnt,
                                               fltFreEnt,
                                               fltAcrFin,
                                               fltSubsti,
                                               fltDesAdb: Double;
                                               blnPreDol: Boolean;
                                               fltTCIFCu,
                                               fltTSCust,
                                               fltDePiCo,
                                               fltDeICMS,
                                               fltFatReg: Double): Double;
  Var
    cpcParams: TParCalculaPrecoCusto;
begin
  Try
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

    With cpcParams Do
    Begin
      curPreCom := fltPreCom;
      curDesF01 := fltDesF01;
      curDesF02 := fltDesF02;
      curDesF03 := fltDesF03;
      curDesF04 := fltDesF04;
      curDesF05 := fltDesF05;
      curDesF06 := fltDesF06;
      curICMSEnt:= fltICMEnt;
      curIPIEnt := fltIpiEnt;
      curFrete  := fltFreEnt;
      curAcrFin := fltAcrFin;
      curSubsti := fltSubsti;
      curDesAdb := fltDesAdb;
      curSubFed := fltSubFed;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCU := fltTCIFCu;
        curTSCust := fltTSCust;
        curDePiCo := fltDePiCo;
        curDeICMS := fltDeICMS;
        curFatReg := fltFatReg;
      end
      else
      begin
        curTCIFCU := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;
    End;

    Result := cpcParams.fCalculaPrecoCusto(blnPreDol);

  Finally
    FreeAndNil(cpcParams);
  End;

end;

function TfrmImportComisVendTabPreco.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If Trim(Excel.Range[cCodIte + IntToStr(1)].Value) <> '' Then
    result := not TryStrToInt(Trim(Excel.Range[cCodIte + IntToStr(1)].Value), intValDef)
  Else
    Result := False;
end;

function TfrmImportComisVendTabPreco.fValidaMargem(intTabPreco: Integer; cdsIte: TZClient; objPrecos: TArrRecPrecos): Boolean;
begin
  Result := cdsIte.FieldByName('IMPFED').AsFloat +
            cdsIte.FieldByName('DESOPE').AsFloat +
            cdsIte.FieldByName('ICMSAI').AsFloat +
            cdsIte.FieldByName('COMTBN' + intToStr(intTabPreco)).AsFloat +
            objPrecos[intTabPreco].fltMarBru <= 100;
end;

end.

