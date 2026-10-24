unit untBalancoEstoqueImportar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGridCitel, DBGrids, Mask, DirectoryEditFocus, FilenameEditFocus, strUtils,
  Uni, UniClientDataSet, frxClass, frxDesgn, frxExportRTF,
  frxExportXLS, frxExportHTML, frxExportPDF, frxDMPExport, frxDBSet,
  untCadLote, BitBtnLockedIncrem, untConDet, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, untFuncoesRel;

type
  TfrmBalancoEstoqueImportar = class(TfrmPai)
    pnlSaldo: TPanel;
    Label1: TLabel;
    Panel1: TPanel;
    chkImpRel: TCheckBox;
    memArqTxt: TMemo;
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxMatricial: TfrxDotMatrixExport;
    frxExpPDF: TfrxPDFExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpXLS: TfrxXLSExport;
    frxExpRTF: TfrxRTFExport;
    frxDesigner: TfrxDesigner;
    frxComandos: TfrxUserDataSet;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    btnConfirma: TBitBtnLocked;
    flnArqTxt: TFilenameEditFocus;
    procedure flnArqTxtExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure frxGenGetValue(const VarName: String; var Value: Variant);
    procedure memArqTxtKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    objCadLot: TCadLot;
    intConEst: Integer;
    procedure pAlimentaTmpTable(cdsNaoEnc: TUniClientDataSet);
  public
    { Public declarations }
  end;

var
  frmBalancoEstoqueImportar: TfrmBalancoEstoqueImportar;

implementation

uses  untFuncoesSimples, DB,  untCfgRel, untConsultas, untTypesSistema,
  untHistoricoBalanco;

{$R *.dfm}

