unit untImportarPlanilhaLocFisica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls,
  Vcl.Mask, MaskEditFocus, cxProgressBar, cxTextEdit, cxMaskEdit, cxButtonEdit,
  System.Generics.Collections, FilenameEditFocus, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, StrUtils, Data.DB, Uni, UniClientDataSet,
  untTValidaExcel, untConfirmaImportacaoLocFisica;

type
  TfrmImportarPlanilhaLocFisica = class(TfrmPai)
    pnlfundo: TPanel;
    lblPathArquivo: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    btnGravar: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    frxHelpSemWms: TfrxReport;
    frxHelpComWms: TfrxReport;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
    blnUsaWms, blnTemInconsist : Boolean;
    strCodLoc, strImport, strMotivo : String;

    objValidaExcel: TValidadorExcel;

    Procedure pCriaDataSet;
    procedure pProcessaPlanilha;
    procedure pInsereLocaisCDS(AContador : Integer);
    procedure pValidaLocais;
    function fVerificaChavePrimaria : Boolean;
    function fExisteLocalSeparacao(AValue : String) : Boolean;
    function fExisteArmazem(AValue : String) : Boolean;
    function fValidaPickingLaboratorioItemBase(out strMensagem: String): Boolean;
    procedure pExibeTela;
    procedure pExibeHelp(ACompFrx : TfrxReport);
  public
    { Public declarations }
    blnUsaMascaraCodigo : Boolean;

    cdsLocFis : TUniClientDataSet;
  end;

var
  frmImportarPlanilhaLocFisica: TfrmImportarPlanilhaLocFisica;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

function TfrmImportarPlanilhaLocFisica.fVerificaChavePrimaria : Boolean;
Var
  qryCadLoc : TUniQuery;
Begin
  qryCadLoc := fCriaQuery;
  Try
    With qryCadLoc, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT COUNT(0) AS QTD      ');
      Add(' FROM CADLOC                 ');
      Add(' WHERE LOC_CODEMP = :CODEMP  ');
      Add('   AND LOC_CODLOC = :CODLOC  ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODLOC').AsString := strCodLoc;
      Open;

      Result := FieldByName('QTD').AsInteger = 0;

      Close;
    End;

  Finally
    FreeAndNil(qryCadLoc);
  End;
End;

procedure TfrmImportarPlanilhaLocFisica.pExibeHelp(ACompFrx : TfrxReport);
Begin
  ACompFrx.DotMatrixReport           := False;
  ACompFrx.PrintOptions.PrintMode    := pmScale;
  ACompFrx.PrintOptions.PrintOnSheet := 9;

  pPreviewReport(Self.Name, Self.Caption + ' (Help)', ACompFrx);
End;

procedure TfrmImportarPlanilhaLocFisica.btnHlpImpClick(Sender: TObject);
begin
  inherited;

  If blnUsaWms Then
    pExibeHelp(frxHelpComWms)
  Else
    pExibeHelp(frxHelpSemWms);
end;

function TfrmImportarPlanilhaLocFisica.fExisteArmazem(AValue : String) : Boolean;
Var
  qryCadAmz : TUniQuery;
Begin
  qryCadAmz := fCriaQuery;
  Try
    With qryCadAmz, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT COUNT(1) AS QTD      ');
      Add(' FROM CADAMZ                 ');
      Add(' WHERE AMZ_CODAMZ = :CODIGO  ');
      Add('   AND AMZ_CODEMP = :CODEMP  ');

      ParamByName('CODIGO').AsString := AValue;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      Result := FieldByName('QTD').AsInteger > 0;

      Close;
    End;

  Finally
    FreeAndNil(qryCadAmz);
  End;
End;

function TfrmImportarPlanilhaLocFisica.fExisteLocalSeparacao(AValue : String) : Boolean;
Var
  qryCadLse : TUniQuery;
Begin
  qryCadLse := fCriaQuery;
  Try
    With qryCadLse, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT COUNT(1) AS QTD      ');
      Add(' FROM CADLSE                 ');
      Add(' WHERE LSE_CODIGO = :CODIGO  ');
      ParamByName('CODIGO').AsString := AValue;
      Open;

      Result := FieldByName('QTD').AsInteger > 0;

      Close;
    End;

  Finally
    FreeAndNil(qryCadLse);
  End;