procedure TfrmBalancoEstoqueImportar.flnArqTxtExit(Sender: TObject);
begin
  inherited;

 {******************************************************************}
 {* VERIFICA SE O ARQUIVO INFORMADO EXISTE, CASO SIM CARREGA       *}
 {* O MESMO NO MEMO (VISUALIZACAO SE E' O VERDADEIRO ARQUIVO)      *}
 {***************************************************************JC*}
  flnArqTxt.Text := AnsiReplaceStr(flnArqTxt.Text,'"','');

  If Not FileExists(flnArqTxt.Text) Then
  Begin
    fMensagem('', 'O arquivo informado não existe !',['&O K']);
    memArqTxt.Clear;
    Exit;
  End
  Else
    memArqTxt.Lines.LoadFromFile(flnArqTxt.Text);

end;

procedure TfrmBalancoEstoqueImportar.btnConfirmaClick(Sender: TObject);
  Var
    intCTLEST,
    intNumAmz,
    intLinha : Integer;
    strLinha : String;
    strNumLot: String;
    strCodBar: String;
    strQtdCon: String;
    strCodIte: String;
    blnCodIte: Boolean;
    intModCol: Integer;
    strNomFil: String;
    strTipImp: String;
    stlArqTxt: TStringList;
    qryGenGer: TUniQuery;
    qryItems : TUniQuery;
    cdsRelCon: TUniClientDataSet;
    cdsNaoEnc: TUniClientDataSet; //Relatorio de Itens não encontrados.
    frxRel   : TfrxReport;
    fltEmbala: Double;
    qryCadAmz: TUniQuery;
    chrKey   : Char;
    strCodAmz: String;
    arrKey   : TConsultasArray;

   {******************************************************************}
   {* FUNCAO QUE RETORNA O CODIGO DO ITEM PELO SEU CODIGO DE BARRAS  *}
   {***************************************************************JC*}
    function fRetCodIte(strCodBarras : String; Var fltEmbala: Double): String;
    begin
      fltEmbala := 1;
      qryGenGer := fCriaQuery(Nil);

      With qryGenGer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT BAR_CODITE, IFNULL(BAR_EMBALA, 1) AS BAR_EMBALA FROM ITEBAR WHERE BAR_CODBAR = :CODBAR');
        ParamByName('CODBAR').AsString := strCodBarras;
        Open;

        If Not IsEmpty Then
        Begin
          Result    := FieldByName('BAR_CODITE').AsString;
          fltEmbala := FieldByName('BAR_EMBALA').AsFloat;
        End
        Else
          Result := '';

      End;

      FreeAndNil(qryGenGer);

      If fltEmbala < 1 Then
        fltEmbala := 1;
    end;

   {******************************************************************}
   {* FUNCAO QUE RETORNA V OU F NO TESTE SE EXISTE O COD DO ITEM     *}
   {***************************************************************IV*}
    function fExisteCodIte(strCodItem : String): Boolean;
    begin
      qryGenGer := fCriaQuery(Nil);

      With qryGenGer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE ');
        ParamByName('CODITE').AsString := strCodItem;
        Open;

        If Not IsEmpty Then
          Result := True
        Else
          Result := False;

      End;

      FreeAndNil(qryGenGer);

    end;

   {************************************************************}
   {* FUNCAO QUE ATUALIZA O SALDO DE CONTAGEM (ACUMULATIVO)    *}
   {*********************************************************JC*}
    function fAtualizaSalCon(strItem, strCodBar, strNumLot : String; fltContagem : Double) : Boolean;
    begin
      Result := False;

      If fEmptyStr(strItem) Then
        Exit;

      With qryGenGer Do
      Try
        If fEmptyStr(strNumLot) Then
        Begin
          If objCadLot.fExisteLote(strItem, VS_strCodEmp) Then
          Begin
            cdsNaoEnc.Append;

            cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
            cdsNaoEnc.FieldByName('NUMLOT').AsString := strNumLot;
            cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon);
            cdsNaoEnc.FieldByName('OBSERV').AsString := objCadLot.strTitLab +
               ' EM BRANCO - ESSE ITEM POSSUI ' + objCadLot.strTitLbs;
            cdsNaoEnc.Post;

            Result := False;
            Exit;
          End;
        End Else
        Begin
          If Not objCadLot.fExisteLote(strItem, VS_strCodEmp, strNumLot) Then
          Begin
            If cdsNaoEnc.Locate('CODBAR;NUMLOT', VarArrayOf( [strCodBar, strNumLot] ), []) Then
              cdsNaoEnc.Edit
            Else
              cdsNaoEnc.Append;

            cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
            cdsNaoEnc.FieldByName('NUMLOT').AsString := strNumLot;
            cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon);
            cdsNaoEnc.FieldByName('OBSERV').AsString := objCadLot.strTitLab + ' NAO ENCONTRADO';
            cdsNaoEnc.Post;

            Result := False;
            Exit;
          End;
        End;

        qryGenGer := fCriaQuery(Nil);

        fStartTransaction;

        TConDet.fGravaConDet(fCfgSis('CONACU', varBoolean), Self, strItem, VS_strCodEmp, '', 'S', '', fltContagem, 0, (intConEst = 1), True );

        Close;
        SQL.Clear;
        SQL.Add(' UPDATE ');
        SQL.Add('   ITEGER ');
        SQL.Add(' SET ');

        If intConEst = 1 Then
        Begin
          SQL.Add('   ITE_SALCON = IFNULL(ITE_SALCON,0) + :SALCON, '); //ACUMULA A QUANTIDADE
        End Else
        Begin
          SQL.Add('   ITE_SALCON = :SALCON, ');
          SQL.Add('   ITE_DIFSAL = :SALCON - IFNULL(ITE_SALDOS, 0), ');
        End;

        SQL.Add('   ITE_GMLCON = 0,   ');
        SQL.Add('   ITE_DIGCON = "S", ');
        SQL.Add('   ITE_ORDCON = :ORDCON');

        SQL.Add(' WHERE ');
        SQL.Add('   ITE_CODITE =:CODITE AND ');
        SQL.Add('   ITE_CODEMP =:CODEMP ');

        ParamByName('SALCON').AsFloat  := fltContagem;
        ParamByName('CODITE').AsString := strItem;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('ORDCON').AsInteger:= objCadLot.fRetOrdemItem;

        ExecSQL;


        Result := fGravaLogContEst(strLoginUsuarioLogado, strItem, '', fltContagem, 0);

       THistoricoBalanco.pIncluiHistorico(VS_strCodEmp, strItem, '', strLoginUsuarioLogado, '', fltContagem, 0);

        If Result Then
        Begin

          If Not fEmptyStr(strNumLot) Then
          Begin

            If objCadLot.fSalvaContagemLote('', strItem, strNumLot, strLoginUsuarioLogado, '', fltContagem, 0, objCadLot.fRetOrdemItem) Then
              fCommit
            Else Begin
              Result := False;
              fRollBack;
            End;

          End
          Else
            fCommit;

        End;

      Except
        On E: Exception Do
        Begin
          fRollBack;
          Result := False;
          pMensagensErro('', E.Message + ' [ fAtualizaSalCon ]');
        End;
      End;

      FreeAndNil(qryGenGer);

    end;

    Procedure pAtualizaSalCon;
    Begin
      {******************************************************************}
      {* ATUALIZA O SALDO DE CONTAGEM (ITEGER -> ITE_SALCON) E CASO     *}
      {* CHKBOX IMPRESSAO ESTEJA MARCADO CARREGA DADOS DOS ITENS        *}
      {* PROCESSADOS NO CLIENTDATASET (RELATORIO)                       *}
      {***************************************************************JC*}
      If fAtualizaSalCon(strCodIte, strCodBar, strNumLot,
                         fStrToFloat(strQtdCon)) And chkImpRel.Checked Then
      Begin

        With cdsRelCon Do
        Begin

          qryItems.Close;
          qryItems.ParamByName('CODITE').AsString := strCodIte;
          qryItems.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryItems.Open;

          Insert;
          FieldByName('CODITE').AsString := strCodIte;
          FieldByName('CODBAR').AsString := qryItems.FieldByName('CODBAR').AsString;
          FieldByName('NUMLOT').AsString := strNumLot;
          FieldByName('DESCRI').AsString := qryItems.FieldByName('DESCRI').AsString;
          FieldByName('REFERE').AsString := qryItems.FieldByName('REFERE').AsString;
          FieldByName('UNIDAD').AsString := fRetSiglaUnidade(qryItems.FieldByName('CODUNI').AsString);
          FieldByName('LOCFIS').AsString := qryItems.FieldByName('LOCFIS').AsString;
          FieldByName('QTDCON').AsFloat  := fStrToFloat(strQtdCon);
          Post;
        End;
      End;
    End;

    Procedure pModelo1;
    Begin
      strLinha  := Trim(stlArqTxt[intLinha]);
      strCodBar := Copy(strLinha, 1, 13);
     {**************************************************************************************************}
     {* USADO PARA EVITAR QUE O SISTEMA PARE DURANTE A CONVERSÃO CASO ITEM NÃO POSSUA COD. BARRAS      *}
     {* GERA ERRO NA CONVERSÃO DE fStrToFloat                                                           *}
     {**********************************************************************************************JC**}
      Try
        strQtdCon := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 14, 5)));
      Except
        strQtdCon := '0,00';
      End;

      strNumLot := Trim(Copy(strLinha, 19, 20));

      strCodIte := fRetCodIte(strCodBar, fltEmbala);
      strQtdCon := FormatFloat('##0.00', fStrToFloat(strQtdCon) * fltEmbala);

      If fEmptyStr(strCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODBAR', strCodBar, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
        cdsNaoEnc.FieldByName('NUMLOT').AsString := strNumLot;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;

      End

      Else pAtualizaSalCon;
      
    End;

    Procedure pModelo2;
    Begin
      strLinha  := Trim(stlArqTxt[intLinha]);
      strCodIte := Copy(strLinha, 1, fTamCodIte);
      Try
        strQtdCon := FormatFloat('##0.00', fStrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 6, (Length(strLinha) - fTamCodIte) ) ) );
      Except
        strQtdCon := '0,00';
      End;

      blnCodIte := fExisteCodIte(strCodIte);

      If fEmptyStr(strCodIte) Or (Not blnCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODBAR', strCodBar, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODITE').AsString := strCodIte;
        cdsNaoEnc.FieldByName('NUMLOT').AsString := strNumLot;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;

      End

      Else pAtualizaSalCon;

    End;

    Procedure pModelo3;
    Begin
      strLinha  := Trim(stlArqTxt[intLinha]);
      strCodBar := Copy(strLinha, 1, 13);
     {**************************************************************************************************}
     {* USADO PARA EVITAR QUE O SISTEMA PARE DURANTE A CONVERSÃO CASO ITEM NÃO POSSUA COD. BARRAS      *}
     {* GERA ERRO NA CONVERSÃO DE (S)TRTOFLOAT                                                           *}
     {**********************************************************************************************JC**}
      Try
        strQtdCon := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 15, Length(strLinha))));
      Except
        strQtdCon := '0,00';
      End;

      strCodIte := fRetCodIte(strCodBar, fltEmbala);
      strQtdCon := FormatFloat('##0.00', fStrToFloat(strQtdCon) * fltEmbala);

      If fEmptyStr(strCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODBAR', strCodBar, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;

      End

      Else pAtualizaSalCon;

    End;

    Procedure pModelo4;
    Begin
      strLinha  := stlArqTxt[intLinha];
      strCodIte := Copy(strLinha, 2, fTamCodIte);
     {**************************************************************************************************}
     {* USADO PARA EVITAR QUE O SISTEMA PARE DURANTE A CONVERSÃO CASO ITEM NÃO POSSUA COD. BARRAS      *}
     {* GERA ERRO NA CONVERSÃO DE fStrToFloat                                                           *}
     {**********************************************************************************************JC**}
      Try
        strQtdCon := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 7, 6)));
      Except
        strQtdCon := '0,00';
      End;

      blnCodIte := fExisteCodIte(strCodIte);

      If fEmptyStr(strCodIte) Or (Not blnCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODITE', strCodIte, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODITE').AsString := strCodIte;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;

      End

      Else pAtualizaSalCon;

    End;

    Procedure pModelo5;
    Begin
      strLinha  := TrimRight(stlArqTxt[intLinha]);
      strCodBar := Copy(strLinha, 11, 13);
     {**************************************************************************************************}
     {* USADO PARA EVITAR QUE O SISTEMA PARE DURANTE A CONVERSÃO CASO ITEM NÃO POSSUA COD. BARRAS      *}
     {* GERA ERRO NA CONVERSÃO DE fStrToFloat                                                           *}
     {**********************************************************************************************JC**}
      Try
        strQtdCon := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 44, 5)));
      Except
        strQtdCon := '0,00';
      End;

      strCodIte := fRetCodIte(strCodBar, fltEmbala);
      strQtdCon := FormatFloat('##0.00', fStrToFloat(strQtdCon) * fltEmbala);

      If fEmptyStr(strCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODBAR', strCodBar, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
        cdsNaoEnc.FieldByName('NUMLOT').AsString := strNumLot;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;
      End

      Else
        pAtualizaSalCon;

    End;

    Procedure pModelo6;
    Begin
      strLinha  := Trim(stlArqTxt[intLinha]);
      If (Length(strLinha) < 13) Then
        Exit;
      strCodBar := Copy(strLinha, 01, 13);
      Try
        strQtdCon := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 17, 6)));
      Except
        strQtdCon := '0,00';
      End;

      strCodIte := fRetCodIte(strCodBar, fltEmbala);
      strQtdCon := FormatFloat('##0.00', fStrToFloat(strQtdCon) * fltEmbala);

      If fEmptyStr(strCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODBAR', strCodBar, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
        cdsNaoEnc.FieldByName('NUMLOT').AsString := strNumLot;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;
      End
      Else
        pAtualizaSalCon;
    End;

    Procedure pModelo7;
      Var
        intposVir: Integer;
    Begin
      strLinha  := Trim(stlArqTxt[intLinha]);

      intposVir := Pos(',', strLinha);

      If intposVir = 0 Then
      Begin

        If cdsNaoEnc.Locate('CODBAR', strLinha, []) Then
           cdsNaoEnc.Edit
         Else
           cdsNaoEnc.Append;

         cdsNaoEnc.FieldByName('CODBAR').AsString := strLinha;
         cdsNaoEnc.FieldByName('NUMLOT').AsString := '';
         cdsNaoEnc.FieldByName('QTDITE').AsFloat  := 0;
         cdsNaoEnc.FieldByName('OBSERV').AsString := 'REGISTRO SEM VIRGULA';
         cdsNaoEnc.Post;

      End Else
      Begin
        strCodBar := Copy(strLinha, 01, Pred(intposVir));

        delete(strLinha, 1, intposVir);

        Try
          strQtdCon := FormatFloat('##0.00', fstrToFloat(AnsiReplaceStr(strLinha, '.', ',')));
        Except
          strQtdCon := '0,00';
        End;

        strCodIte := fRetCodIte(strCodBar, fltEmbala);
        strQtdCon := FormatFloat('##0.00', fStrToFloat(strQtdCon) * fltEmbala);

        If fEmptyStr(strCodIte) Then
        Begin

          If cdsNaoEnc.Locate('CODBAR', strCodBar, []) Then
            cdsNaoEnc.Edit
          Else
            cdsNaoEnc.Append;

          cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
          cdsNaoEnc.FieldByName('NUMLOT').AsString := strNumLot;
          cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
          cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
          cdsNaoEnc.Post;
          
        End

        Else
          pAtualizaSalCon;

      End;

    End;

    Procedure pModelo8;
    Begin
      strLinha  := Trim(stlArqTxt[intLinha]);
      strCodBar := Copy(strLinha, 1, 13);
     {**************************************************************************************************}
     {* USADO PARA EVITAR QUE O SISTEMA PARE DURANTE A CONVERSÃO CASO ITEM NÃO POSSUA COD. BARRAS      *}
     {* GERA ERRO NA CONVERSÃO DE fStrToFloat                                                           *}
     {**********************************************************************************************JC**}
      Try
        strQtdCon := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 15, 6)));
      Except
        strQtdCon := '0,00';
      End;

      strCodIte := fRetCodIte(strCodBar, fltEmbala);
      strQtdCon := FormatFloat('##0.00', fStrToFloat(strQtdCon) * fltEmbala);

      If fEmptyStr(strCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODBAR', strCodBar, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) +
                                                    cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;

      End

      Else pAtualizaSalCon;

    End;

    Procedure pModelo9;
      Var
        strIteLid: String;
    Begin
      strLinha  := TrimRight(stlArqTxt[intLinha]);
      strIteLid := Copy(strLinha, 92, fTamCodIte);

      Try
        strQtdCon := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 15, 5)));
      Except
        strQtdCon := '0,00';
      End;

      strCodIte := fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'], [strIteLid]);

      If fEmptyStr(strCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODITE', strIteLid, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODITE').AsString := strIteLid;
        cdsNaoEnc.FieldByName('NUMLOT').AsString := strNumLot;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;
      End
      Else
        pAtualizaSalCon;
    End;

    Procedure pModelo10;
    Begin

      strLinha  := TrimRight(stlArqTxt[intLinha]);
      strCodBar := Trim(Copy(strLinha, 19, 14));
      Try
        strQtdCon := FormatFloat('##0.00', fstrToFloat(Trim(Copy(AnsiReplaceStr(strLinha, '.', ','), 33, 9))));
      Except
        strQtdCon := '0,00';
      End;

      If (Length(Trim(strCodBar)) > 5) Then
      Begin

        strCodIte := fRetCodIte(strCodBar, fltEmbala);
        strQtdCon := FormatFloat('##0.00', fStrToFloat(strQtdCon) * fltEmbala);

        If fEmptyStr(strCodIte) Then
        Begin

          If cdsNaoEnc.Locate('CODBAR', strCodBar, []) Then
            cdsNaoEnc.Edit
          Else
            cdsNaoEnc.Append;

          cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
          cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
          cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
          cdsNaoEnc.Post;

        End
        Else
          pAtualizaSalCon;

      End
      Else
      Begin
        strCodIte := strCodBar;
        blnCodIte := fExisteCodIte(strCodIte);

        If fEmptyStr(strCodIte) Or (Not blnCodIte) Then
        Begin

          If cdsNaoEnc.Locate('CODITE', strCodIte, []) Then
            cdsNaoEnc.Edit
          Else
            cdsNaoEnc.Append;

          cdsNaoEnc.FieldByName('CODITE').AsString := strCodIte;
          cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
          cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
          cdsNaoEnc.Post;

        End
        Else

          pAtualizaSalCon;
      End;

    End;

    Procedure pModelo11;
    Begin
      strLinha  := Trim(stlArqTxt[intLinha]);
      strCodBar := Trim(Copy(strLinha, 1, 15));
     {**************************************************************************************************}
     {* USADO PARA EVITAR QUE O SISTEMA PARE DURANTE A CONVERSÃO CASO ITEM NÃO POSSUA COD. BARRAS      *}
     {* GERA ERRO NA CONVERSÃO DE fStrToFloat                                                           *}
     {**********************************************************************************************JC**}
      Try
        strQtdCon := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 16, 11)));
      Except
        strQtdCon := '0,00';
      End;

      strCodIte := fRetCodIte(strCodBar, fltEmbala);

      If fEmptyStr(strCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODBAR', strCodBar, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;

      End

      Else pAtualizaSalCon;

    End;

    Procedure pModelo12;
      Var
        intPosPv : Integer;
    Begin
      strLinha  := Trim(stlArqTxt[intLinha]);
      intPosPv := Pos(';', strLinha);
      If intPosPv <= 0 Then
      Begin

        cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODBAR').AsString := strLinha;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := 0;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'LINHA FORA DO FORMATO ESPERADO!';
        cdsNaoEnc.Post;

        Exit;
      End;

      strCodBar := Copy(strLinha, 1, intPosPv -1);
     {**************************************************************************************************}
     {* USADO PARA EVITAR QUE O SISTEMA PARE DURANTE A CONVERSÃO CASO ITEM NÃO POSSUA COD. BARRAS      *}
     {* GERA ERRO NA CONVERSÃO DE fStrToFloat                                                           *}
     {**********************************************************************************************JC**}
      Try
        strQtdCon := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), intPosPv +1, Length(strLinha))));
      Except
        strQtdCon := '0,00';
      End;

      strCodIte := fRetCodIte(strCodBar, fltEmbala);
      strQtdCon := FormatFloat('##0.00', fStrToFloat(strQtdCon) * fltEmbala);

      If fEmptyStr(strCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODBAR', strCodBar, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) +
                                                    cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;

      End

      Else pAtualizaSalCon;

    End;

    Procedure pModelo13;
    Begin
      strLinha  := Trim(stlArqTxt[intLinha]);
      strCodBar := Trim(Copy(strLinha, 1, 13));

      Try
        strQtdCon := FormatFloat('##0.00', fValNumForm(Copy(strLinha, 85, 09), 09, 03));
      Except
        strQtdCon := '0,00';
      End;

      strCodIte := fRetCodIte(strCodBar, fltEmbala);

      If fEmptyStr(strCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODBAR', strCodBar, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODBAR').AsString := strCodBar;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;

      End

      Else pAtualizaSalCon;
    End;

    Procedure pModelo15;
    Begin
      strLinha  := Trim(stlArqTxt[intLinha]);
      strCodIte := Copy(strLinha, 1, fTamCodIte);
      Try
        strQtdCon := FormatFloat('##0.00', fStrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), fTamCodIte + 1, 5 ) ) );
      Except
        strQtdCon := '0,00';
      End;

      strNumLot := Trim(Copy(strLinha, fTamCodIte + 1 + 5, 10));

      blnCodIte := fExisteCodIte(strCodIte);

      If fEmptyStr(strCodIte) Or (Not blnCodIte) Then
      Begin

        If cdsNaoEnc.Locate('CODITE', strCodIte, []) Then
          cdsNaoEnc.Edit
        Else
          cdsNaoEnc.Append;

        cdsNaoEnc.FieldByName('CODITE').AsString := strCodIte;
        cdsNaoEnc.FieldByName('NUMLOT').AsString := strNumLot;
        cdsNaoEnc.FieldByName('QTDITE').AsFloat  := fStrToFloat(strQtdCon) + cdsNaoEnc.FieldByName('QTDITE').AsFloat;
        cdsNaoEnc.FieldByName('OBSERV').AsString := 'ITEM NAO ENCONTRADO';
        cdsNaoEnc.Post;

      End

      Else pAtualizaSalCon;

    End;