End;

function TfrmImportarPlanilhaLocFisica.fValidaPickingLaboratorioItemBase(out strMensagem: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    strMensagem := '';

    qryAux.SQL.Add('SELECT ITE_CODITE, ITE_DESITE, LOT_NUMLOT');
    qryAux.SQL.Add('FROM CADLOT');
    qryAux.SQL.Add('JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP');
    qryAux.SQL.Add('JOIN CADITE ON LOT_CODITE = ITE_CODITE');
    qryAux.SQL.Add('WHERE LOT_STATUS = "S"');
    qryAux.SQL.Add('  AND IFNULL(ITE_ITEBAS,"N") <> "S"');
    qryAux.SQL.Add('  AND LOC_CODLOC = :CODLOC');

    qryAux.ParamByName('CODLOC').AsString := strCodLoc;
    qryAux.Open;

    Result := qryAux.IsEmpty;

    If Not Result Then
    Begin
      strMensagem := 'Produto | Descrição                                                             | Lote' + sLineBreak;

      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        strMensagem := strMensagem +
          qryAux.FieldByName('ITE_CODITE').AsString.PadRight(8)  +'| '+
          qryAux.FieldByName('ITE_DESITE').AsString.PadRight(70) +'| '+
          qryAux.FieldByName('LOT_NUMLOT').AsString.PadRight(20) + sLineBreak;

        qryAux.Next;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmImportarPlanilhaLocFisica.pValidaLocais;
var
  strCodLse, strMensagemAux, strTipLoc,
  strEnder_, strItePic, strCodAmz : String;
  lstCodigos: TDictionary<String, Integer>;
  intIdLst : Integer;
begin
  lstCodigos := TDictionary<String, Integer>.Create;
  intIdLst := 1;

  Try
    cdsLocFis.First;
    While not cdsLocFis.Eof do
    Begin
      if cdsLocFis.FieldByName('IMPORT').AsString <> 'C' Then
      Begin
        cdsLocFis.Edit;
        strImport := 'S';
        strCodLoc := '';
        strCodLse := '';
        strTipLoc := '';
        strEnder_ := '';
        strItePic := '';
        strCodAmz := '';

        if fEmptyStr(cdsLocFis.FieldByName('DESCRI').AsString) Then
        Begin
          strImport := 'C';
          cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Descrição" deve ser informada; ';
        End;

        If (Pos(cdsLocFis.FieldByName('TRANSI').AsString, 'SN') <= 0) And
           (fCfgSis('ESTTRA') = 'S') Then
        Begin
          strImport := 'C';
          cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Transitória" deve ser preenchido com S ou N; ';
        End;

        If (Pos(cdsLocFis.FieldByName('BALCAO').AsString, 'SN') <= 0) And
           (fCfgSis('UTCSEA') = 'C') Then
        Begin
          strImport := 'C';
          cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Balcão" deve ser preenchido com S ou N; ';
        End;

        If blnUsaWms Then
        Begin
          If Not blnUsaMascaraCodigo Then
          Begin
            If fEmptyStr(cdsLocFis.FieldByName('CODLOC').AsString) Then
            Begin
              strImport := 'C';
              cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Código da Localização" deve ser informado; ';
            End
            Else
            Begin
              strCodLoc := cdsLocFis.FieldByName('CODLOC').AsString;
              If Not fVerificaChavePrimaria Then
              Begin
                strImport := 'C';
                cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Código da Localização" já cadastrado; ';
              End;
            End;
          End;

          If fEmptyStr(cdsLocFis.FieldByName('CODLSE').AsString) And
             (fCfgSis('LSEWMS') = 'S') Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Local de Separação" deve ser informado; ';
          End
          Else If Not fEmptyStr(cdsLocFis.FieldByName('CODLSE').AsString) Then
          Begin
            strCodLse := fPadL(cdsLocFis.FieldByName('CODLSE').AsString, fTamCodLse, '0');
            If (Not fEmptyStr(strCodLse)) And
               (Not fExisteLocalSeparacao(strCodLse)) Then
            Begin
              strImport := 'C';
              cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Local de Separação" não cadastrado; ';
            End;
          End;

          If fEmptyStr(cdsLocFis.FieldByName('R_U_A_').AsString) And
             fEmptyStr(cdsLocFis.FieldByName('PREDIO').AsString) And
             fEmptyStr(cdsLocFis.FieldByName('ANDAR_').AsString) And
             fEmptyStr(cdsLocFis.FieldByName('APARTA').AsString) Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' É Necessário informar pelo menos um dos endereços: "Rua", "Prédio", "Andar" ou "Apartamento"; ';
          End
          Else
          Begin
            If blnUsaMascaraCodigo Then
              strCodLoc := IIF(Not fEmptyStr(strCodLse), strCodLse + '-', '');

            If Not fEmptyStr(cdsLocFis.FieldByName('R_U_A_').AsString) Then
            Begin
              strEnder_ := strEnder_ + 'RUA '+ cdsLocFis.FieldByName('R_U_A_').AsString + ', ';
              If blnUsaMascaraCodigo Then
                strCodLoc := strCodLoc + cdsLocFis.FieldByName('R_U_A_').AsString + '-';
            End;

            If Not fEmptyStr(cdsLocFis.FieldByName('PREDIO').AsString) Then
            Begin
              strEnder_ := strEnder_ + 'PRÉDIO '+ cdsLocFis.FieldByName('PREDIO').AsString + ', ';
              If blnUsaMascaraCodigo Then
                strCodLoc := strCodLoc + cdsLocFis.FieldByName('PREDIO').AsString + '-';
            End;

            If Not fEmptyStr(cdsLocFis.FieldByName('ANDAR_').AsString) Then
            Begin
              strEnder_ := strEnder_ + 'ANDAR '+ cdsLocFis.FieldByName('ANDAR_').AsString + ', ';
              If blnUsaMascaraCodigo Then
                strCodLoc := strCodLoc + cdsLocFis.FieldByName('ANDAR_').AsString + '-';
            End;

            If Not fEmptyStr(cdsLocFis.FieldByName('APARTA').AsString) Then
            Begin
              strEnder_ := strEnder_ + 'APARTAMENTO '+ cdsLocFis.FieldByName('APARTA').AsString + ', ';
              If blnUsaMascaraCodigo Then
                strCodLoc := strCodLoc + cdsLocFis.FieldByName('APARTA').AsString + '-';
            End;

            strEnder_ := Copy(strEnder_, 1, Length(strEnder_) - 2);

            If blnUsaMascaraCodigo Then
            Begin
              strCodLoc := Copy(strCodLoc, 1, Length(strCodLoc) - 1);

              If Not fVerificaChavePrimaria Then
              Begin
                strImport := 'C';
                cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' Essa Localização já está cadastrada, verifique os dados da Rua, Prédio, Andar e Apartamento!; ';
              End;
            End;
          End;

          If (Pos(cdsLocFis.FieldByName('ATIVO_').AsString, 'SN') <= 0) Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Ativo" deve ser preenchido com S ou N; ';
          End;

          If Pos(cdsLocFis.FieldByName('PICKIN').AsString, 'SNEC') <= 0 Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Tipo de Localização" deve ser preenchido com S, N, E ou C; ';
          End
          Else
          Begin
            Case AnsiIndexStr(cdsLocFis.FieldByName('PICKIN').AsString, ['S', 'N', 'E', 'C']) of
              0 : strTipLoc := 'Picking';
              1 : strTipLoc := 'Buffer';
              2 : strTipLoc := 'Excesso';
              3 : strTipLoc := 'Picking CheckOut';
            End;
          End;

          If fCfgSis('PRILAB') = 'S' Then
          Begin
            If strCodLoc <> '' Then
            Begin
              If (Pos(cdsLocFis.FieldByName('PRILAB').AsString, 'SN') <= 0) Then
              Begin
                strImport := 'C';
                cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Picking Laboratório" deve ser preenchido com S ou N; ';
              End
              Else
              Begin
                If (cdsLocFis.FieldByName('PRILAB').AsString = 'S') And
                   (Not fValidaPickingLaboratorioItemBase(strMensagemAux)) Then
                Begin
                  strImport := 'C';
                  cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + sLineBreak + sLineBreak + strMensagemAux.Trim;
                End
                Else
                Begin
                  If (cdsLocFis.FieldByName('PICKIN').AsString = 'S') And
                     (cdsLocFis.FieldByName('PRILAB').AsString = 'S') Then
                    strTipLoc := 'Picking Laboratório';
                End;
              End;
            End;
          End;

          If Pos(cdsLocFis.FieldByName('PDERPD').AsString, 'SN') <= 0 Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Permite Receber Produtos" deve ser preenchido com S, N, E ou C; ';
          End;

          If (cdsLocFis.FieldByName('TXOMAX').AsFloat <= 0) Or
             (cdsLocFis.FieldByName('TXOMAX').AsFloat > 100) Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Taxa de Ocupação Máxima" deve ser maior do que "0,00" e menor ou igual a "100,00" ; ';
          End;

          If (Not cdsLocFis.FieldByName('LARGUR').IsNull) And
             (cdsLocFis.FieldByName('LARGUR').AsFloat < 0) Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Largura" deve ser maior ou igual a "0,00"; ';
          End;

          If (Not cdsLocFis.FieldByName('ALTURA').IsNull) And
             (cdsLocFis.FieldByName('ALTURA').AsFloat < 0) Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Altura" deve ser maior ou igual a "0,00"; ';
          End;

          If (Not cdsLocFis.FieldByName('PROFUN').IsNull) And
             (cdsLocFis.FieldByName('PROFUN').AsFloat < 0) Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Profundidade" deve ser maior ou igual a "0,00"; ';
          End;

          If (Not cdsLocFis.FieldByName('CAPACI').IsNull) And
             (cdsLocFis.FieldByName('CAPACI').AsFloat < 0) Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Capacidade Máxima" deve ser maior ou igual a "0,00"; ';
          End;

          If (Not fEmptyStr(cdsLocFis.FieldByName('ITEPIC').AsString)) Then
          Begin
            strItePic := fPadL(cdsLocFis.FieldByName('ITEPIC').AsString, 5, '0');
            If fRetNomProduto(strItePic) = '' Then
            Begin
              strImport := 'C';
              cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Produto" não encontrado; ';
            End;
          End;
        End
        Else
        Begin
          If fEmptyStr(cdsLocFis.FieldByName('CODLOC').AsString) Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Código da Localização Física" deve ser informado; ';
          End
          Else
          Begin
            strCodLoc := cdsLocFis.FieldByName('CODLOC').AsString;
            If Not fVerificaChavePrimaria Then
            Begin
              strImport := 'C';
              cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Código da Localização Física" já cadastrado; ';
            End;
          End;

          If fEmptyStr(cdsLocFis.FieldByName('CODAMZ').AsString) Then
          Begin
            If fCfgSis('CTLEST') = '2' Then
            Begin
              strImport := 'C';
              cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Armazém" deve ser informado; ';
            End;
          End
          Else
          Begin
            strCodAmz := fPadL(cdsLocFis.FieldByName('CODAMZ').AsString, 3, '0');
            If Not fExisteArmazem(strCodAmz) Then
            Begin
              strImport := 'C';
              cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Armazém" não cadastrado; ';
            End;
          End;

          If fEmptyStr(cdsLocFis.FieldByName('CODLSE').AsString) Then
          Begin
            If fCfgSis('UTLSLF') = 'S' Then
            Begin
              strImport := 'C';
              cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Local de Separação" deve ser informado; ';
            End;
          End
          Else If Not fEmptyStr(cdsLocFis.FieldByName('CODLSE').AsString) Then
          Begin
            strCodLse := fPadL(cdsLocFis.FieldByName('CODLSE').AsString, fTamCodLse, '0');
            If Not fExisteLocalSeparacao(strCodLse) Then
            Begin
              strImport := 'C';
              cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Local de Separação" não cadastrado; ';
            End;
          End;
        End;

        If Not fEmptyStr(strCodLoc) Then
        Begin
          cdsLocFis.FieldByName('CODFIM').AsString  := strCodLoc;
          If lstCodigos.ContainsKey(strCodLoc) Then
          Begin
            strImport := 'C';
            cdsLocFis.FieldByName('MOTIVO').AsString := cdsLocFis.FieldByName('MOTIVO').AsString + ' "Código '+strCodLoc+' em Duplicidade"; ';
          End
          Else
          Begin
            lstCodigos.Add(strCodLoc, intIdLst);
            inc(intIdLst);
          End;
        End
        Else
          cdsLocFis.FieldByName('CODFIM').AsString  := cdsLocFis.FieldByName('CODLOC').AsString;

        If Not fEmptyStr(strCodLse) Then
          cdsLocFis.FieldByName('CODLSE').AsString  := strCodLse;
        cdsLocFis.FieldByName('ITEPIC').AsString    := strItePic;
        cdsLocFis.FieldByName('CODAMZ').AsString    := strCodAmz;
        cdsLocFis.FieldByName('TIPLOC').AsString    := strTipLoc;
        cdsLocFis.FieldByName('ENDER_').AsString    := strEnder_;
        cdsLocFis.FieldByName('IMPORT').AsString    := strImport;
        cdsLocFis.Post;

        If strImport = 'C' Then
          blnTemInconsist := True;
      End;

      cdsLocFis.Next;
    End;
  Finally
    FreeAndNil(lstCodigos);
  End;
end;

procedure TfrmImportarPlanilhaLocFisica.pInsereLocaisCDS(AContador : Integer);

  function RetornaInteiroCelula(AValue: String) : Integer;
  begin
    Try
      Result := StrToInt(AValue);
    Except
      On E: Exception Do
      Begin
        Result := -999;
        strMotivo := strMotivo + ' Falha na conversão: '+AValue+';';
        strImport := 'C';
      End;
    End;
  end;

  function RetornaDoubleCelula(AValue: String) : Double;
  begin
    Try
      Result := StrToFloat(AValue);
    Except
      On E: Exception Do
      Begin
        Result := -999;
        strMotivo := strMotivo + ' Falha na conversão: '+AValue+';';
        strImport := 'C';
      End;
    End;
  end;


begin
  strImport := 'N';
  strMotivo := '';
  cdsLocFis.Insert;
  cdsLocFis.FieldByName('CODLOC').AsString  := objValidaExcel.fGetValueCSV(AContador, 'A');
  cdsLocFis.FieldByName('DESCRI').AsString  := objValidaExcel.fGetValueCSV(AContador, 'B');
  cdsLocFis.FieldByName('CRITIC').AsString  := objValidaExcel.fGetValueCSV(AContador, 'C');
  cdsLocFis.FieldByName('TRANSI').AsString  := objValidaExcel.fGetValueCSV(AContador, 'D');
  cdsLocFis.FieldByName('BALCAO').AsString  := objValidaExcel.fGetValueCSV(AContador, 'E');
  cdsLocFis.FieldByName('CODLSE').AsString  := objValidaExcel.fGetValueCSV(AContador, 'F');

  If blnUsaWms Then
  begin
    cdsLocFis.FieldByName('ATIVO_').AsString  := objValidaExcel.fGetValueCSV(AContador, 'G');
    cdsLocFis.FieldByName('R_U_A_').AsString  := objValidaExcel.fGetValueCSV(AContador, 'H');
    cdsLocFis.FieldByName('PREDIO').AsString  := objValidaExcel.fGetValueCSV(AContador, 'I');
    cdsLocFis.FieldByName('ANDAR_').AsString  := objValidaExcel.fGetValueCSV(AContador, 'J');
    cdsLocFis.FieldByName('APARTA').AsString  := objValidaExcel.fGetValueCSV(AContador, 'K');
    cdsLocFis.FieldByName('PICKIN').AsString  := objValidaExcel.fGetValueCSV(AContador, 'L');
    cdsLocFis.FieldByName('PRILAB').AsString  := IIF(fCfgSis('PRILAB') = 'S', objValidaExcel.fGetValueCSV(AContador, 'M'), 'N');
    cdsLocFis.FieldByName('PDERPD').AsString  := objValidaExcel.fGetValueCSV(AContador, 'N');

    If Not fEmptyStr(objValidaExcel.fGetValueCSV(AContador, 'O')) Then
      cdsLocFis.FieldByName('TXOMAX').AsInteger := RetornaInteiroCelula(objValidaExcel.fGetValueCSV(AContador, 'O'))
    Else
      cdsLocFis.FieldByName('TXOMAX').Value := Null;

    If Not fEmptyStr(objValidaExcel.fGetValueCSV(AContador, 'P')) Then
      cdsLocFis.FieldByName('PESMAX').AsFloat   := RetornaDoubleCelula(objValidaExcel.fGetValueCSV(AContador, 'P'))
    Else
      cdsLocFis.FieldByName('PESMAX').Value := Null;

    If Not fEmptyStr(objValidaExcel.fGetValueCSV(AContador, 'Q')) Then
      cdsLocFis.FieldByName('LARGUR').AsFloat   := RetornaDoubleCelula(objValidaExcel.fGetValueCSV(AContador, 'Q'))
    Else
      cdsLocFis.FieldByName('LARGUR').Value := Null;

    If Not fEmptyStr(objValidaExcel.fGetValueCSV(AContador, 'R')) Then
      cdsLocFis.FieldByName('ALTURA').AsFloat   := RetornaDoubleCelula(objValidaExcel.fGetValueCSV(AContador, 'R'))
    Else
      cdsLocFis.FieldByName('ALTURA').Value := Null;

    If Not fEmptyStr(objValidaExcel.fGetValueCSV(AContador, 'S')) Then
      cdsLocFis.FieldByName('PROFUN').AsFloat   := RetornaDoubleCelula(objValidaExcel.fGetValueCSV(AContador, 'S'))
    Else
      cdsLocFis.FieldByName('PROFUN').Value := Null;

    If Not fEmptyStr(objValidaExcel.fGetValueCSV(AContador, 'T')) Then
      cdsLocFis.FieldByName('ITEPIC').AsString  := objValidaExcel.fGetValueCSV(AContador, 'T')
    Else
      cdsLocFis.FieldByName('ITEPIC').Value := Null;

    cdsLocFis.FieldByName('OBSERV').AsString  := objValidaExcel.fGetValueCSV(AContador, 'U');
  end
  else
  begin
    If Not fEmptyStr(objValidaExcel.fGetValueCSV(AContador, 'G')) Then
      cdsLocFis.FieldByName('CAPACI').AsFloat   := RetornaDoubleCelula(objValidaExcel.fGetValueCSV(AContador, 'G'))
    Else
      cdsLocFis.FieldByName('CAPACI').Value := Null;

    If Not fEmptyStr(objValidaExcel.fGetValueCSV(AContador, 'H')) Then
      cdsLocFis.FieldByName('PONREP').AsFloat   := RetornaDoubleCelula(objValidaExcel.fGetValueCSV(AContador, 'H'))
    Else
      cdsLocFis.FieldByName('PONREP').Value := Null;

    cdsLocFis.FieldByName('CODAMZ').AsString  := objValidaExcel.fGetValueCSV(AContador, 'I');
  end;

  cdsLocFis.FieldByName('IMPORT').AsString  := strImport;
  cdsLocFis.FieldByName('MOTIVO').AsString  := strMotivo;

  If strImport = 'C' Then
    blnTemInconsist := True;

  cdsLocFis.Post;
end;

procedure TfrmImportarPlanilhaLocFisica.pProcessaPlanilha;
Var
  intContador : Integer;
begin
  blnTemInconsist := False;
  pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count -1;
  pgbGeral.Position := 0;

  cdsLocFis.Open;
  cdsLocFis.EmptyDataSet;

  For intContador := 0 To (objValidaExcel.ArquivoCSV.Count - 1) Do
  Begin
    pnlInfo.Caption := 'Importando Localizações Físicas...'+ IntToStr(intContador) + '/' +IntToStr(objValidaExcel.ArquivoCSV.Count - 1);

    If intContador > objValidaExcel.ArquivoCSV.Count Then
      Continue;

    pInsereLocaisCDS(intContador);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
  End;

  pValidaLocais;

  pExibeTela;
end;

procedure TfrmImportarPlanilhaLocFisica.pExibeTela;
var
  frmConfirmaImportacaoLocFisica : TfrmConfirmaImportacaoLocFisica;
begin
  If Not cdsLocFis.IsEmpty Then
  Begin
    pCriarFormularios(TfrmConfirmaImportacaoLocFisica, frmConfirmaImportacaoLocFisica);
    Try
      frmConfirmaImportacaoLocFisica.cdsLocFis        := cdsLocFis;
      frmConfirmaImportacaoLocFisica.blnUsaWms        := blnUsaWms;
      frmConfirmaImportacaoLocFisica.blnTemInconsist  := blnTemInconsist;

      frmConfirmaImportacaoLocFisica.ShowModal;
    Finally
      pFreeAndNil(frmConfirmaImportacaoLocFisica);
    End;
  End;
end;

procedure TfrmImportarPlanilhaLocFisica.btnGravarClick(Sender: TObject);
var
  intQtdColunas : Integer;
begin
  inherited;

  If fEmptyStr(edtPath.Text) Then
  Begin
    pMensagemOk('Selecione um arquivo!');
    pSetFocus(edtPath);
    Exit;
  End
  Else If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado: ' + edtPath.Text + ' !', ['&O K']);
    pSetFocus(edtPath);
    Exit;
  End;

  intQtdColunas := IIF(blnUsaWms, 21, 9);

  try
    pnlInfo.Caption := 'Verificando Planilha. Aguarde...';
    Application.ProcessMessages;

    objValidaExcel := TValidadorExcel.Create(edtPath.text, intQtdColunas, '', '', 0);

    btnSair.Enabled       := False;
    edtPath.Enabled       := False;

    Mouse.SettingChanged(10);
    pgbGeral.Visible := True;
    Application.ProcessMessages;
    edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');

    pProcessaPlanilha;

    SetForegroundWindow(Handle);
    edtPath.Clear;

  Finally
    btnSair.Enabled       := True;
    edtPath.Enabled       := True;

    btnGravar.Enabled := True;
    pnlInfo.Caption := '';
    FreeAndNil(objValidaExcel);
    pgbGeral.Position     := 0;
    pgbGeral.Visible := False;
    pSetFocus(btnSair);
  End;
end;

procedure TfrmImportarPlanilhaLocFisica.FormCreate(Sender: TObject);
begin
  inherited;

  pCriaDataSet;
  blnUsaWms := fUsaRotinaWMS;
end;

Procedure TfrmImportarPlanilhaLocFisica.pCriaDataSet;
Begin
  cdsLocFis := TUniClientDataSet.Create(Self);

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODLOC';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODFIM';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESCRI';
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CRITIC';
    DataType := ftString;
    Size     := 1;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TRANSI';
    DataType := ftString;
    Size     := 1;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BALCAO';
    DataType := ftString;
    Size     := 1;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODLSE';
    DataType := ftString;
    Size     := fTamCodLse;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODAMZ';
    DataType := ftString;
    Size     := 3;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ATIVO_';
    DataType := ftString;
    Size     := 1;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CAPACI';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PONREP';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PESMAX';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'R_U_A_';
    DataType := ftString;
    Size     := 4;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PREDIO';
    DataType := ftString;
    Size     := 4;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ANDAR_';
    DataType := ftString;
    Size     := 4;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'APARTA';
    DataType := ftString;
    Size     := 4;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ENDER_';
    DataType := ftString;
    Size     := 60;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PICKIN';
    DataType := ftString;
    Size     := 1;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PRILAB';
    DataType := ftString;
    Size     := 1;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TIPLOC';
    DataType := ftString;
    Size     := 30;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PDERPD';
    DataType := ftString;
    Size     := 1;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TXOMAX';
    DataType := ftInteger;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'LARGUR';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ALTURA';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PROFUN';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITEPIC';
    DataType := ftString;
    Size     := 5;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'OBSERV';
    DataType := ftString;
    Size     := 500;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'IMPORT';
    DataType := ftString;
    Size     := 1;
    Required := False;
  End;

  With cdsLocFis.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'MOTIVO';
    DataType := ftString;
    Size     := 500;
    Required := False;
  End;

  cdsLocFis.CreateDataSet;

  (cdsLocFis.FieldByName('CAPACI') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (cdsLocFis.FieldByName('PONREP') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (cdsLocFis.FieldByName('PESMAX') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

  cdsLocFis.IndexFieldNames := 'CODLOC';
End;

end.