begin
  inherited;

  intCTLEST := fCfgSis('CTLEST', varInteger);

  {****************************************************************************}
  {* CASO O MEMO POSSUA REGISTROS PEDE CONFIRMACAO E CONTINUA, SENAO ENCERRA  *}
  {*************************************************************************JC*}
  If memArqTxt.Lines.Count > 0 Then
  Begin
    intModCol := fCfgSis('MODCOL', varInteger);

    If fMensagem('', 'Confirma dados para importação de contagem ? ',['&S I M','&N Ã O']) = 2 Then
      Exit;

    cdsNaoEnc := TUniClientDataSet.Create(Self);
    With cdsNaoEnc.FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODBAR';
      DataType := ftString;
      Size := 15;
    End;

    With cdsNaoEnc.FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODITE';
      DataType := ftString;
      Size := fTamCodIte;
    End;

    With cdsNaoEnc.FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDITE';
      DataType := ftFloat;
    End;

    
    With cdsNaoEnc.FieldDefs.AddFieldDef Do
    Begin
      Name := 'NUMLOT';
      DataType := ftString;
      Size := VS_Size_NumLot;
    End;
    

    With cdsNaoEnc.FieldDefs.AddFieldDef Do
    Begin
      Name := 'OBSERV';
      DataType := ftString;
      Size := 100;
    End;

    cdsNaoEnc.CreateDataSet;
    cdsNaoEnc.Open;

    {******************************************************************}
    {* CASO CHKBOX DE IMPRESSAO ESTEJA MARCADO CRIA CLIENTDATASET     *}
    {* QUE IRA CARREGAR OS ITENS PROCESSADOS NO RELATORIO, BEM COMO   *}
    {* CRIA QUERY QUE BUSCA INFORMACOES ADICIONAIS DOS ITENS          *}
    {***************************************************************JC*}
    If chkImpRel.Checked Then
    Begin

      cdsRelCon := TUniClientDataSet.Create(Self);

      With cdsRelCon.FieldDefs.AddFieldDef Do
      Begin
        Name := 'CODITE';
        DataType := ftString;
        Size := fTamCodIte;
      End;

      With cdsRelCon.FieldDefs.AddFieldDef Do
      Begin
        Name := 'CODBAR';
        DataType := ftString;
        Size := 15;
      End;

      With cdsRelCon.FieldDefs.AddFieldDef Do
      Begin
        Name := 'DESCRI';
        DataType := ftString;
        Size := 50;
      End;

      With cdsRelCon.FieldDefs.AddFieldDef Do
      Begin
        Name := 'REFERE';
        DataType := ftString;
        Size := 16;
      End;

      With cdsRelCon.FieldDefs.AddFieldDef Do
      Begin
        Name := 'UNIDAD';
        DataType := ftString;
        Size := 4;
      End;

      With cdsRelCon.FieldDefs.AddFieldDef Do
      Begin
        Name := 'LOCFIS';
        DataType := ftString;
        Size := 10;
      End;

      With cdsRelCon.FieldDefs.AddFieldDef Do
      Begin
        Name := 'QTDCON';
        DataType  := ftFloat;
        Precision := 2;
      End;

      With cdsRelCon.FieldDefs.AddFieldDef Do
      Begin
        Name := 'NUMLOT';
        DataType := ftString;
        Size := VS_Size_NumLot;
      End;

      cdsRelCon.CreateDataSet;
      cdsRelCon.Open;

      qryItems := fCriaQuery(Nil);

      With qryItems Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT ');
        SQL.Add('   I.ITE_DESITE AS DESCRI, ');
        SQL.Add('   I.ITE_REFERE AS REFERE, ');
        SQL.Add('   I.ITE_CODBAR AS CODBAR, ');
        SQL.Add('   I.ITE_CODUNI AS CODUNI, ');
        SQL.Add('   G.ITE_LOCFIS AS LOCFIS ');
        SQL.Add(' FROM ');
        SQL.Add('   CADITE I, ');
        SQL.Add('   ITEGER G  ');
        SQL.Add(' WHERE ');
        SQL.Add('   G.ITE_CODITE =:CODITE AND  ');
        SQL.Add('   G.ITE_CODEMP =:CODEMP AND  ');
        SQL.Add('   G.ITE_CODITE= I.ITE_CODITE ');

      End;

    End;

    If (intCTLEST = 2) And (intModCol In [3, 7]) Then
    Begin
      If (Not TCadLot.fTemContagemArmazem(strCodAmz, intNumAmz)) Or (intNumAmz > 1) Then
      Begin

        fMensagem('','Será necessário informar o armazem da contagem!', ['&OK']);
        qryCadAmz := fCriaQuery(Self);
        Try
          chrKey := '/';
          If fPesqArmazem(Self, Nil, Nil, qryCadAmz, chrKey, arrKey, True, TCadLot.fRetLotesContagemAberta) then
            strCodAmz := qryCadAmz.FieldByName('AMZ_CODAMZ').AsString
          Else
          Begin
            fMensagem('','É obrigatório a escolha de um armazem!', ['&Ok']);
            Exit;
          End;
        Finally
          FreeAndNil(qryCadAmz);
        End;

      End;
    End;
    memArqTxt.Clear;
    memArqTxt.Lines.Add('AGUARDE PROCESSANDO ARQUIVO...');

    Self.Enabled := False;

    {******************************************************************}
    {* CRIA E CARREGA O ARQUIVO EM UMA STRINGLIST E INICIA O PROCESSO *}
    {***************************************************************JC*}
    stlArqTxt := TStringList.Create;

    stlArqTxt.LoadFromFile(flnArqTxt.Text);

    For intLinha := 0 To stlArqTxt.Count - 1 Do
    Begin
      strCodBar := '';
      strNumLot := '';
      strCodIte := '';

      If (intCTLEST = 2) And (intModCol In [3, 7]) Then
        strNumLot := strCodAmz;

      Case intModCol Of
        1: pModelo1;
        2: pModelo2;
        3: pModelo3;
        4: pModelo4;
        5: pModelo5;
        6: pModelo6;
        7: pModelo7;
        8: pModelo8;
        9: pModelo9;
       10: pModelo10;
       11: pModelo11;
       12: pModelo12;
       13: pModelo13;
       15: pModelo15;
      End;

      pnlInfo.Caption := 'Registros: ' + IntToStr(intLinha + 1) + '/' + IntToStr(stlArqTxt.Count);
      Application.ProcessMessages;

    End;

    fMensagem('','Processo Concluído !', ['&O K']);

    {******************************************************************}
    {* RENOMEIA O ARQUIVO TROCANDO A EXTENSAO DO MESMO PARA *.OLD     *}
    {* FORMA DE MARCAR QUE O ARQUIVO JA FOI UTILIZADO...              *}
    {***************************************************************JC*}
    RenameFile(flnArqTxt.Text, Copy(flnArqTxt.Text, 0, length(flnArqTxt.Text) - 3) + 'OLD');

    {*****************************************}
    {* MOSTRA RELATORIO DE ITENS NÃO ENCON-  *}
    {* TRADOS.                               *}
    {**************************************MV*}
    If (cdsNaoEnc.RecordCount > 0) Then
    Begin

      fMensagem('ATENÇÃO!', 'Foram encontradas inconsistências. Prepare a impressora.', ['&Ok']);

      pCarregaConfImpr(qryCfgRel, Self.Name);
      fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

      pAlimentaTmpTable(cdsNaoEnc);

      If strTipImp = 'M' Then
      Begin
        if Assigned(prcExecutaRelatorio) then
          prcExecutaRelatorio(335, 13287, [], [], [], Sender, Nil, True);
      End
      Else
      Begin
        if Assigned(prcExecutaRelatorio) then
          prcExecutaRelatorio(334, 13286, [], [], [], Sender, Nil, True);
      End;

    End;

    {***********************************************************************}
    {* CASO CHKBOX IMPRESSAO ESTEJA MARCADO CARREGA CARREGA CONFIGURACOES  *}
    {* DE IMPRESSAO DO FORM, ATRIBUI DADOS DO CLIENT AO RELATORIO E MOSTRA *}
    {* O MESMO NE TELA, LOGO APOS DESTROI CLIENT E QUERY UTILIZADAS        *}
    {********************************************************************JC*}
    If chkImpRel.Checked Then
    Begin

      pCarregaConfImpr(qryCfgRel, Self.Name);
      fPreImpressao(qryCfgRel, strNomFil,strTipImp,False);

      If strTipImp = 'M' Then
        frxRel := frxReportM
      Else
      Begin
        frxRel := frxReportJ;
        frxRel.DotMatrixReport           := False;
        frxRel.PrintOptions.PrintMode    := pmScale;
        frxRel.PrintOptions.PrintOnSheet := 9; //A4
      End;

      frxRelatorio.DataSet := cdsRelCon;

      pPreviewReport(Self.Name, Self.Caption, frxRel);

      FreeAndNil(cdsRelCon);
      FreeAndNil(qryItems);
    End;

    FreeAndNil(stlArqTxt);

    btnSair.Click;

  End
  Else
    fMensagem('', 'Nenhum arquivo foi carregado ! ', ['&O K']);

end;

procedure TfrmBalancoEstoqueImportar.pAlimentaTmpTable(cdsNaoEnc: TUniClientDataSet);
var
  qryTmpQuery: TUniQuery;
begin

  qryTmpQuery := fCriaQuery;

  qryTmpQuery.SQL.Clear;
  qryTmpQuery.SQL.Add('CALL pCriaTabelaTmpFixa("TMP_BALEST", "TMP_CODOPE VARCHAR(3),+TMP_CODITE VARCHAR(7),+TMP_CODBAR VARCHAR(20),+TMP_QTDITE NUMERIC(10,2),+TMP_NUMLOT VARCHAR(20),+TMP_OBSERV VARCHAR(100)+");');
  qryTmpQuery.SQL.Add('DELETE FROM TMP_BALEST WHERE TMP_CODOPE = ' + QuotedStr(strLoginUsuarioLogado) + ';');
  qryTmpQuery.ExecSQL;

  cdsNaoEnc.First;
  while not cdsNaoEnc.Eof do
  begin
    qryTmpQuery.SQL.Clear;
    qryTmpQuery.SQL.Add('INSERT INTO TMP_BALEST (TMP_CODOPE, TMP_CODITE, TMP_CODBAR, TMP_QTDITE, TMP_NUMLOT, TMP_OBSERV) VALUES (:CODOPE, :CODITE, :CODBAR, :QTDITE, :NUMLOT, :OBSERV);');
    qryTmpQuery.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryTmpQuery.ParamByName('CODITE').AsString := cdsNaoEnc.FieldByName('CODITE').AsString;
    qryTmpQuery.ParamByName('CODBAR').AsString := cdsNaoEnc.FieldByName('CODBAR').AsString;
    qryTmpQuery.ParamByName('QTDITE').AsFloat  := cdsNaoEnc.FieldByName('QTDITE').AsFloat;
    qryTmpQuery.ParamByName('NUMLOT').AsString := cdsNaoEnc.FieldByName('NUMLOT').AsString;
    qryTmpQuery.ParamByName('OBSERV').AsString := cdsNaoEnc.FieldByName('OBSERV').AsString;
    qryTmpQuery.ExecSQL;
    cdsNaoEnc.Next;
  end;

  FreeAndNil(qryTmpQuery);

end;

{*******************************************************}
{* CARREGA NOME EMPRESA E NOME DO FORM NO RELATORIO    *}
{****************************************************JC*}
procedure TfrmBalancoEstoqueImportar.frxGenGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  If VarName = 'EMP_NOMEMP' Then
    Value := fRetNomeEmpresa(VS_strCodEmp)

  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name;
end;

procedure TfrmBalancoEstoqueImportar.memArqTxtKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = #13 Then
    Self.SelectNext(ActiveControl, True, True);
    
end;

procedure TfrmBalancoEstoqueImportar.FormCreate(Sender: TObject);
begin
  inherited;

  objCadLot := TCadLot.Create(Self);

  flnArqTxt.Dialog.Dialog.Filter := 'Aquivos de Texto (*.txt)|*.Txt|Todos Arquivos (*.*)|*.*';
end;

procedure TfrmBalancoEstoqueImportar.FormShow(Sender: TObject);
begin
  inherited;

  intConEst := fCfgSis('CONEST');
  
end;


end.

