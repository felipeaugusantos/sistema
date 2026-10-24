unit untFatImpressao;

interface

uses SysUtils, Uni, DB, WinSpool;

Type
  TFatImpressao = class(TObject)
    private
      FQtdLin: Integer;
      FNomImp: String;
      FArqImp: TextFile;

      FNumDoc: String;
      FEspDoc: String;
      FCodEmp: String;
      FDocSep: Boolean;
      FImpTck: Boolean;

      intPagina: Integer;
      intLinImp: Integer;
      intQtdFol: Integer;
      intQtdFolOri: Integer;
      intQtdAdc: Integer; // quantidade de itens adicionais quando tem mais de uma pagina
      intQtdPag: Integer;
      intIteImp: Integer;
      intTotIteImp: Integer;
      blnCabEmp: Boolean;
      blnTemSer: Boolean;
      fltDebCli: Double;
      strRisco: String;
      blnReimpressao: Boolean;

      blnImpPre: Boolean;
      blnComPre: Boolean;

      blnEntMat: Boolean;

      PrinterHandler: Cardinal;
      blnIteRep: Boolean;
      fltTotIte: Double;

      qryCadEmp: TUniQuery;
      qryCadCli: TUniQuery;
      qryMovGer: TUniQuery;
      qryFatGor: TUniQuery;
      qryRelatorio: TUniQuery;

      {*******************************************}
      {* METODOS DE FORMATAÇÃO                   *}
      {****************************************MV*}
      function Cond_10CPI(blnLiga: Boolean): String;
      function Cpi_12(blnLiga: Boolean): String;
      function Expandido(blnLiga: Boolean): String;
      function Negrito(blnLiga: Boolean): String;
      function TamPag(intMaxLin: Integer): String;
      function Um_Oitavo(blnLiga: Boolean): String;

      {*******************************************}
      {* OPERAÇÕES NA IMPRESSORA                 *}
      {****************************************MV*}
      procedure Imp(strTexto: String; blnPula: Boolean = True);
      procedure Reseta;
      procedure Eject;

      {*******************************************}
      {* METODOS AUXILIARES                      *}
      {****************************************MV*}
      function CadEmp(strCampo: String): TField;
      function CadCli(strCampo: String): TField;
      function MovGer(strCampo: String): TField;
      function FatGor(strCampo: String): TField;
      procedure pCarregaQueryes(strTabela: String);

    protected
      procedure SetQtdLin(intQtd: Integer);
      procedure SetNomImp(strImp: String);

      procedure pImprimeNF; virtual;
      procedure pImprimeNFCab;
      procedure pImprimeNFRod(blnTotal: Boolean);

      procedure pImprimeNF40Col;
      procedure pImprimeNFCab40Col;
      procedure pImprimeNFRod40Col;

      procedure pImprimeIF; virtual;
      procedure pImprimeFF; virtual;
      procedure pImprimeMI; virtual;
      procedure pImprimeTE; virtual;
      procedure pImprimePI; virtual;
      procedure pImprimeBR; virtual;
      procedure pImprimeTR; virtual;
      procedure pImprimeDV; virtual;
      procedure pImprimeAJ; virtual;
      procedure pImprimePD; virtual;
      procedure pImprimeOR; virtual;

      procedure pImprimeFFGenerico;
      procedure pImprimeFFCabGenerico;
      procedure pImprimeFFRodGenerico(blnTotal: Boolean);

      procedure pImprimeFFGenerico40Col;
      procedure pImprimeFFCabGenerico40Col;
      procedure pImprimeFFRodGenerico40Col;

      procedure pImprimeTRGenerico;
      procedure pImprimeTRCabGenerico;
      procedure pImprimeTRRodGenerico(blnTotal: Boolean);

      procedure pImprimeTRGenerico40Col;
      procedure pImprimeTRCabGenerico40Col;
      procedure pImprimeTRRodGenerico40Col;

      procedure pImprimePDGenerico;
      procedure pImprimePDCabGenerico;
      procedure pImprimePDRodGenerico(blnTotal: Boolean);

      procedure pImprimePDGenerico40Col;
      procedure pImprimePDCabGenerico40Col;
      procedure pImprimePDRodGenerico40Col;

    public
      strColRel: String;

      property intQtdLin: Integer Read FQtdLin Write SetQtdLin;
      property strNomImp: String Read FNomImp Write SetNomImp;

      procedure pImprime(qryRel: TUniQuery;
                         blnTemSer: Boolean;
                         strTabela,
                         strNumDoc,
                         strEspDoc,
                         strCodEmp: String;
                         fltDebCli: Double;
                         blnReimpressao: Boolean;
                         blnDocSep: Boolean = False;
                         blnComPre: Boolean = False;
                         blnImpTck: Boolean = False;
                         blnIteRep: Boolean = False);

      Constructor Create(strNomImp: String);
      Destructor Destroy; override;

  End;

implementation

uses untFuncoes, untfuncoesSimples,  untConstantes;

{ TFatImpressao }
procedure TFatImpressao.SetQtdLin(intQtd: Integer);
begin
  If (intQtdLin <= 0) Then
    Self.FQtdLin := 1
  Else
    Self.FQtdLin := intQtd;
end;

function TFatImpressao.Expandido(blnLiga: Boolean): String;
begin
  If blnLiga Then
     Result := #27 + #87 + '1'
  Else
     Result := #27 + #87 + '0';
end;

function TFatImpressao.Cond_10CPI(blnLiga: Boolean): String;
begin
  If blnLiga Then
     Result := #15
  Else
     Result := #18;
end;

function TFatImpressao.Cpi_12(blnLiga: Boolean): String;
begin
  If blnLiga Then
     Result := #27 + #77
  Else
     Result := #27 + #80;
end;

function TFatImpressao.Negrito(blnLiga: Boolean): String;
begin
  If blnLiga Then
     Result := #27 + 'E'
  Else
     Result := #27 + 'F';
end;

function TFatImpressao.Um_Oitavo(blnLiga: Boolean): String;
begin
  If blnLiga Then
     Result := #27 + '0'
  Else
     Result := #27 + '2';
end;

function TFatImpressao.TamPag(intMaxLin: Integer): String;
begin
  Result := #27 + 'C' + Chr(intMaxLin);
end;

procedure TFatImpressao.Reseta;
begin
  Imp(#27 + '@', False);
  Imp(#18 + #27 + #80, False);
end;

procedure TFatImpressao.Eject;
begin
  Imp(#12);
  Reseta;
end;


procedure TFatImpressao.pImprime(qryRel: TUniQuery;
                                 blnTemSer: Boolean;
                                 strTabela,
                                 strNumDoc,
                                 strEspDoc,
                                 strCodEmp: String;
                                 fltDebCli: Double;
                                 blnReimpressao: Boolean;
                                 blnDocSep: Boolean = False;
                                 blnComPre: Boolean = False;
                                 blnImpTck: Boolean = False;
                                 blnIteRep: Boolean = False);
  Var
    DocInfo: TDocInfo1;
begin

  If (fEmptyStr(FNomImp)) Then
  Begin
    Raise Exception.Create('O nome da impressora não está definido!');
  End;

  fltTotIte := 0.0;

  FDocSep   := blnDocSep;
  FImpTck   := blnImpTck;

  Self.blnComPre := blnCompre;
  blnImpPre := True;
  Self.blnIteRep := blnIteRep;

{  Try
    AssignFile(FArqImp, FNomImp);
    Rewrite(FArqImp);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Houve um erro ao abrir a impressora: ' + E.Message);
    End;
  End;}

  OpenPrinter(PChar(FNomImp), PrinterHandler, Nil);
  with DocInfo do
  begin
    pDatatype := 'RAW';
    pDocName := PChar('Impressão de Faturamento');
    pOutputFile := nil;
  end;
  StartDocPrinter(PrinterHandler, 1, @DocInfo);
  StartPagePrinter(PrinterHandler);

  Self.blnTemSer := blnTemSer;
  Self.fltDebCli := fltDebCli;

  Self.blnReimpressao := blnReimpressao;

  If strTabela = 'MOVDET' Then
    strTabela := 'MOVGER '

  Else If strTabela = 'MOVDETX' Then
    strTabela := 'MOVGERX '

  Else If strTabela = 'NOTDET' Then
    strTabela := 'NOTGER '

  Else If strTabela = 'NOTDETX' Then
    strTabela := 'NOTGERX '

  Else If strTabela = 'FATDOR' Then
    strTabela := 'FATGOR';

  qryRelatorio := qryRel;
  intPagina    := 0;

  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;
  FCodEmp := strCodEmp;

  pCarregaQueryes(strTabela);

  {*******************************************}
  {* IMPRESSÃO NOTA FISCAL                   *}
  {****************************************MV*}
  If (strEspDoc = 'NF') And (Not blnDocSep) Then
  Begin

    If strColRel = '80' Then
      pImprimeNF
    Else
      pImprimeNF40Col;

  End

  {*******************************************}
  {* IMPRESSÃO CUPOM FISCAL                  *}
  {****************************************MV*}
  Else If (strEspDoc = 'IF') And (Not blnDocSep) Then
  Begin
    pImprimeIF;
  End

  {*******************************************}
  {* IMPRESSÃO FATURAMENTO FUTURO            *}
  {****************************************MV*}
  Else If (strEspDoc = 'FF') And (Not blnDocSep) Then
  Begin
    pImprimeFF;
  End
  {*******************************************}
  {* IMPRESSÃO MI                            *}
  {****************************************MV*}
  Else If (strEspDoc = 'MI') And (Not blnDocSep) Then
  Begin
    pImprimeMI;
  End
  {*******************************************}
  {* IMPRESSÃO TRANSF. ESTOQUE               *}
  {****************************************MV*}
  Else If (strEspDoc = 'TE') Then
  Begin
    pImprimeTE;
  End
  {*******************************************}
  {* IMPRESSÃO PIGMENTO                      *}
  {****************************************MV*}
  Else If (strEspDoc = 'PI') Then
  Begin
    pImprimePI;
  End
  {*******************************************}
  {* IMPRESSÃO BRINDE                        *}
  {* CASO FOR DOCUMENTO DE SEPARAÇÃO,IMPRIME *}
  {* MESMO MODELO DO BRINDE SEM PREÇOS       *}
  {****************************************MV*}
  Else If (strEspDoc = 'BR') Or (blnDocSep) Then
  Begin
    pImprimeBR;
  End
  {*******************************************}
  {* IMPRESSÃO TROCA                         *}
  {****************************************MV*}
  Else If (strEspDoc = 'TR') Then
  Begin
    pImprimeTR;
  End
  {*******************************************}
  {* IMPRESSÃO DEVOLUÇÃO                     *}
  {****************************************MV*}
  Else If (strEspDoc = 'DV') Then
  Begin
    pImprimeDV;
  End
  {*******************************************}
  {* IMPRESSÃO AJUSTE                        *}
  {****************************************MV*}
  Else If (strEspDoc = 'AJ') Then
  Begin
    pImprimeAJ;
  End
  {*******************************************}
  {* IMPRESSÃO PEDIDO DE VENDA               *}
  {****************************************MV*}
  Else If (strEspDoc = 'PD') Then
  Begin
    pImprimePD;
  End
  {*******************************************}
  {* IMPRESSÃO ORÇAMENTO                     *}
  {****************************************MV*}
  Else If (strEspDoc = 'OR') Then
  Begin
    pImprimeOR;
  End;

//  Flush(FArqImp);
//  CloseFile(FArqImp);

  ClosePrinter(PrinterHandler);


end;

constructor TFatImpressao.Create(strNomImp: String);
begin
  inherited Create;
  Try
    Self.FNomImp := strNomImp;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

  qryCadEmp := fCriaQuery;
  qryCadCli := fCriaQuery;
  qryMovGer := fCriaQuery;
  qryFatGor := fCriaQuery;
end;

destructor TFatImpressao.Destroy;
begin
  qryCadEmp.Close;
  qryCadCli.Close;
  qryMovGer.Close;
  qryFatGor.Close;
  FreeAndNil(qryCadEmp);
  FreeAndNil(qryCadCli);
  FreeAndNil(qryMovGer);
  FreeAndNil(qryFatGor);
  inherited Destroy;
end;

procedure TFatImpressao.Imp(strTexto: String; blnPula: Boolean);
  Var
    escritos: Cardinal;
begin

//  If (blnPula) Then
//    Writeln(FArqImp, strTexto)
//  Else
//    Write(FArqImp, strTexto);
//  Flush(FArqImp);
  WritePrinter(PrinterHandler, Pointer(strTexto), Length(strTexto), escritos);
  If (blnPula) Then
  Begin
    strTexto := #13#10;
    WritePrinter(PrinterHandler, Pointer(strTexto), 2, escritos);
  End;
end;

procedure TFatImpressao.SetNomImp(strImp: String);
begin

  If (fEmptyStr(strImp)) Then
    Raise Exception.Create('O nome da impressora deve ser informado!');

  FNomImp := strImp;

end;

function TFatImpressao.CadCli(strCampo: String): TField;
begin
  Result := qryCadCli.FieldByName('CLI_' + strCampo);
end;

function TFatImpressao.CadEmp(strCampo: String): TField;
begin
  Result := qryCadEmp.FieldByName('EMP_' + strCampo);
end;

procedure TFatImpressao.pCarregaQueryes(strTabela: String);
begin

  With qryCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                        ');
    SQL.Add('  CADEMP.*,                   ');
    SQL.Add('  CID_NOMCID AS EMP_NOMCID,   ');
    SQL.Add('  CID_ESTADO AS EMP_ESTADO    ');
    SQL.Add('FROM                          ');
    SQL.Add('  CADEMP,                     ');
    SQL.Add('  CADCID                      ');
    SQL.Add('WHERE                         ');
    SQL.Add('  CID_CODCID = EMP_CODCID AND ');
    SQL.Add('  EMP_CODEMP = :CODEMP        ');
    ParamByName('CODEMP').AsString := FCodEmp;
    Open;
  End;

  If (strTabela = 'FATGOR') Then
  Begin
    With qryFatGor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT                     ');
      SQL.Add('  *                        ');
      SQL.Add('FROM                       ');
      SQL.Add('  FATGOR                   ');
      SQL.Add('WHERE                      ');
      SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
      SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
      SQL.Add('  FGO_CODEMP = :CODEMP     ');
      ParamByName('NUMDOC').AsString := FNumDoc;
      ParamByName('ESPDOC').AsString := FEspDoc;
      ParamByName('CODEMP').AsString := FCodEmp;
      Open;
    End;
  End
  Else
  Begin
    With qryMovGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT                     ');
      SQL.Add('  *                        ');
      SQL.Add('FROM                       ');
      SQL.Add('  ' + strTabela + '        ');
      SQL.Add('WHERE                      ');
      SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
      SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
      SQL.Add('  GER_CODEMP = :CODEMP     ');
      ParamByName('NUMDOC').AsString := FNumDoc;
      ParamByName('ESPDOC').AsString := FEspDoc;
      ParamByName('CODEMP').AsString := FCodEmp;
      Open;
    End;

  End;

  With qryCadCli Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                                  ');
    SQL.Add('  CADCLI.*,                             ');
    SQL.Add('  C.CID_NOMCID AS CLI_NOMCID,           ');
    SQL.Add('  C.CID_ESTADO AS CLI_ESTADO,           ');
    SQL.Add('  IFNULL(E.CID_NOMCID, C.CID_NOMCID) AS CLI_NCIDEN, ');
    SQL.Add('  IFNULL(E.CID_ESTADO, C.CID_ESTADO) AS CLI_NESTEN  ');
    SQL.Add('FROM                                    ');
    SQL.Add('  CADCLI,                               ');
    SQL.Add('  CADCID C                              ');
    SQL.Add('LEFT JOIN                               ');
    SQL.Add('  CADCID E ON E.CID_CODCID = CLI_CIDENT ');
    SQL.Add('WHERE                                   ');
    SQL.Add('  CLI_CODCLI = :CODCLI AND              ');
    SQL.Add('  CLI_CODCID = C.CID_CODCID             ');

    If (strTabela = 'FATGOR') Then
    Begin
      ParamByName('CODCLI').AsString := FatGor('CODCLI').AsString;
    End
    Else
    Begin
      ParamByName('CODCLI').AsString := MovGer('CODCLI').AsString;
    End;
    Open;
  End;

end;

function TFatImpressao.MovGer(strCampo: String): TField;
begin
  Result := qryMovGer.FieldByName('GER_' + strCampo);
end;

procedure TFatImpressao.pImprimeAJ;
begin

  If strColRel = '80' Then
    pImprimeTRGenerico
  Else
    pImprimeTRGenerico40Col;

end;

procedure TFatImpressao.pImprimeBR;
begin

  If strColRel = '80' Then
    pImprimeFFGenerico
  Else
    pImprimeFFGenerico40Col;
    
end;

procedure TFatImpressao.pImprimeDV;
begin

  If strColRel = '80' Then
    pImprimeTRGenerico
  Else
    pImprimeTRGenerico40Col;
    
end;

procedure TFatImpressao.pImprimeFF;
begin

  If strColRel = '80' Then
    pImprimeFFGenerico
  Else
    pImprimeFFGenerico40Col;

end;

procedure TFatImpressao.pImprimeIF;
begin

  If strColRel = '80' Then
    pImprimeNF
  Else
    pImprimeNF40Col;

end;

procedure TFatImpressao.pImprimeMI;
begin

  If strColRel = '80' Then
    pImprimeFFGenerico
  Else
    pImprimeFFGenerico40Col;

end;

procedure TFatImpressao.pImprimeNF;
  Var
    intQtdDiv: Integer;
begin

  If Pos(FEspDoc, VS_strNaoCab) > 0 Then
  Begin
    blnCabEmp    := False;
    intQtdFol    := 15;
    intQtdFolOri := 15;
    intQtdAdc    := 10;
  End
  Else
  Begin
    blnCabEmp    := True;
    intQtdFol    := 10;
    intQtdFolOri := 10;
    intQtdAdc    := 10;
  End;

  If (blnTemSer) Then
  Begin
    Dec(intQtdFol, 2);
    Dec(intQtdFolOri, 2);
  End;

  If (VS_strUsaCnd = 'S') Then
  Begin
    Dec(intQtdFol, 1);
    Dec(intQtdFolOri, 1);
  End;

  blnEntMat := False;
  If (MovGer('CONENT').AsString = 'S') And (Not VS_blnEmpGer) Then
  Begin
    Dec(intQtdFol, 1);
    Dec(intQtdFolOri, 1);
    blnEntMat := True;
  End;

  intQtdPag := 1;

  If (qryRelatorio.RecordCount > intQtdFol) Then
  Begin
    intQtdDiv := qryRelatorio.RecordCount - intQtdFol;
    intQtdPag := (intQtdDiv Div (intQtdFol + intQtdAdc));
    //If (intQtdPag > 0) Then
    //Begin
      If (intQtdDiv / (intQtdFol + intQtdAdc) > intQtdPag) Then
        Inc(intQtdPag);
    //End;
    Inc(intQtdPag);

  End;

  qryRelatorio.First;
  intIteImp    := 0;
  intTotIteImp := 0;

  With qryRelatorio Do
  Begin
    While (Not Eof) Do
    Begin

      If (intIteImp = 0) Or (intIteImp >= intQtdFol) Then
      Begin

        If (intIteImp = 0) Or (intQtdFol + intQtdAdc > intQtdFolOri + intQtdAdc) Then
        Begin
          pImprimeNFCab;
          If (intIteImp > 0) Then
            Dec(intQtdFol, intQtdAdc);

          intIteImp := 0;
        End
        Else
        Begin
          If (intTotIteImp >= qryRelatorio.RecordCount) Then
          Begin
            pImprimeNFCab;
            intIteImp := 0;
            Break;
          End
          Else
            Inc(intQtdFol, intQtdAdc);
        End;
      End;

      Imp(fPadR(FieldByName('CODITE').AsString, 08) +
          fPadR(FieldByName('DESITE').AsString, IIF(fEmptyStr(FieldByName('CODITE').AsString), 130, 76)) +
          fPadR(FieldByName('CODFIS').AsString, 13) +
          fPadR(FieldByName('UNIDAD').AsString, 08) +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 3)), 08) +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrf(FieldByName('VALUNI').AsFloat, ffFixed, 12, 4)), 11) +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrf(FieldByName('VALITE').AsFloat, ffFixed, 12, 2)), 13));
      Inc(intIteImp);
      Inc(intTotIteImp);

      Next;
    End;
  End;

  If (intIteImp > intQtdFolOri) Then
  Begin
    pImprimeNFCab;
  End;

  pImprimeNFRod(True);

end;

procedure TFatImpressao.pImprimeNF40Col;
begin

  If Pos(FEspDoc, VS_strNaoCab) > 0 Then
    blnCabEmp    := False
  Else
    blnCabEmp    := True;

  blnEntMat := False;

  If (MovGer('CONENT').AsString = 'S') And (Not VS_blnEmpGer) Then
    blnEntMat := True;

  qryRelatorio.First;
  pImprimeNFCab40Col;

  With qryRelatorio Do
  Begin
    While (Not Eof) Do
    Begin

      Imp(fPadR(FieldByName('CODITE').AsString, 05) + ' ' +
          fPadR(FieldByName('DESITE').AsString, 40));
      Imp(fPadL(FieldByName('CODFIS').AsString, 18) + ' ' +
          fPadR(FieldByName('UNIDAD').AsString, 02) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 2)), 06) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrf(FieldByName('VALUNI').AsFloat, ffFixed, 12, 2)), 08) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrf(FieldByName('VALITE').AsFloat, ffFixed, 12, 2)), 09));

      Next;
    End;
  End;

  pImprimeNFRod40Col;

end;

procedure TFatImpressao.pImprimeNFCab;
  Var
    strControle: String;
    strCgcCpf: String;
    strConPag: String;
    strIesRg: String;
    strTelEmp: String;
    strForPag: String;
    strClaFis: String;
    strCodCli: String;
    strNomCli: String;
    strFanSob: String;
    strEndCli: String;
    strBaiCli: String;
    strCidCli: String;
    strCgcCli: String;
    strTelCli: String;
    strCepCli: String;

    blnImpFor: Boolean;
begin
  strControle := '';
  strCgcCpf   := '';

  Inc(intPagina);

  strControle := IntToStr(intPagina) + '/' + IntToStr(intQtdPag);

  If intPagina > 1 Then
  Begin
    pImprimeNFRod(False);
    intLinImp := 0;
  End;

  If (fStatusCndPag(MovGer('CONPAG').AsString) = A_PRAZO) Then
  Begin
    strConPag := Cond_10CPI(True) + fPadR(fFormataCondPag(MovGer('CONPAG').AsString), 67) + Cond_10CPI(False);
  End
  Else
  Begin
    strConPag := Cond_10CPI(True) + fPadR('A VISTA', 67) + Cond_10CPI(False);
  End;

  strForPag := IIF(VS_strUsaFpg <> 'S', '', MovGer('CODFPG').AsString + ' - ' + fRetDesFpg(MovGer('CODFPG').AsString));

  strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
  If (CadCli('CGCCPF').AsInteger = 1) Then
  Begin
    strIesRg := CadCli('I_E_S_').AsString;
  End
  Else
  Begin
    strIesRg := CadCli('NUMR_G').AsString;
  End;

  strTelEmp := 'FONE/FAX.: ' + CadEmp('FONE01').AsString;
  strRisco  := fReplicatorStr('-', 80);

  strClaFis := MovGer('CLAFIS').AsString +
               IIF(Not fEmptyStr(MovGer('CLAFI2').AsString), '/' + MovGer('CLAFI2').AsString, '') +
               IIF(Not fEmptyStr(MovGer('CLAFI3').AsString), '/' + MovGer('CLAFI3').AsString, '');

  {*******************************************}
  {* CONFIGURA O RELATÓRIO                   *}
  {****************************************MV*}
  Reseta;
  Imp(Cond_10CPI(False), False);
  Imp(CPI_12(False), False);
  Imp(Um_Oitavo(True), False);
  Imp(TamPag(43), False);

  {*******************************************}
  {* IMPRIME DADOS DA EMPRESA                *}
  {****************************************MV*}
  If (blnCabEmp) Then
  Begin
    Imp(Expandido(True) + CadEmp('NOMEMP').AsString + Expandido(False));
    Imp(Expandido(True) + fPadR(CadEmp('FONE01').AsString, 74) + Expandido(False) + fPadR(strControle, 5));
    Imp('Cidade..: ' + fPadR(CadEmp('NOMCID').AsString + '-' + CadEmp('ESTADO').AsString , 40) + 'Bairro.: ' + fPadR(CadEmp('BAIRRO').AsString, 18));
    Imp('Endereco: ' + fPadR(CadEmp('ENDERE').AsString, 40) + 'Cep....: ' + fPadR(CadEmp('C_E_P_').AsString, 18));
    Imp(strRisco);
    strControle := '';
  End;

  Imp(Expandido(True), False);

  If (FEspDoc = 'NF') Then
    Imp('NOTA FISCAL ', False)

  Else If (FEspDoc = 'IF') And Not( FImpTck )  Then
    Imp('CUPOM FISCAL ', False)

  // EDUARDO
  Else If (FEspDoc = 'IF') And ( FImpTck )  Then
    Imp('TICKET CF - ', False);


  Imp('No ' + FNumDoc + Expandido(False), blnCabEmp);

  If (Not blnCabEmp) Then
  Begin
    Imp(fPadL(strControle, 10));
  End;

  blnImpFor := False;
  If (Not fEmptyStr(MovGer('CODFOR').AsString)) Then
  Begin
    blnImpFor := True;
  End;

  If (fEmptyStr(MovGer('NOMCON').AsString)) And (Not blnImpFor) Then
  Begin
    strCodCli := CadCli('CODCLI').AsString;
    strNomCli := CadCli('NOMCLI').AsString;
    strFanSob := CadCli('FANSOB').AsString;
    strEndCli := CadCli('ENDERE').AsString;
    strBaiCli := CadCli('BAIRRO').AsString;
    strCidCli := CadCli('NOMCID').AsString;
    strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
    strTelCli := CadCli('FONE01').AsString;
    If (CadCli('CGCCPF').AsInteger = 1) Then
    Begin
      strIesRg := CadCli('I_E_S_').AsString;
    End
    Else
    Begin
      strIesRg := CadCli('NUMR_G').AsString;
    End;
    strCepCli := CadCli('C_E_P_').AsString;
  End
  Else
  Begin
    strCodCli := MovGer('CODCLI').AsString;
    strNomCli := MovGer('NOMCON').AsString;
    strFanSob := '';
    strEndCli := MovGer('ENDCON').AsString;
    strBaiCli := MovGer('BAICON').AsString;
    strCidCli := fRetNomCidade(MovGer('CIDCON').AsString, 0) + '-' + fRetNomCidade(MovGer('CIDCON').AsString, 1);
    strIesRg  := MovGer('R_GCON').AsString;
    strCgcCli := fFormataCpfCgc(MovGer('CGCCON').AsString);
    strTelCli := MovGer('TELCON').AsString;
    strCepCli := MovGer('CEPCON').AsString;
  End;

  If (blnReimpressao) Then
    strCodCli := '"REIMPRESSAO"'
  Else
    strCodCli := 'Codigo..: ' + CadCli('CODCLI').AsString;

  Imp('Cliente..: ' + fPadR(strNomCli, 38)                  + ' ' + strCodCli);
  Imp('Fantasia.: ' + fPadR(strFanSob, 38));
  Imp('Endereco.: ' + fPadR(strEndCli, 38)                  + ' Bairro..: ' + fPadR(strBaiCli, 18));
  Imp('Municipio: ' + fPadR(strCidCli, 38)                  + ' C.E.P...: ' + fPadR(strCepCli, 18));
  Imp('CGC/CPF..: ' + fPadR(strCgcCpf, 38)                  + ' IE/RG...: ' + fPadR(strIesRg, 18));
  Imp('Cnd. Pgto: ' + strConPag                             + ' Fone....: ' + fPadR(strTelCli, 18));
  If (VS_strUsaCnd = 'S') Then
    Imp('           ' + MovGer('CODCND').AsString + '-' + fRetDesConPag(MovGer('CODCND').AsString));
  Imp('Nat. Ope.: ' + fPadR(MovGer('NATOPE').AsString, 38)  + ' Cla.Fis.: ' + fPadR(strClaFis, 18));

  If (VS_strUsaFpg = 'S') Then
    Imp('Form.Pgto: ' + fPadR(strForPag, 67) + Cond_10CPI(True))
  Else
    Imp(Cond_10CPI(True));

  Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
  Imp('CODIGO  DESCRICAO / REFERENCIA                                                      SUBST.       UN           QTDE    VR.UNIT    VR.TOTAL');
  Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
  //  '1234567-123456789-123456789-123456789-123456789-123456789-12345-123456789-123456789-12345678-123456789-1234567-123456789-123456789'

end;

procedure TFatImpressao.pImprimeNFCab40Col;
  Var
    strCgcCpf: String;
    strConPag: String;
    strIesRg : String;
    strTelEmp: String;
    strForPag: String;
    strClaFis: String;
    strCodCli: String;
    strNomCli: String;
    strFanSob: String;
    strEndCli: String;
    strBaiCli: String;
    strCidCli: String;
    strCgcCli: String;
    strTelCli: String;
    strCepCli: String;
    blnImpFor: Boolean;
begin
  strCgcCpf   := '';

  If (fStatusCndPag(MovGer('CONPAG').AsString) = A_PRAZO) Then
    strConPag := fPadR(fFormataCondPag(MovGer('CONPAG').AsString), 48)
  Else
    strConPag := fPadR('A VISTA', 48);

  strForPag := IIF(VS_strUsaFpg <> 'S', '', MovGer('CODFPG').AsString + ' - ' + fRetDesFpg(MovGer('CODFPG').AsString));
  strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
  strIesRg  := IIF(CadCli('CGCCPF').AsInteger = 1, CadCli('I_E_S_').AsString, CadCli('NUMR_G').AsString);
  strTelEmp := 'FONE/FAX.: ' + CadEmp('FONE01').AsString;
  strRisco  := fReplicatorStr('-', 48);
  strClaFis := MovGer('CLAFIS').AsString +
               IIF(Not fEmptyStr(MovGer('CLAFI2').AsString), '/' + MovGer('CLAFI2').AsString, '') +
               IIF(Not fEmptyStr(MovGer('CLAFI3').AsString), '/' + MovGer('CLAFI3').AsString, '');

  {*******************************************}
  {* CONFIGURA O RELATÓRIO                   *}
  {****************************************AF*}
  Reseta;
  Imp(Cond_10CPI(True), False);
  Imp(CPI_12(True)    , False);
  Imp(Um_Oitavo(True) , False);
  
  {*******************************************}
  {* IMPRIME DADOS DA EMPRESA                *}
  {****************************************AF*}
  If (blnCabEmp) Then
  Begin
    Imp(fPadC(CadEmp('NOMEMP').AsString,48));
    Imp(fPadC(CadEmp('FONE01').AsString,48));
    Imp(fPadC(CadEmp('ENDERE').AsString + '-' + CadEmp('BAIRRO').AsString,48));
    Imp(fPadC(CadCli('NOMCID').AsString + '-' + CadCli('ESTADO').AsString,48));
    Imp(strRisco);
  End;

  Imp(Expandido(True), False);
  If (FEspDoc = 'NF') Then
    Imp('NOTA FISCAL ', False)

  Else If (FEspDoc = 'IF') And Not( FImpTck )  Then
    Imp('CUPOM FISCAL ', False)

  // EDUARDO
  Else If (FEspDoc = 'IF') And ( FImpTck )  Then
    Imp('TICKET CF - ', False);

    
  Imp('No ' + FNumDoc + Expandido(False));

  blnImpFor := False;
  If (Not fEmptyStr(MovGer('CODFOR').AsString)) Then
    blnImpFor := True;

  If (fEmptyStr(MovGer('NOMCON').AsString)) Then
  Begin
    strCodCli := CadCli('CODCLI').AsString;
    strNomCli := CadCli('NOMCLI').AsString;
    strFanSob := CadCli('FANSOB').AsString;
    strEndCli := CadCli('ENDERE').AsString;
    strBaiCli := CadCli('BAIRRO').AsString;
    strCidCli := CadCli('NOMCID').AsString;
    strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
    strTelCli := CadCli('FONE01').AsString;

    If (CadCli('CGCCPF').AsInteger = 1) Then
      strIesRg := CadCli('I_E_S_').AsString
    Else
      strIesRg := CadCli('NUMR_G').AsString;

    strCepCli := CadCli('C_E_P_').AsString;
  End
  Else
  Begin
    strCodCli := MovGer('CODCLI').AsString;
    strNomCli := MovGer('NOMCON').AsString;
    strFanSob := '';
    strEndCli := MovGer('ENDCON').AsString;
    strBaiCli := MovGer('BAICON').AsString;
    strCidCli := fRetNomCidade(MovGer('CIDCON').AsString, 0) + '-' + fRetNomCidade(MovGer('CIDCON').AsString, 1);
    strIesRg  := MovGer('R_GCON').AsString;
    strCgcCli := fFormataCpfCgc(MovGer('CGCCON').AsString);
    strTelCli := MovGer('TELCON').AsString;
    strCepCli := MovGer('CEPCON').AsString;
  End;

  Imp('');

  strCodCli := IIF(blnReimpressao, '"REIMPRESSAO"', 'Codigo...: ' + strCodCli);

  Imp(fPadR(strCodCli, 37));
  Imp('Cliente..: ' + fPadR(strNomCli, 37));
  Imp('Fantasia.: ' + fPadR(strFanSob, 37));
  Imp('Endereco.: ' + fPadR(strEndCli, 37));
  Imp('Bairro...: ' + fPadR(strBaiCli, 37));
  Imp('Municipio: ' + fPadR(strCidCli, 37));
  Imp('C.E.P....: ' + fPadR(strCepCli, 37));
  Imp('CGC/CPF..: ' + fPadR(strCgcCpf, 37));
  Imp('IE/RG....: ' + fPadR(strIesRg , 37));
  Imp('Fone.....: ' + fPadR(strTelCli, 37));
  Imp('Cnd. Pgto: ' + fPadR(strConPag, 37));

  If (VS_strUsaCnd = 'S') Then
    Imp('           ' + MovGer('CODCND').AsString + '-' + fRetDesConPag(MovGer('CODCND').AsString));

  Imp('Nat. Ope.: ' + fPadR(MovGer('NATOPE').AsString + ' Cla.Fis.: ' + strClaFis, 37));

  If (VS_strUsaFpg = 'S') Then
    Imp('Form.Pgto: ' + fPadR(strForPag, 37));

  Imp('-----------------------------------------------');
  Imp('COD.  DESCRICAO SUB UN   QTDE  VR.UNIT VR.TOTAL');
  Imp('-----------------------------------------------');
  //   12345-123456789 123456789 123456789 123456789 1
  //                   123-12-123456-12345678-12345678

end;

procedure TFatImpressao.pImprimeNFRod40Col;
  Var
    strVended: String;
    strDigita: String;
    intContador: Integer;
    strBasIcm: String;
    strIcmSub: String;
    strTotPro: String;
    strValIcm: String;
    strValFre: String;
    strValIpi: String;
    strDesEsp: String;
    strTotDoc: String;
begin

  {*******************************************}
  {* APLICA A DIGDUPLIC COM UM VALOR QUALQUER*}
  {* E DEPOIS PEGA OS VALORES DE "VPARXX"    *}
  {****************************************AF*}
  fDigDuplic(MovGer('CONPAG').AsString, 0, MovGer('VLRCON').AsFloat, False, False, False,
             MovGer('DTAENT').AsFloat, False);

  For intContador := 0 To 11 Do
  Begin
    If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
      Break;

    arrDuplicata[intContador].curValor := MovGer('VPAR' + fStrZero(intContador+1, 2)).AsFloat;
  End;

  strVended := MovGer('CODVEN').AsString + ' - ' + fRetNomVendRep(MovGer('CODVEN').AsString);
  strDigita := MovGer('CODDIG').AsString + ' - ' + fRetNomVendRep(MovGer('CODDIG').AsString);

  strBasIcm := fPadL(FloatToStrF(MovGer('BASICM').AsFloat, ffFixed, 12, 2), 08);
  strIcmSub := fPadL(FloatToStrF(MovGer('TOTRET').AsFloat, ffFixed, 12, 2), 08);
  strTotPro := fPadL(FloatToStrF(MovGer('TOTPRO').AsFloat, ffFixed, 12, 2), 08);
  strValIcm := fPadL(FloatToStrF(MovGer('TOTICM').AsFloat, ffFixed, 12, 2), 08);
  strValFre := fPadL(FloatToStrF(MovGer('TOTFRE').AsFloat, ffFixed, 12, 2), 08);
  strValIpi := fPadL(FloatToStrF(MovGer('TOTIPI').AsFloat, ffFixed, 12, 2), 08);
  strDesEsp := fPadL(FloatToStrF(MovGer('DESESP').AsFloat, ffFixed, 12, 2), 08);
  strTotDoc := fPadL(FloatToStrF(MovGer('VLRCON').AsFloat, ffFixed, 12, 2), 08);

  If (blnTemSer) And Not( FImpTck ) Then
  Begin
    Imp(fPadL('Tot Serv: %ISS: ' + FloatToStrF(MovGer('PERISS').AsFloat, ffFixed, 12, 2) + ' ' +
                  'Vr. ISS: ' + FloatToStrF(MovGer('VALISS').AsFloat, ffFixed, 12, 2) + ' ' +
                  'R$: ' + FloatToStrF(MovGer('TOTSER').AsFloat, ffFixed, 12, 2), 48));
  End;

  {*******************************************}
  {* IMPRIME OS IMPOSTOS                     *}
  {****************************************AF*}
  Imp('-----------------------------------------------');
  If Not( FImpTck )  Then
  Begin
    Imp(fPadR('Este Documento Nao Tem', 22),False);
    Imp(fPadL('Base ICMS.: ' + strBasIcm, 25));

    Imp(fPadR('   Validade Fiscal    ', 22),False);
    Imp(fPadL('Vr.Icms...: ' + strValIcm, 25));

    Imp(fPadR(' Peca Sua Nota Fiscal ', 22),False);
    Imp(fPadL('Vr.ICM Sub: ' + strIcmSub, 25));

    Imp(fPadL('Vr. Frete.: ' + strValFre, 47));
    Imp(fPadL('Vr. IPI...: ' + strValIpi, 47));
    Imp(fPadL('Desc.Esp..: ' + strDesEsp, 47));
    Imp(fPadL('TOT. PROD.: ' + strTotPro, 47));
    Imp(fPadL('TOTAL.....: ' + strTotDoc, 47));
  End
  Else
  Begin
    Imp(fPadR('Este Documento Nao Tem', 22),False);
    Imp(fPadL('Desc.Esp..: ' + strDesEsp, 25));

    Imp(fPadR('   Validade Fiscal    ', 22),False);
    Imp(fPadL('TOTAL.....: ' + strTotDoc, 25));

    Imp(fPadR(' Peca Sua Nota Fiscal ', 22));
  End;

  Imp('-----------------------------------------------');
  Imp(fPadR('Vendedor.: ' + strVended, 48));

  If (VS_strUsaDig = 'S') Then
    Imp(fPadR('Digitador: ' + strDigita, 48))
  Else
    Imp('');

  Imp(fPadR('Data: ' + MovGer('DTAENT').AsString, 16) + ' ' + fPadR('Hora: ' + MovGer('HORENT').AsString, 16));
  Imp(fPadR('Mensagem.: ' + MovGer('MEN001').AsString, 48));
  Imp(fPadR('           ' + MovGer('MEN002').AsString, 48));

  If (fStatusCndPag(MovGer('CONPAG').AsString) = A_VISTA) Then
  Begin
    Imp('');
    Imp('');
  End
  Else
  Begin

    For intContador := 0 To 11 Do
    Begin

      If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
      Begin
        Break;
      End;

      Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);

      If ((intContador + 1) Mod 2) = 0 Then
        Imp('');

    End;

  End;

  If (blnEntMat) Then
    Imp('ENTREGUE PELA MATRIZ');

  For intContador := 0 To VS_intQtdSal Do
  Begin
    Imp('');
  End;

end;

procedure TFatImpressao.pImprimeNFRod(blnTotal: Boolean);
  Var
    strVended: String;
    strDigita: String;
    intContador: Integer;
    strBasIcm: String;
    strIcmSub: String;
    strTotPro: String;
    strValIcm: String;
    strValFre: String;
    strValIpi: String;
    strDesEsp: String;
    strTotDoc: String;
begin

  If (blnTotal) And (intIteImp > intQtdFolOri) Then
  Begin
    For intContador := 1 To intQtdFolOri Do
    Begin
      Imp('');
    End;
  End
  Else
  Begin
    For intContador := intIteImp To intQtdFol Do
    Begin
      Imp('');
    End;
  End;

  If (blnTotal) Then
  Begin

    {*******************************************}
    {* APLICA A DIGDUPLIC COM UM VALOR QUALQUER*}
    {* E DEPOIS PEGA OS VALORES DE "VPARXX"    *}
    {****************************************MV*}
    fDigDuplic(MovGer('CONPAG').AsString, 0, MovGer('VLRCON').AsFloat, False, False, False,
               MovGer('DTAENT').AsFloat, False);

    For intContador := 0 To 11 Do
    Begin

      If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
      Begin
        Break;
      End;

      arrDuplicata[intContador].curValor := MovGer('VPAR' + fStrZero(intContador+1, 2)).AsFloat;

    End;

    strVended := MovGer('CODVEN').AsString + ' - ' + fRetNomVendRep(MovGer('CODVEN').AsString); //melhorar isso aqui
    strDigita := MovGer('CODDIG').AsString + ' - ' + fRetNomVendRep(MovGer('CODDIG').AsString); //melhorar isso aqui

    strBasIcm := fPadL(FloatToStrF(MovGer('BASICM').AsFloat, ffFixed, 12, 2), 10);
    strIcmSub := fPadL(FloatToStrF(MovGer('TOTRET').AsFloat, ffFixed, 12, 2), 10);
    strTotPro := fPadL(FloatToStrF(MovGer('TOTPRO').AsFloat, ffFixed, 12, 2), 10);
    strValIcm := fPadL(FloatToStrF(MovGer('TOTICM').AsFloat, ffFixed, 12, 2), 10);
    strValFre := fPadL(FloatToStrF(MovGer('TOTFRE').AsFloat, ffFixed, 12, 2), 10);
    strValIpi := fPadL(FloatToStrF(MovGer('TOTIPI').AsFloat, ffFixed, 12, 2), 10);
    strDesEsp := fPadL(FloatToStrF(MovGer('DESESP').AsFloat, ffFixed, 12, 2), 10);
    strTotDoc := fPadL(FloatToStrF(MovGer('VLRCON').AsFloat, ffFixed, 12, 2), 10);

    If (blnTemSer) And Not( FImpTck ) Then
    Begin
      Imp(fPadL('Total de Servicos: % ISS: ' + FloatToStrF(MovGer('PERISS').AsFloat, ffFixed, 12, 2) + '          ' +
                    'Vr. ISS: ' + FloatToStrF(MovGer('VALISS').AsFloat, ffFixed, 12, 2) + '          ' +
                    'R$: ' + FloatToStrF(MovGer('TOTSER').AsFloat, ffFixed, 12, 2), 137));
    End;

    {*******************************************}
    {* IMPRIME OS IMPOSTOS                     *}
    {****************************************MV*}
    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');

    If Not( FImpTck )  Then
    Begin
      Imp(fPadL('Base ICMS.: ' + strBasIcm + '   Vr. ICM Sub.: ' + strIcmSub + '   TOT. PROD.: ' + strTotPro, 137));
      Imp(fPadL('Vr.Icms...: ' + strValIcm + '   Vr. Frete...: ' + strValFre + '   Vr. IPI...: ' + strValIpi, 137));
    End;

    Imp(fPadL('                          Desconto Especial.: ' + strDesEsp + '   TOTAL.....: ' + strTotDoc, 137));
    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    Imp(fPadR('Vendedor.: ' + strVended, 121)                  + fPadR('Data: '   + MovGer('DTAENT').AsString, 16));

    If (VS_strUsaDig = 'S') Then
      Imp(fPadR('Digitador: ' + strDigita, 137))
    Else
      Imp('');

    Imp(fPadR('Mensagem.: ' + MovGer('MEN001').AsString, 121)  + fPadR('Hora:   ' + MovGer('HORENT').AsString, 16));
    Imp(fPadR('           ' + MovGer('MEN002').AsString, 137));

    If (fStatusCndPag(MovGer('CONPAG').AsString) = A_VISTA) Then
    Begin
      Imp('');
      Imp('');
    End
    Else
    Begin

      For intContador := 0 To 5 Do
      Begin

        If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
        Begin
          Break;
        End;

        Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                  arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                  fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);
      End;
        
      Imp('');

      For intContador := 6 To 11 Do
      Begin

        If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
        Begin
          Break;
        End;

        Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                  arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                  fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);
      End;

    End;

    If (blnEntMat) Then
      Imp('ENTREGUE PELA MATRIZ');

    Imp('');

  End
  Else
  Begin
    Imp('IMPRESSAO CONTINUA NA PROXIMA PAGINA');
  End;

  Eject;

end;

procedure TFatImpressao.pImprimeOR;
begin

  If strColRel = '80' Then
    pImprimePDGenerico
  Else
    pImprimePDGenerico40Col;
    
end;

procedure TFatImpressao.pImprimePD;
begin

  If strColRel = '80' Then
    pImprimePDGenerico
  Else
    pImprimePDGenerico40Col;
  
end;

procedure TFatImpressao.pImprimePI;
begin

  If strColRel = '80' Then
    pImprimeFFGenerico
  Else
    pImprimeFFGenerico40Col;
    
end;

procedure TFatImpressao.pImprimeTE;
begin

  If strColRel = '80' Then
    pImprimeFFGenerico
  Else
    pImprimeFFGenerico40Col;

end;

procedure TFatImpressao.pImprimeTR;
begin

  If strColRel = '80' Then
    pImprimeTRGenerico
  Else
    pImprimeTRGenerico40Col;
    
end;

procedure TFatImpressao.pImprimeFFGenerico;
  Var
    intQtdDiv: Integer;
begin

  If Pos(FEspDoc, VS_strNaoCab) > 0 Then
  Begin
    blnCabEmp    := False;
    intQtdFol    := 18;
    intQtdFolOri := 18;
    intQtdAdc    := 8;
  End
  Else
  Begin
    blnCabEmp    := True;
    intQtdFol    := 13;
    intQtdFolOri := 13;
    intQtdAdc    := 8;
  End;

  If (blnTemSer) Then
  Begin
    Dec(intQtdFol, 2);
    Dec(intQtdFolOri, 2);
  End;

  If (VS_strUsaCnd = 'S') Then
  Begin
    Dec(intQtdFol, 1);
    Dec(intQtdFolOri, 1);
  End;

  blnEntMat := False;
  If (MovGer('CONENT').AsString = 'S') And (Not VS_blnEmpGer) Then
  Begin
    Dec(intQtdFol, 1);
    Dec(intQtdFolOri, 1);
    blnEntMat := True;
  End;

  intQtdPag := 1;

  If (qryRelatorio.RecordCount > intQtdFol) Then
  Begin
    intQtdDiv := qryRelatorio.RecordCount - intQtdFol;
    intQtdPag := (intQtdDiv Div (intQtdFol + intQtdAdc));
    //If (intQtdPag > 0) Then
    //Begin
      If (intQtdDiv / (intQtdFol + intQtdAdc) > intQtdPag) Then
        Inc(intQtdPag);
    //End;
    Inc(intQtdPag);

  End;

  qryRelatorio.First;
  intIteImp    := 0;
  intTotIteImp := 0;

  With qryRelatorio Do
  Begin
    While (Not Eof) Do
    Begin

      If (intIteImp = 0) Or (intIteImp >= intQtdFol) Then
      Begin

        If (intIteImp = 0) Or (intQtdFol + intQtdAdc > intQtdFolOri + intQtdAdc) Then
        Begin
          pImprimeFFCabGenerico;
          If (intIteImp > 0) Then
            Dec(intQtdFol, intQtdAdc);

          intIteImp := 0;
        End
        Else
        Begin
          If (intTotIteImp >= qryRelatorio.RecordCount) Then
          Begin
            pImprimeFFCabGenerico;
            intIteImp := 0;
            Break;
          End
          Else
            Inc(intQtdFol, intQtdAdc);
        End;
      End;

      Imp(fPadR(FieldByName('CODITE').AsString, 08) +
          fPadR(FieldByName('DESITE').AsString, IIF(fEmptyStr(FieldByName('CODITE').AsString), 121, 61)) +
          fPadR(FieldByName('DESMAR').AsString, 29) +
          fPadR(FieldByName('UNIDAD').AsString, 08) +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 3)), 08) +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString) Or (Not blnImpPre), '', FloatToStrf(FieldByName('VALUNI').AsFloat, ffFixed, 12, 4)), 11) +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString) Or (Not blnImpPre), '', FloatToStrf(FieldByName('VALITE').AsFloat, ffFixed, 12, 2)), 11));
      Inc(intIteImp);
      Inc(intTotIteImp);

      Next;
    End;
  End;

  If (intIteImp > intQtdFolOri) Then
  Begin
    pImprimeFFCabGenerico;
  End;

  pImprimeFFRodGenerico(True);

end;

{************************}
{* IMPRESSÃO 40 COLUNAS *}
{*********************AF*}
procedure TFatImpressao.pImprimeFFGenerico40Col;
begin

  If Pos(FEspDoc, VS_strNaoCab) > 0 Then
    blnCabEmp := False
  Else
    blnCabEmp := True;

  blnEntMat := False;
  If (MovGer('CONENT').AsString = 'S') And (Not VS_blnEmpGer) Then
    blnEntMat := True;

  qryRelatorio.First;

  {***********************}
  {* IMPRIME O CABEÇALHO *}
  {********************AF*}
  pImprimeFFCabGenerico40Col;

  {***********************}
  {* IMPRIME OS PRODUTOS *}
  {********************AF*}
  With qryRelatorio Do
  Begin
    While (Not Eof) Do
    Begin

      Imp(fPadR(FieldByName('CODITE').AsString, 05) + ' ' +
          fPadR(FieldByName('DESITE').AsString, 40));
      Imp(fPadL(FieldByName('UNIDAD').AsString, 18) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 2)), 06) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString) Or (Not blnImpPre), '', FloatToStrf(FieldByName('VALUNI').AsFloat, ffFixed, 12, 2)), 10) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString) Or (Not blnImpPre), '', FloatToStrf(FieldByName('VALITE').AsFloat, ffFixed, 12, 2)), 10));
      
      Next;
    End;
  End;

  pImprimeFFRodGenerico40Col;

end;

{*************************************}
{* IMPRIME O CABEÇALHO DE 40 COLUNAS *}
{**********************************AF*}
procedure TFatImpressao.pImprimeFFCabGenerico40Col;
  Var
    strCgcCpf: String;
    strConPag: String;
    strIesRg : String;
    strTelEmp: String;
    strForPag: String;
    strCodCli: String;
    strNomCli: String;
    strFanSob: String;
    strEndCli: String;
    strBaiCli: String;
    strCidCli: String;
    strCgcCli: String;
    strTelCli: String;
    strCepCli: String;
begin
  strCgcCpf   := '';

  If (FEspDoc = 'BR') Then
    blnImpPre := (VS_strUniBri <> 'S')

  Else If (FDocSep) Then
    blnImpPre := False;

  {**************************************}
  {* MONTA CONDIÇÃO DE PAGAMENTO COND   *}
  {***********************************AF*}
  If (fStatusCndPag(MovGer('CONPAG').AsString) = A_PRAZO) Then
    strConPag := fFormataCondPag(MovGer('CONPAG').AsString)
  Else
    strConPag := 'A VISTA';

  strForPag := IIF(VS_strUsaFpg <> 'S', '', MovGer('CODFPG').AsString + ' - ' + fRetDesFpg(MovGer('CODFPG').AsString));
  strTelEmp := 'FONE/FAX.: ' + CadEmp('FONE01').AsString;
  strRisco  := fReplicatorStr('-', 48);

  {*************************}
  {* CONFIGURA O RELATÓRIO *}
  {**********************AF*}
  Reseta;
  Imp(Cond_10CPI(True), False);
  Imp(CPI_12(True)    , False);
  Imp(Um_Oitavo(True) , False);

  {*******************************************}
  {* IMPRIME DADOS DA EMPRESA                *}
  {****************************************AF*}
  If (blnCabEmp) Then
  Begin
    Imp(fPadC(CadEmp('NOMEMP').AsString,48));
    Imp(fPadC(CadEmp('FONE01').AsString,48));
    Imp(fPadC(CadEmp('ENDERE').AsString + ', ' + CadEmp('ENDNUM').AsString + '-' + CadEmp('BAIRRO').AsString,48));
    Imp(fPadC(CadCli('NOMCID').AsString + '-' + CadCli('ESTADO').AsString,48));
    Imp(strRisco);
  End;

  Imp(Expandido(True), False);
  If (FDocSep) Then
  Begin
    Imp('SEPARACAO - ' + FNumDoc + '-' + FEspDoc + Expandido(False))
  End
  Else
  Begin

    If (FEspDoc = 'NF') Then
      Imp('NOTA FISCAL', False)

    Else If (FEspDoc = 'IF') Then
      Imp('CUPOM FISCAL', False)

    Else If (FEspDoc = 'MI') Then
      Imp('MI ', False)

    Else If (FEspDoc = 'FF') Then
      Imp('FAT. FUTURO ', False)

    Else If (FEspDoc = 'TE') Then
      Imp('TRANSF. ESTOQUE ', False)

    Else If (FEspDoc = 'PI') Then
      Imp('PIGMENTO ', False)

    Else If (FEspDoc = 'BR') Then
      Imp('BRINDE ', False);

    Imp('No ' + FNumDoc + Expandido(False));
  End;

  If (fEmptyStr(MovGer('NOMCON').AsString)) Then
  Begin
    strCodCli := CadCli('CODCLI').AsString;
    strNomCli := CadCli('NOMCLI').AsString;
    strFanSob := CadCli('FANSOB').AsString;
    strEndCli := CadCli('ENDERE').AsString;
    strBaiCli := CadCli('BAIRRO').AsString;
    strCidCli := CadCli('NOMCID').AsString;
    strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
    strTelCli := CadCli('FONE01').AsString;

    If (CadCli('CGCCPF').AsInteger = 1) Then
      strIesRg := CadCli('I_E_S_').AsString
    Else
      strIesRg := CadCli('NUMR_G').AsString;

    strCepCli := CadCli('C_E_P_').AsString;
  End
  Else
  Begin
    strCodCli := MovGer('CODCLI').AsString;
    strNomCli := MovGer('NOMCON').AsString;
    strFanSob := '';
    strEndCli := MovGer('ENDCON').AsString;
    strBaiCli := MovGer('BAICON').AsString;
    strCidCli := fRetNomCidade(MovGer('CIDCON').AsString, 0) + '-' + fRetNomCidade(MovGer('CIDCON').AsString, 1);
    strIesRg  := MovGer('R_GCON').AsString;
    strCgcCli := fFormataCpfCgc(MovGer('CGCCON').AsString);
    strTelCli := MovGer('TELCON').AsString;
    strCepCli := MovGer('CEPCON').AsString;
  End;

  Imp('');

  strCodCli := IIF(blnReimpressao, '"REIMPRESSAO"', 'Codigo..: ' + strCodCli);

  Imp(strCodCli);
  Imp('Cliente..: ' + fPadR(strNomCli, 37));
  Imp('Fantasia.: ' + fPadR(strFanSob, 37));
  Imp('Endereco.: ' + fPadR(strEndCli, 37));
  Imp('Bairro...: ' + fPadR(strBaiCli, 37));
  Imp('C.E.P....: ' + fPadR(strCepCli, 37));
  Imp('Municipio: ' + fPadR(strCidCli, 37));
  Imp('CGC/CPF..: ' + fPadR(strCgcCpf, 37));
  Imp('IE/RG....: ' + fPadR(strIesRg , 37));
  Imp('Fone.....: ' + fPadR(strTelCli, 37));
  Imp('Cnd. Pgto: ' + fPadR(strConPag, 37));

  If (VS_strUsaCnd = 'S') Then
    Imp('Cnd. Pgto: ' + MovGer('CODCND').AsString + '-' + fRetDesConPag(MovGer('CODCND').AsString));

  If (VS_strUsaFpg = 'S') Then
    Imp('Form.Pgto: ' + fPadR(strForPag, 48));

  Imp('-----------------------------------------------');
  Imp('COD.  DESCRICAO UN    QTD   ' + IIF(blnImpPre, 'VR.UNIT    VR.TOTAL', ''));
  Imp('-----------------------------------------------');
  //     12345-123456789 123456789 123456789 -123456789
  //                     12-123456-123456789 -123456789

end;

{**************************************}
{* IMPRIME RODAPÉ DE 40 COLUNAS       *}
{***********************************AF*}
procedure TFatImpressao.pImprimeFFRodGenerico40Col;
  Var
    strVended: String;
    strDigita: String;
    strDebCli: String;
    intContador: Integer;
begin

  {*******************************************}
  {* APLICA A DIGDUPLIC COM UM VALOR QUALQUER*}
  {* E DEPOIS PEGA OS VALORES DE "VPARXX"    *}
  {****************************************AF*}
  fDigDuplic(MovGer('CONPAG').AsString, 0, MovGer('VLRCON').AsFloat, False, False, False,
             MovGer('DTAENT').AsFloat, False);

  For intContador := 0 To 11 Do
  Begin

    If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
    Begin
      Break;
    End;

    arrDuplicata[intContador].curValor := MovGer('VPAR' + fStrZero(intContador+1, 2)).AsFloat;

  End;

  strVended := MovGer('CODVEN').AsString + ' - ' + fRetNomVendRep(MovGer('CODVEN').AsString);
  strDigita := MovGer('CODDIG').AsString + ' - ' + fRetNomVendRep(MovGer('CODDIG').AsString);

  If (blnTemSer) Then
  Begin
    Imp(fPadL('Tot Serv: %ISS: ' + FloatToStrF(MovGer('PERISS').AsFloat, ffFixed, 12, 2) + ' ' +
                  'Vr. ISS: ' + FloatToStrF(MovGer('VALISS').AsFloat, ffFixed, 12, 2) + ' ' +
                  'R$: ' + FloatToStrF(MovGer('TOTSER').AsFloat, ffFixed, 12, 2), 48));
  End;

  If (blnImpPre) Then
  Begin
    Imp('-----------------------------------------------');

    If (fltDebCli <= 0) Then
      strDebCli := ''
    Else
      strDebCli := 'Debitos do Cliente: ' + FloatToStrF(fltDebCli + MovGer('VLRCON').AsFloat, ffFixed, 12, 2);

    Imp(fPadR('Este Documento Nao Tem', 22),False);
    Imp(fPadL('Desconto: ' + FloatToStrF(MovGer('PORDES').AsFloat, ffFixed, 12, 2),25));

    Imp(fPadR('   Validade Fiscal    ', 22),False);
    Imp(fPadL('Desconto Especial: ' + FloatToStrF(MovGer('DESESP').AsFloat, ffFixed, 12, 2),25));

    Imp(fPadR(' Peca Sua Nota Fiscal ', 22),False);
    Imp(fPadL('TOTAL: ' + FloatToStrF(MovGer('VLRCON').AsFloat, ffFixed, 12, 2),25));

    Imp(fPadL(strDebCli,48));

  End
  Else If (FDocSep) Then
  Begin
    Imp(fPadR('ENTREGA: ',48));
    Imp(fPadR(IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('ENDERE').AsString, CadCli('ENDENT').AsString),48));
    Imp(fPadR(IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('BAIRRO').AsString, CadCli('BAIENT').AsString),48));
    Imp(fPadR(CadCli('NCIDEN').AsString + ' - ' + CadCli('NESTEN').AsString, 48));
  End
  Else
  Begin
    Imp('');
  End;

  Imp('-----------------------------------------------');
  Imp(fPadR('Vendedor.: ' + strVended, 48));

  If (VS_strUsaDig = 'S') Then
    Imp(fPadR('Digitador: ' + strDigita, 48))
  Else
    Imp('');

  Imp(fPadR('Data: ' + MovGer('DTAENT').AsString, 16) + ' ' + fPadR('Hora: ' + MovGer('HORENT').AsString, 16));
  Imp(fPadR('Mensagem.: ' + MovGer('MEN001').AsString, 48));
  Imp(fPadR('           ' + MovGer('MEN002').AsString, 48));

  If (fStatusCndPag(MovGer('CONPAG').AsString) = A_VISTA) Then
  Begin
    Imp('');
    Imp('');
  End
  Else
  Begin

//    fDigDuplic(MovGer('CONPAG').AsString, 0, MovGer('VLRCON').AsFloat, False, False, False,
//               MovGer('DTAENT').AsFloat, False);

    For intContador := 0 To 11 Do
    Begin

      If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
      Begin
        Break;
      End;

      Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);

      If ((intContador + 1) Mod 2) = 0 Then
        Imp('');

    End;

  End;

  If (blnEntMat) Then
    Imp('ENTREGUE PELA MATRIZ');

  For intContador := 0 To VS_intQtdSal Do
  Begin
    Imp('');
  End;

  //Eject;

end;

procedure TFatImpressao.pImprimeFFCabGenerico;
  Var
    strControle: String;
    strCgcCpf: String;
    strConPag: String;
    strIesRg: String;
    strTelEmp: String;
    strForPag: String;
    strCodCli: String;
    strNomCli: String;
    strFanSob: String;
    strEndCli: String;
    strBaiCli: String;
    strCidCli: String;
    strCgcCli: String;
    strTelCli: String;
    strCepCli: String;
begin
  strControle := '';
  strCgcCpf   := '';

  If (FEspDoc = 'BR') Then
    blnImpPre := (VS_strUniBri <> 'S')
  Else If (FDocSep) Then
    blnImpPre := False;

  Inc(intPagina);

  strControle := IntToStr(intPagina) + '/' + IntToStr(intQtdPag);

  If intPagina > 1 Then
  Begin
    pImprimeFFRodGenerico(False);
    intLinImp := 0;
  End;

  If (fStatusCndPag(MovGer('CONPAG').AsString) = A_PRAZO) Then
  Begin
    strConPag := Cond_10CPI(True) + fPadR(fFormataCondPag(MovGer('CONPAG').AsString), 69) + Cond_10CPI(False);
  End
  Else
  Begin
    strConPag := Cond_10CPI(True) + fPadR('A VISTA', 69) + Cond_10CPI(False);
  End;

  strForPag := IIF(VS_strUsaFpg <> 'S', '', MovGer('CODFPG').AsString + ' - ' + fRetDesFpg(MovGer('CODFPG').AsString));

  strTelEmp := 'FONE/FAX.: ' + CadEmp('FONE01').AsString;
  strRisco  := fReplicatorStr('-', 80);

  {*******************************************}
  {* CONFIGURA O RELATÓRIO                   *}
  {****************************************MV*}
  Reseta;
  Imp(Cond_10CPI(False), False);
  Imp(CPI_12(False), False);
  Imp(Um_Oitavo(True), False);
  Imp(TamPag(43), False);

  {*******************************************}
  {* IMPRIME DADOS DA EMPRESA                *}
  {****************************************MV*}
  If (blnCabEmp) Then
  Begin
    Imp(Expandido(True) + CadEmp('NOMEMP').AsString + Expandido(False));
    Imp(Expandido(True) + fPadR(CadEmp('FONE01').AsString, 74) + Expandido(False) + fPadR(strControle, 5));
    Imp('Cidade..: ' + fPadR(CadEmp('NOMCID').AsString + '-' + CadEmp('ESTADO').AsString , 40) + 'Bairro.: ' + fPadR(CadEmp('BAIRRO').AsString, 18));
    Imp('Endereco: ' + fPadR(CadEmp('ENDERE').AsString + ', ' + CadEmp('ENDNUM').AsString, 40) + 'Cep....: ' + fPadR(CadEmp('C_E_P_').AsString, 18));
    Imp(strRisco);
    strControle := '';
  End;

  Imp(Expandido(True), False);
  If (FDocSep) Then
  Begin
    Imp('SEPARACAO - ' + FNumDoc + '-' + FEspDoc + Expandido(False), blnCabEmp)
  End
  Else
  Begin
    If (FEspDoc = 'NF') Then
      Imp('NOTA FISCAL', False)
    Else If (FEspDoc = 'IF') Then
      Imp('CUPOM FISCAL', False)
    Else If (FEspDoc = 'MI') Then
      Imp('MI ', False)
    Else If (FEspDoc = 'FF') Then
      Imp('FAT. FUTURO ', False)
    Else If (FEspDoc = 'TE') Then
      Imp('TRANSF. ESTOQUE ', False)
    Else If (FEspDoc = 'PI') Then
      Imp('PIGMENTO ', False)
    Else If (FEspDoc = 'BR') Then
      Imp('BRINDE ', False);

    Imp('No ' + FNumDoc + Expandido(False), blnCabEmp);
  End;

  If (Not blnCabEmp) Then
  Begin
    Imp(fPadL(strControle, 10));
  End;

  If (fEmptyStr(MovGer('NOMCON').AsString)) Then
  Begin
    strCodCli := CadCli('CODCLI').AsString;
    strNomCli := CadCli('NOMCLI').AsString;
    strFanSob := CadCli('FANSOB').AsString;
    strEndCli := CadCli('ENDERE').AsString;
    strBaiCli := CadCli('BAIRRO').AsString;
    strCidCli := CadCli('NOMCID').AsString;
    strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
    strTelCli := CadCli('FONE01').AsString;
    If (CadCli('CGCCPF').AsInteger = 1) Then
    Begin
      strIesRg := CadCli('I_E_S_').AsString;
    End
    Else
    Begin
      strIesRg := CadCli('NUMR_G').AsString;
    End;
    strCepCli := CadCli('C_E_P_').AsString;
  End
  Else
  Begin
    strCodCli := MovGer('CODCLI').AsString;
    strNomCli := MovGer('NOMCON').AsString;
    strFanSob := '';
    strEndCli := MovGer('ENDCON').AsString;
    strBaiCli := MovGer('BAICON').AsString;
    strCidCli := fRetNomCidade(MovGer('CIDCON').AsString, 0) + '-' + fRetNomCidade(MovGer('CIDCON').AsString, 1);
    strIesRg  := MovGer('R_GCON').AsString;
    strCgcCli := fFormataCpfCgc(MovGer('CGCCON').AsString);
    strTelCli := MovGer('TELCON').AsString;
    strCepCli := MovGer('CEPCON').AsString;
  End;

  If (blnReimpressao) Then
    strCodCli := '"REIMPRESSAO"'
  Else
    strCodCli := 'Codigo..: ' + strCodCli;

  Imp('Cliente..: ' + fPadR(strNomCli, 40)        + ' ' + strCodCli);
  Imp('Fantasia.: ' + fPadR(strFanSob, 40));
  Imp('Endereco.: ' + fPadR(strEndCli, 40)        + ' Bairro: ' + fPadR(strBaiCli, 18));
  Imp('Municipio: ' + fPadR(strCidCli, 40)        + ' C.E.P.: ' + fPadR(strCepCli, 18));
  Imp('CGC/CPF..: ' + fPadR(strCgcCpf, 40)        + ' IE/RG.: ' + fPadR(strIesRg, 18));
  Imp('Cnd. Pgto: ' + strConPag                   + ' Fone..: ' + fPadR(strTelCli, 18));

  If (VS_strUsaCnd = 'S') Then
    Imp('           ' + MovGer('CODCND').AsString + '-' + fRetDesConPag(MovGer('CODCND').AsString));

  If (VS_strUsaFpg = 'S') Then
    Imp('Form.Pgto: ' + fPadR(strForPag, 69) + Cond_10CPI(True))
  Else
    Imp(Cond_10CPI(True));

  Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
  Imp('CODIGO  DESCRICAO / REFERENCIA                                       MARCA                       UN           QTDE    ' + IIF(blnImpPre, 'VR.UNIT    VR.TOTAL', ''));
  Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
  //  '1234567-123456789-123456789-123456789-123456789-123456789-12345-123456789-123456789-12345678-123456789-1234567-123456789-123456789'

end;

procedure TFatImpressao.pImprimeFFRodGenerico(blnTotal: Boolean);
  Var
    strVended: String;
    strDigita: String;
    strDebCli: String;
    intContador: Integer;
begin

  If (blnTotal) And (intIteImp > intQtdFolOri) Then
  Begin
    For intContador := 1 To intQtdFolOri Do
    Begin
      Imp('');
    End;
  End
  Else
  Begin
    For intContador := intIteImp To intQtdFol Do
    Begin
      Imp('');
    End;
  End;

  If (blnTotal) Then
  Begin

    {*******************************************}
    {* APLICA A DIGDUPLIC COM UM VALOR QUALQUER*}
    {* E DEPOIS PEGA OS VALORES DE "VPARXX"    *}
    {****************************************MV*}
    fDigDuplic(MovGer('CONPAG').AsString, 0, MovGer('VLRCON').AsFloat, False, False, False,
               MovGer('DTAENT').AsFloat, False);

    For intContador := 0 To 11 Do
    Begin

      If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
      Begin
        Break;
      End;

      arrDuplicata[intContador].curValor := MovGer('VPAR' + fStrZero(intContador+1, 2)).AsFloat;

    End;

    strVended := MovGer('CODVEN').AsString + ' - ' + fRetNomVendRep(MovGer('CODVEN').AsString); //melhorar isso aqui
    strDigita := MovGer('CODDIG').AsString + ' - ' + fRetNomVendRep(MovGer('CODDIG').AsString); //melhorar isso aqui

    If (blnTemSer) Then
    Begin
      Imp(fPadL('Total de Servicos: % ISS: ' + FloatToStrF(MovGer('PERISS').AsFloat, ffFixed, 12, 2) + '          ' +
                    'Vr. ISS: ' + FloatToStrF(MovGer('VALISS').AsFloat, ffFixed, 12, 2) + '          ' +
                    'R$: ' + FloatToStrF(MovGer('TOTSER').AsFloat, ffFixed, 12, 2), 137));
    End;

    If (blnImpPre) Then
    Begin
      Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
      If (fltDebCli <= 0) Then
      Begin
        strDebCli := '';
      End
      Else
      Begin
        strDebCli := 'Debitos do Cliente: ' + FloatToStrF(fltDebCli + MovGer('VLRCON').AsFloat, ffFixed, 12, 2) +
                     '          ';
      End;
      Imp(fPadL(strDebCli +
                'Desconto: ' + FloatToStrF(MovGer('PORDES').AsFloat, ffFixed, 12, 2) + '          ' +
                'Desconto Especial: ' + FloatToStrF(MovGer('DESESP').AsFloat, ffFixed, 12, 2) + '          ' +
                'TOTAL: ' + FloatToStrF(MovGer('VLRCON').AsFloat, ffFixed, 12, 2), 137));
    End
    Else If (FDocSep) Then
    Begin
      Imp(fPadL('ENTREGA: ' +
                IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('ENDERE').AsString, CadCli('ENDENT').AsString) + ' - ' +
                IIF(fEmptyStr(CadCli('ENDENT').AsString), CadCli('BAIRRO').AsString, CadCli('BAIENT').AsString) + ' - ' +
                CadCli('NCIDEN').AsString + ' - ' +
                CadCli('NESTEN').AsString, 137));
    End
    Else
    Begin
      Imp('');
    End;

    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    Imp(fPadR('Vendedor.: ' + strVended, 121)                  + fPadR('Data: '   + MovGer('DTAENT').AsString, 16));

    If (VS_strUsaDig = 'S') Then
      Imp(fPadR('Digitador: ' + strDigita, 137))
    Else
      Imp('');

    Imp(fPadR('Mensagem.: ' + MovGer('MEN001').AsString, 121)  + fPadR('Hora:   ' + MovGer('HORENT').AsString, 16));
    Imp(fPadR('           ' + MovGer('MEN002').AsString, 137));

    If (fStatusCndPag(MovGer('CONPAG').AsString) = A_VISTA) Then
    Begin
      Imp('');
      Imp('');
    End
    Else
    Begin

//      fDigDuplic(MovGer('CONPAG').AsString, 0, MovGer('VLRCON').AsFloat, False, False, False,
//                 MovGer('DTAENT').AsFloat, False);

      For intContador := 0 To 5 Do
      Begin

        If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
        Begin
          Break;
        End;

        Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                  arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                  fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);
      End;

      Imp('');

      For intContador := 6 To 11 Do
      Begin

        If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
        Begin
          Break;
        End;

        Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                  arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                  fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);
      End;

    End;

    If (blnEntMat) Then
      Imp('ENTREGUE PELA MATRIZ');

    Imp('');

  End
  Else
  Begin
    Imp('IMPRESSAO CONTINUA NA PROXIMA PAGINA');
  End;

  Eject;


end;

procedure TFatImpressao.pImprimeTRCabGenerico;
  Var
    strControle: String;
    strCgcCpf: String;
    strConPag: String;
    strIesRg: String;
    strTelEmp: String;
    strForPag: String;
    strCodCli: String;
    strNomCli: String;
    strFanSob: String;
    strEndCli: String;
    strBaiCli: String;
    strCidCli: String;
    strCgcCli: String;
    strTelCli: String;
    strCepCli: String;
begin
  strControle := '';
  strCgcCpf   := '';

  Inc(intPagina);

  strControle := IntToStr(intPagina) + '/' + IntToStr(intQtdPag);

  If intPagina > 1 Then
  Begin
    pImprimeTRRodGenerico(False);
    intLinImp := 0;
  End;

  If (fStatusCndPag(MovGer('CONPAG').AsString) = A_PRAZO) Then
  Begin
    strConPag := Cond_10CPI(True) + fPadR(fFormataCondPag(MovGer('CONPAG').AsString), 69) + Cond_10CPI(False);
  End
  Else
  Begin
    strConPag := Cond_10CPI(True) + fPadR('A VISTA', 69) + Cond_10CPI(False);
  End;

  strForPag := IIF(VS_strUsaFpg <> 'S', '', MovGer('CODFPG').AsString + ' - ' + fRetDesFpg(MovGer('CODFPG').AsString));

  strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
  If (CadCli('CGCCPF').AsInteger = 1) Then
  Begin
    strIesRg := CadCli('I_E_S_').AsString;
  End
  Else
  Begin
    strIesRg := CadCli('NUMR_G').AsString;
  End;

  strTelEmp := 'FONE/FAX.: ' + CadEmp('FONE01').AsString;
  strRisco  := fReplicatorStr('-', 80);

  {*******************************************}
  {* CONFIGURA O RELATÓRIO                   *}
  {****************************************MV*}
  Reseta;
  Imp(Cond_10CPI(False), False);
  Imp(CPI_12(False), False);
  Imp(Um_Oitavo(True), False);
  Imp(TamPag(43), False);

  {*******************************************}
  {* IMPRIME DADOS DA EMPRESA                *}
  {****************************************MV*}
  If (blnCabEmp) Then
  Begin
    Imp(Expandido(True) + CadEmp('NOMEMP').AsString + Expandido(False));
    Imp(Expandido(True) + fPadR(CadEmp('FONE01').AsString, 74) + Expandido(False) + fPadR(strControle, 5));
    Imp('Cidade..: ' + fPadR(CadEmp('NOMCID').AsString + '-' + CadEmp('ESTADO').AsString , 40) + 'Bairro.: ' + fPadR(CadEmp('BAIRRO').AsString, 18));
    Imp('Endereco: ' + fPadR(CadEmp('ENDERE').AsString + ', ' + CadEmp('ENDNUM').AsString, 40) + 'Cep....: ' + fPadR(CadEmp('C_E_P_').AsString, 18));
    Imp(strRisco);
    strControle := '';
  End;

  Imp(Expandido(True), False);
  If (FEspDoc = 'TR') Then
    Imp('TROCA ', False)
  Else If (FEspDoc = 'DV') Then
    Imp('DEVOLUCAO ', False)
  Else If (FEspDoc = 'AJ') Then
    Imp('AJUSTE ', False);

  Imp('No ' + FNumDoc + Expandido(False), blnCabEmp);

  If (Not blnCabEmp) Then
  Begin
    Imp(fPadL(strControle, 10));
  End;

  If (fEmptyStr(MovGer('NOMCON').AsString)) Then
  Begin
    strCodCli := CadCli('CODCLI').AsString;
    strNomCli := CadCli('NOMCLI').AsString;
    strFanSob := CadCli('FANSOB').AsString;
    strEndCli := CadCli('ENDERE').AsString;
    strBaiCli := CadCli('BAIRRO').AsString;
    strCidCli := CadCli('NOMCID').AsString;
    strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
    strTelCli := CadCli('FONE01').AsString;
    If (CadCli('CGCCPF').AsInteger = 1) Then
    Begin
      strIesRg := CadCli('I_E_S_').AsString;
    End
    Else
    Begin
      strIesRg := CadCli('NUMR_G').AsString;
    End;
    strCepCli := CadCli('C_E_P_').AsString;
  End
  Else
  Begin
    strCodCli := MovGer('CODCLI').AsString;
    strNomCli := MovGer('NOMCON').AsString;
    strFanSob := '';
    strEndCli := MovGer('ENDCON').AsString;
    strBaiCli := MovGer('BAICON').AsString;
    strCidCli := fRetNomCidade(MovGer('CIDCON').AsString, 0) + '-' + fRetNomCidade(MovGer('CIDCON').AsString, 1);
    strIesRg  := MovGer('R_GCON').AsString;
    strCgcCli := fFormataCpfCgc(MovGer('CGCCON').AsString);
    strTelCli := MovGer('TELCON').AsString;
    strCepCli := MovGer('CEPCON').AsString;
  End;

  If (blnReimpressao) Then
    strCodCli := '"REIMPRESSAO"'
  Else
    strCodCli := 'Codigo..: ' + CadCli('CODCLI').AsString;

  Imp('Cliente..: ' + fPadR(strNomCli, 40)        + ' ' + strCodCli);
  Imp('Fantasia.: ' + fPadR(strFanSob, 40));
  Imp('Endereco.: ' + fPadR(strEndCli, 40)        + ' Bairro: ' + fPadR(strBaiCli, 18));
  Imp('Municipio: ' + fPadR(strCidCli, 40)        + ' C.E.P.: ' + fPadR(strCepCli, 18));
  Imp('CGC/CPF..: ' + fPadR(strCgcCpf, 40)        + ' IE/RG.: ' + fPadR(strIesRg, 18));
  Imp('Cnd. Pgto: ' + strConPag                   + ' Fone..: ' + fPadR(strTelCli, 18));
  If (VS_strUsaCnd = 'S') Then
    Imp('           ' + MovGer('CODCND').AsString + '-' + fRetDesConPag(MovGer('CODCND').AsString));

  If (VS_strUsaFpg = 'S') Then
    Imp('Form.Pgto: ' + fPadR(strForPag, 69) + Cond_10CPI(True))
  Else
    Imp(Cond_10CPI(True));

  Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
  Imp('CODIGO  DESCRICAO / REFERENCIA                                   ' + fPadR(IIF(FEspDoc = 'AJ', '', 'MARCA'), 28) + 'UN  E/S          QTDE    VR.UNIT    VR.TOTAL');
  Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
  //  '1234567-123456789-123456789-123456789-123456789-123456789-12345-123456789-123456789-12345678-123456789-1234567-123456789-123456789'

end;

procedure TFatImpressao.pImprimeTRCabGenerico40Col;
  Var
    strCgcCpf: String;
    strConPag: String;
    strIesRg : String;
    strTelEmp: String;
    strForPag: String;
    strCodCli: String;
    strNomCli: String;
    strFanSob: String;
    strEndCli: String;
    strBaiCli: String;
    strCidCli: String;
    strCgcCli: String;
    strTelCli: String;
    strCepCli: String;
begin
  strCgcCpf   := '';

  If (fStatusCndPag(MovGer('CONPAG').AsString) = A_PRAZO) Then
    strConPag := fPadR(fFormataCondPag(MovGer('CONPAG').AsString), 48)
  Else
    strConPag := fPadR('A VISTA', 48);

  strForPag := IIF(VS_strUsaFpg <> 'S', '', MovGer('CODFPG').AsString + ' - ' + fRetDesFpg(MovGer('CODFPG').AsString));

  strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
  If (CadCli('CGCCPF').AsInteger = 1) Then
    strIesRg := CadCli('I_E_S_').AsString
  Else
    strIesRg := CadCli('NUMR_G').AsString;

  strTelEmp := 'FONE/FAX.: ' + CadEmp('FONE01').AsString;
  strRisco  := fReplicatorStr('-', 48);

  {*******************************************}
  {* CONFIGURA O RELATÓRIO                   *}
  {****************************************AF*}
  Reseta;
  Imp(Cond_10CPI(True), False);
  Imp(CPI_12(True)    , False);
  Imp(Um_Oitavo(True) , False);

  {*******************************************}
  {* IMPRIME DADOS DA EMPRESA                *}
  {****************************************AF*}
  If (blnCabEmp) Then
  Begin
    Imp(fPadC(CadEmp('NOMEMP').AsString,48));
    Imp(fPadC(CadEmp('FONE01').AsString,48));
    Imp(fPadC(CadEmp('ENDERE').AsString + ', ' + CadEmp('ENDNUM').AsString + '-' + CadEmp('BAIRRO').AsString,48));
    Imp(fPadC(CadCli('NOMCID').AsString + '-' + CadCli('ESTADO').AsString,48));
    Imp(strRisco);
  End;

  Imp(Expandido(True), False);
  If (FEspDoc = 'TR') Then
    Imp('TROCA ', False)

  Else If (FEspDoc = 'DV') Then
    Imp('DEVOLUCAO ', False)

  Else If (FEspDoc = 'AJ') Then
    Imp('AJUSTE ', False);

  Imp('No ' + FNumDoc + Expandido(False));

  If (fEmptyStr(MovGer('NOMCON').AsString)) Then
  Begin
    strCodCli := CadCli('CODCLI').AsString;
    strNomCli := CadCli('NOMCLI').AsString;
    strFanSob := CadCli('FANSOB').AsString;
    strEndCli := CadCli('ENDERE').AsString;
    strBaiCli := CadCli('BAIRRO').AsString;
    strCidCli := CadCli('NOMCID').AsString;
    strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
    strTelCli := CadCli('FONE01').AsString;

    If (CadCli('CGCCPF').AsInteger = 1) Then
      strIesRg := CadCli('I_E_S_').AsString
    Else
      strIesRg := CadCli('NUMR_G').AsString;

    strCepCli := CadCli('C_E_P_').AsString;
  End
  Else
  Begin
    strCodCli := MovGer('CODCLI').AsString;
    strNomCli := MovGer('NOMCON').AsString;
    strFanSob := '';
    strEndCli := MovGer('ENDCON').AsString;
    strBaiCli := MovGer('BAICON').AsString;
    strCidCli := fRetNomCidade(MovGer('CIDCON').AsString, 0) + '-' + fRetNomCidade(MovGer('CIDCON').AsString, 1);
    strIesRg  := MovGer('R_GCON').AsString;
    strCgcCli := fFormataCpfCgc(MovGer('CGCCON').AsString);
    strTelCli := MovGer('TELCON').AsString;
    strCepCli := MovGer('CEPCON').AsString;
  End;

  Imp('');

  strCodCli := IIF(blnReimpressao, '"REIMPRESSAO"', 'Codigo..: ' + strCodCli);

  Imp(strCodCli);
  Imp('Cliente..: ' + fPadR(strNomCli, 37));
  Imp('Fantasia.: ' + fPadR(strFanSob, 37));
  Imp('Endereco.: ' + fPadR(strEndCli, 37));
  Imp('Bairro...: ' + fPadR(strBaiCli, 37));
  Imp('C.E.P....: ' + fPadR(strCepCli, 37));
  Imp('Municipio: ' + fPadR(strCidCli, 37));
  Imp('CGC/CPF..: ' + fPadR(strCgcCpf, 37));
  Imp('IE/RG....: ' + fPadR(strIesRg , 37));
  Imp('Fone.....: ' + fPadR(strTelCli, 37));
  Imp('Cnd. Pgto: ' + fPadR(strConPag, 37));

  If (VS_strUsaCnd = 'S') Then
    Imp('Cnd. Pgto: ' + MovGer('CODCND').AsString + '-' + fRetDesConPag(MovGer('CODCND').AsString));

  If (VS_strUsaFpg = 'S') Then
    Imp('Form.Pgto: ' + fPadR(strForPag, 48));

  Imp('-----------------------------------------------');
  Imp('COD.  DESCRICAO E/S UN   QTDE  VR.UNIT VR.TOTAL');
  Imp('-----------------------------------------------');
  //   12345-123456789-123456789-123456789-123456789-1
  //                   123-12-123456-12345678-12345678

end;

procedure TFatImpressao.pImprimeTRGenerico;
  Var
    intQtdDiv: Integer;
begin

  If Pos(FEspDoc, VS_strNaoCab) > 0 Then
  Begin
    blnCabEmp    := False;
    intQtdFol    := 18;
    intQtdFolOri := 18;
    intQtdAdc    := 8;
  End
  Else
  Begin
    blnCabEmp    := True;
    intQtdFol    := 13;
    intQtdFolOri := 13;
    intQtdAdc    := 8;
  End;

  If (VS_strUsaCnd = 'S') Then
  Begin
    Dec(intQtdFol, 1);
    Dec(intQtdFolOri, 1);
  End;

  intQtdPag := 1;

  If (qryRelatorio.RecordCount > intQtdFol) Then
  Begin
    intQtdDiv := qryRelatorio.RecordCount - intQtdFol;
    intQtdPag := (intQtdDiv Div (intQtdFol + intQtdAdc));
    //If (intQtdPag > 0) Then
    //Begin
      If (intQtdDiv / (intQtdFol + intQtdAdc) > intQtdPag) Then
        Inc(intQtdPag);
    //End;
    Inc(intQtdPag);

  End;

  qryRelatorio.First;
  intIteImp    := 0;
  intTotIteImp := 0;

  With qryRelatorio Do
  Begin
    While (Not Eof) Do
    Begin

      If (intIteImp = 0) Or (intIteImp >= intQtdFol) Then
      Begin

        If (intIteImp = 0) Or (intQtdFol + intQtdAdc > intQtdFolOri + intQtdAdc) Then
        Begin
          pImprimeTRCabGenerico;
          If (intIteImp > 0) Then
            Dec(intQtdFol, intQtdAdc);

          intIteImp := 0;
        End
        Else
        Begin
          If (intTotIteImp >= qryRelatorio.RecordCount) Then
          Begin
            pImprimeTRCabGenerico;
            intIteImp := 0;
            Break;
          End
          Else
            Inc(intQtdFol, intQtdAdc);
        End;
      End;

      Imp(fPadR(FieldByName('CODITE').AsString, 08) +
          fPadR(FieldByName('DESITE').AsString, IIF(FEspDoc <> 'AJ', 57, 85)) +
          IIF(FEspDoc <> 'AJ', fPadR(FieldByName('DESMAR').AsString, 28), '') +
          fPadR(FieldByName('UNIDAD').AsString, 04) +
          fPadR(FieldByName('ENTSAI').AsString, 06) +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 3)), 11) +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrf(FieldByName('VALUNI').AsFloat, ffFixed, 12, 4)), 11) +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrf(FieldByName('VALITE').AsFloat, ffFixed, 12, 2)), 11));
      Inc(intIteImp);
      Inc(intTotIteImp);

      Next;
    End;
  End;

  If (intIteImp > intQtdFolOri) Then
  Begin
    pImprimeTRCabGenerico;
  End;

  pImprimeTRRodGenerico(True);

end;

procedure TFatImpressao.pImprimeTRGenerico40Col;
begin

  If Pos(FEspDoc, VS_strNaoCab) > 0 Then
    blnCabEmp    := False
  Else
    blnCabEmp    := True;

  qryRelatorio.First;
  pImprimeTRCabGenerico40Col;

  With qryRelatorio Do
  Begin
    While (Not Eof) Do
    Begin
      
      Imp(fPadR(FieldByName('CODITE').AsString, 05) + ' ' +
          fPadR(FieldByName('DESITE').AsString, 40));
      Imp(fPadL(FieldByName('ENTSAI').AsString, 19) + ' ' +
          fPadR(FieldByName('UNIDAD').AsString, 02) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 2)), 06) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrf(FieldByName('VALUNI').AsFloat, ffFixed, 12, 2)), 08) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrf(FieldByName('VALITE').AsFloat, ffFixed, 12, 2)), 08));

      Next;
    End;
  End;

  pImprimeTRRodGenerico40Col;

end;

procedure TFatImpressao.pImprimeTRRodGenerico(blnTotal: Boolean);
  Var
    strVended: String;
    strDigita: String;
    strDebCli: String;
    intContador: Integer;
begin

  If (blnTotal) And (intIteImp > intQtdFolOri) Then
  Begin
    For intContador := 1 To intQtdFolOri Do
    Begin
      Imp('');
    End;
  End
  Else
  Begin
    For intContador := intIteImp To intQtdFol Do
    Begin
      Imp('');
    End;
  End;

  If (blnTotal) Then
  Begin

    {*******************************************}
    {* APLICA A DIGDUPLIC COM UM VALOR QUALQUER*}
    {* E DEPOIS PEGA OS VALORES DE "VPARXX"    *}
    {****************************************MV*}
    fDigDuplic(MovGer('CONPAG').AsString, 0, MovGer('VLRCON').AsFloat, False, False, False,
               MovGer('DTAENT').AsFloat, False);

    For intContador := 0 To 11 Do
    Begin

      If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
      Begin
        Break;
      End;

      arrDuplicata[intContador].curValor := MovGer('VPAR' + fStrZero(intContador+1, 2)).AsFloat;

    End;

    strVended := MovGer('CODVEN').AsString + ' - ' + fRetNomVendRep(MovGer('CODVEN').AsString); //melhorar isso aqui
    strDigita := MovGer('CODDIG').AsString + ' - ' + fRetNomVendRep(MovGer('CODDIG').AsString); //melhorar isso aqui

    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    If (fltDebCli <= 0) Then
    Begin
      strDebCli := '';
    End
    Else
    Begin
      strDebCli := 'Debitos do Cliente: ' + FloatToStrF(fltDebCli + MovGer('VLRCON').AsFloat, ffFixed, 12, 2) +
                   '          ';
    End;
    Imp(fPadL(strDebCli + 
              'Desconto: ' + FloatToStrF(MovGer('PORDES').AsFloat, ffFixed, 12, 2) + '          ' +
              'Desconto Especial: ' + FloatToStrF(MovGer('DESESP').AsFloat, ffFixed, 12, 2) + '          ' +
              'TOTAL: ' + FloatToStrF(MovGer('VLRCON').AsFloat, ffFixed, 12, 2), 137));
    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    Imp(fPadR('Vendedor.: ' + strVended, 121)                  + fPadR('Data: '   + MovGer('DTAENT').AsString, 16));

    If (VS_strUsaDig = 'S') Then
      Imp(fPadR('Digitador: ' + strDigita, 137))
    Else
      Imp('');

    Imp(fPadR('Mensagem.: ' + MovGer('MEN001').AsString, 121)  + fPadR('Hora:   ' + MovGer('HORENT').AsString, 16));
    Imp(fPadR('           ' + MovGer('MEN002').AsString, 137));

    If (fStatusCndPag(MovGer('CONPAG').AsString) = A_VISTA) Then
    Begin
      Imp('');
      Imp('');
    End
    Else
    Begin

      For intContador := 0 To 5 Do
      Begin

        If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
        Begin
          Break;
        End;

        Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                  arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                  fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);
      End;

      Imp('');

      For intContador := 6 To 11 Do
      Begin

        If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
        Begin
          Break;
        End;

        Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                  arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                  fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);
      End;

    End;
    Imp('');

  End
  Else
  Begin
    Imp('IMPRESSAO CONTINUA NA PROXIMA PAGINA');
  End;

  Eject;
end;

procedure TFatImpressao.pImprimeTRRodGenerico40Col;
  Var
    strVended: String;
    strDigita: String;
    strDebCli: String;
    intContador: Integer;
begin

  {*******************************************}
  {* APLICA A DIGDUPLIC COM UM VALOR QUALQUER*}
  {* E DEPOIS PEGA OS VALORES DE "VPARXX"    *}
  {****************************************MV*}
  fDigDuplic(MovGer('CONPAG').AsString, 0, MovGer('VLRCON').AsFloat, False, False, False,
             MovGer('DTAENT').AsFloat, False);

  For intContador := 0 To 11 Do
  Begin

    If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
    Begin
      Break;
    End;

    arrDuplicata[intContador].curValor := MovGer('VPAR' + fStrZero(intContador+1, 2)).AsFloat;

  End;

  strVended := MovGer('CODVEN').AsString + ' - ' + fRetNomVendRep(MovGer('CODVEN').AsString);
  strDigita := MovGer('CODDIG').AsString + ' - ' + fRetNomVendRep(MovGer('CODDIG').AsString);

  Imp('-----------------------------------------------');

  If (fltDebCli <= 0) Then
    strDebCli := ''
  Else
    strDebCli := 'Debitos do Cliente: ' + FloatToStrF(fltDebCli + MovGer('VLRCON').AsFloat, ffFixed, 12, 2);

  Imp(fPadR('Este Documento Nao Tem', 47));
  Imp(fPadR('   Validade Fiscal    ', 47));
  Imp(fPadR(' Peca Sua Nota Fiscal ', 22),False);
  Imp(fPadL('TOTAL: ' + FloatToStrF(MovGer('VLRCON').AsFloat, ffFixed, 12, 2),25));
  Imp(fPadL(strDebCli,47));

  Imp('-----------------------------------------------');

  Imp(fPadR('Vendedor.: ' + strVended, 47));

  If (VS_strUsaDig = 'S') Then
    Imp(fPadR('Digitador: ' + strDigita, 47))
  Else
    Imp('');

  Imp(fPadR('Data.....: ' + MovGer('DTAENT').AsString, 16) + ' ' + fPadR('Hora: ' + MovGer('HORENT').AsString, 16));
  Imp(fPadR('Mensagem.: ' + MovGer('MEN001').AsString, 47));
  Imp(fPadR('           ' + MovGer('MEN002').AsString, 47));

  If (fStatusCndPag(MovGer('CONPAG').AsString) = A_VISTA) Then
  Begin
    Imp('');
    Imp('');
  End
  Else
  Begin

    For intContador := 0 To 11 Do
    Begin

      If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
      Begin
        Break;
      End;

      Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);

      If ((intContador + 1) Mod 2) = 0 Then
        Imp('');

    End;

  End;

  For intContador := 0 To VS_intQtdSal Do
  Begin
    Imp('');
  End;
 
end;

procedure TFatImpressao.pImprimePDCabGenerico;
  Var
    strControle: String;
    strCgcCpf: String;
    strConPag: String;
    strIesRg: String;
    strTelEmp: String;
    strForPag: String;
    strCodCli: String;
    strNomCli: String;
    strFanSob: String;
    strEndCli: String;
    strBaiCli: String;
    strCidCli: String;
    strCgcCli: String;
    strTelCli: String;
    strCepCli: String;

    strMeiaFolha: String;
begin

  If FEspDoc = 'OR' Then
    strMeiaFolha := VS_strLay_Or
  Else
    strMeiaFolha := VS_strLay_Pd;

  strControle := '';
  strCgcCpf   := '';

  Inc(intPagina);

  strControle := IntToStr(intPagina) + '/' + IntToStr(intQtdPag);

  If intPagina > 1 Then
  Begin
    pImprimeFFRodGenerico(False);
    intLinImp := 0;
  End;

  If (fStatusCndPag(FatGor('CONPAG').AsString) = A_PRAZO) Then
  Begin
    strConPag := Cond_10CPI(True) + fPadR(fFormataCondPag(FatGor('CONPAG').AsString), 69) + Cond_10CPI(False);
  End
  Else
  Begin
    strConPag := Cond_10CPI(True) + fPadR('A VISTA', 69) + Cond_10CPI(False);
  End;

  strForPag := IIF(VS_strUsaFpg <> 'S', '', FatGor('CODFPG').AsString + ' - ' + fRetDesFpg(FatGor('CODFPG').AsString));

  strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
  If (CadCli('CGCCPF').AsInteger = 1) Then
  Begin
    strIesRg := CadCli('I_E_S_').AsString;
  End
  Else
  Begin
    strIesRg := CadCli('NUMR_G').AsString;
  End;

  strTelEmp := 'FONE/FAX.: ' + CadEmp('FONE01').AsString;
  strRisco  := fReplicatorStr('-', 80);

  {*******************************************}
  {* CONFIGURA O RELATÓRIO                   *}
  {****************************************MV*}
  Reseta;
  Imp(Cond_10CPI(False), False);
  Imp(CPI_12(False), False);
  Imp(Um_Oitavo(True), False);

  If (strMeiaFolha = '1') Then
    Imp(TamPag(43), False)
  Else
    Imp(TamPag(87), False);

  {*******************************************}
  {* IMPRIME DADOS DA EMPRESA                *}
  {****************************************MV*}
  If (blnCabEmp) Then
  Begin
    Imp(Expandido(True) + CadEmp('NOMEMP').AsString + Expandido(False));
    Imp(Expandido(True) + fPadR(CadEmp('FONE01').AsString, 74) + Expandido(False) + fPadR(strControle, 5));
    Imp('Cidade..: ' + fPadR(CadEmp('NOMCID').AsString + '-' + CadEmp('ESTADO').AsString , 40) + 'Bairro.: ' + fPadR(CadEmp('BAIRRO').AsString, 18));
    Imp('Endereco: ' + fPadR(CadEmp('ENDERE').AsString + ', ' + CadEmp('ENDNUM').AsString, 40) + 'Cep....: ' + fPadR(CadEmp('C_E_P_').AsString, 18));
    Imp(strRisco);
    strControle := '';
  End;

  Imp(Expandido(True), False);
  If (FEspDoc = 'PD') Then
    Imp('PEDIDO ', False)
  Else If (FEspDoc = 'OR') Then
    Imp('ORCAMENTO ', False);

  Imp('No ' + FNumDoc + IIF(blnIteRep, ' - ITENS REPRESENT.', '') + Expandido(False), blnCabEmp);

  If (Not blnCabEmp) Then
  Begin
    Imp(fPadL(strControle, 10));
  End;

  If (fEmptyStr(FatGor('NOMCON').AsString)) Then
  Begin
    strCodCli := CadCli('CODCLI').AsString;
    strNomCli := CadCli('NOMCLI').AsString;
    strFanSob := CadCli('FANSOB').AsString;
    strEndCli := CadCli('ENDERE').AsString;
    strBaiCli := CadCli('BAIRRO').AsString;
    strCidCli := CadCli('NOMCID').AsString;
    strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
    strTelCli := CadCli('FONE01').AsString;
    If (CadCli('CGCCPF').AsInteger = 1) Then
    Begin
      strIesRg := CadCli('I_E_S_').AsString;
    End
    Else
    Begin
      strIesRg := CadCli('NUMR_G').AsString;
    End;
    strCepCli := CadCli('C_E_P_').AsString;
  End
  Else
  Begin
    strCodCli := FatGor('CODCLI').AsString;
    strNomCli := FatGor('NOMCON').AsString;
    strFanSob := '';
    strEndCli := FatGor('ENDCON').AsString;
    strBaiCli := FatGor('BAICON').AsString;
    strCidCli := fRetNomCidade(FatGor('CIDCON').AsString, 0) + '-' + fRetNomCidade(FatGor('CIDCON').AsString, 1);
    strIesRg  := FatGor('R_GCON').AsString;
    strCgcCli := fFormataCpfCgc(FatGor('CGCCON').AsString);
    strTelCli := FatGor('TELCON').AsString;
    strCepCli := FatGor('CEPCON').AsString;
  End;

  If (blnReimpressao) Then
    strCodCli := '"REIMPRESSAO"'
  Else
    strCodCli := 'Codigo..: ' + CadCli('CODCLI').AsString;

  Imp('Cliente..: ' + fPadR(strNomCli, 40)        + ' ' + strCodCli);
  Imp('Fantasia.: ' + fPadR(strFanSob, 40));
  Imp('Endereco.: ' + fPadR(strEndCli, 40)        + ' Bairro: ' + fPadR(strBaiCli, 18));
  Imp('Municipio: ' + fPadR(strCidCli, 40)        + ' C.E.P.: ' + fPadR(strCepCli, 18));
  Imp('CGC/CPF..: ' + fPadR(strCgcCpf, 40)        + ' IE/RG.: ' + fPadR(strIesRg, 18));
  Imp('Cnd. Pgto: ' + strConPag                   + ' Fone..: ' + fPadR(strTelCli, 18));

  If (VS_strUsaCnd = 'S') Then
    Imp('           ' + FatGor('CODCND').AsString + '-' + fRetDesConPag(FatGor('CODCND').AsString));

  If (VS_strUsaFpg = 'S') Then
    Imp('Form.Pgto: ' + fPadR(strForPag, 67) + Cond_10CPI(True))
  Else
    Imp(Cond_10CPI(True));

  Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
  Imp('CODIGO  DESCRICAO / REFERENCIA                                       ' + IIF(Self.blnComPre, '', fstrEspaco('', 18)) + 'MARCA                       UN           QTDE.    ' + IIF(Self.blnComPre, 'UNIT    VR.TOTAL', ''));
  Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
  //  '1234567-123456789-123456789-123456789-123456789-123456789-12345-123456789-123456789-12345678-123456789-1234567-123456789-123456789'
end;

procedure TFatImpressao.pImprimePDCabGenerico40Col;
  Var
    strCgcCpf: String;
    strConPag: String;
    strIesRg : String;
    strTelEmp: String;
    strForPag: String;
    strCodCli: String;
    strNomCli: String;
    strFanSob: String;
    strEndCli: String;
    strBaiCli: String;
    strCidCli: String;
    strCgcCli: String;
    strTelCli: String;
    strCepCli: String;
begin
  strCgcCpf   := '';

  If (fStatusCndPag(FatGor('CONPAG').AsString) = A_PRAZO) Then
    strConPag := fPadR(fFormataCondPag(FatGor('CONPAG').AsString), 48)
  Else
    strConPag := fPadR('A VISTA', 48);

  strForPag := IIF(VS_strUsaFpg <> 'S', '', FatGor('CODFPG').AsString + ' - ' + fRetDesFpg(FatGor('CODFPG').AsString));

  strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
  If (CadCli('CGCCPF').AsInteger = 1) Then
    strIesRg := CadCli('I_E_S_').AsString
  Else
    strIesRg := CadCli('NUMR_G').AsString;

  strTelEmp := 'FONE/FAX.: ' + CadEmp('FONE01').AsString;
  strRisco  := fReplicatorStr('-', 48);

  {*******************************************}
  {* CONFIGURA O RELATÓRIO                   *}
  {****************************************AF*}
  Reseta;
  Imp(Cond_10CPI(True), False);
  Imp(CPI_12(True)    , False);
  Imp(Um_Oitavo(True) , False);

  {*******************************************}
  {* IMPRIME DADOS DA EMPRESA                *}
  {****************************************AF*}
  If (blnCabEmp) Then
  Begin
    Imp(fPadC(CadEmp('NOMEMP').AsString,48));
    Imp(fPadC(CadEmp('FONE01').AsString,48));
    Imp(fPadC(CadEmp('ENDERE').AsString + ', ' + CadEmp('ENDNUM').AsString + '-' + CadEmp('BAIRRO').AsString,48));
    Imp(fPadC(CadCli('NOMCID').AsString + '-' + CadCli('ESTADO').AsString,48));
    Imp(strRisco);
  End;

  Imp(Expandido(True), False);
  If (FEspDoc = 'PD') Then
    Imp('PEDIDO ', False)

  Else If (FEspDoc = 'OR') Then
    Imp('ORCAMENTO ', False);

  Imp('No ' + FNumDoc + Expandido(False));

  If (fEmptyStr(FatGor('NOMCON').AsString)) Then
  Begin
    strCodCli := CadCli('CODCLI').AsString;
    strNomCli := CadCli('NOMCLI').AsString;
    strFanSob := CadCli('FANSOB').AsString;
    strEndCli := CadCli('ENDERE').AsString;
    strBaiCli := CadCli('BAIRRO').AsString;
    strCidCli := CadCli('NOMCID').AsString;
    strCgcCpf := fFormataCpfCgc(CadCli('C_G_C_').AsString);
    strTelCli := CadCli('FONE01').AsString;

    If (CadCli('CGCCPF').AsInteger = 1) Then
      strIesRg := CadCli('I_E_S_').AsString
    Else
      strIesRg := CadCli('NUMR_G').AsString;

    strCepCli := CadCli('C_E_P_').AsString;
  End
  Else
  Begin
    strCodCli := FatGor('CODCLI').AsString;
    strNomCli := FatGor('NOMCON').AsString;
    strFanSob := '';
    strEndCli := FatGor('ENDCON').AsString;
    strBaiCli := FatGor('BAICON').AsString;
    strCidCli := fRetNomCidade(FatGor('CIDCON').AsString, 0) + '-' + fRetNomCidade(FatGor('CIDCON').AsString, 1);
    strIesRg  := FatGor('R_GCON').AsString;
    strCgcCli := fFormataCpfCgc(FatGor('CGCCON').AsString);
    strTelCli := FatGor('TELCON').AsString;
    strCepCli := FatGor('CEPCON').AsString;
  End;

  Imp('');

  strCodCli := IIF(blnReimpressao, '"REIMPRESSAO"', 'Codigo..: ' + strCodCli);

  Imp(strCodCli);
  Imp('Cliente..: ' + fPadR(strNomCli, 37));
  Imp('Fantasia.: ' + fPadR(strFanSob, 37));
  Imp('Endereco.: ' + fPadR(strEndCli, 37));
  Imp('Bairro...: ' + fPadR(strBaiCli, 37));
  Imp('C.E.P....: ' + fPadR(strCepCli, 37));
  Imp('Municipio: ' + fPadR(strCidCli, 37));
  Imp('CGC/CPF..: ' + fPadR(strCgcCpf, 37));
  Imp('IE/RG....: ' + fPadR(strIesRg , 37));
  Imp('Fone.....: ' + fPadR(strTelCli, 37));
  Imp('Cnd. Pgto: ' + fPadR(strConPag, 37));

  If (VS_strUsaCnd = 'S') Then
    Imp('Cnd. Pgto: ' + FatGor('CODCND').AsString + '-' + fRetDesConPag(FatGor('CODCND').AsString));

  If (VS_strUsaFpg = 'S') Then
    Imp('Form.Pgto: ' + fPadR(strForPag, 48));

  Imp('-----------------------------------------------');
  Imp('COD.  DESCRICAO UN    QTD   ' + IIF(blnImpPre, 'VR.UNIT    VR.TOTAL', ''));
  Imp('-----------------------------------------------');
  //     12345-123456789 123456789 123456789 -123456789
  //                     12-123456-123456789 -123456789

end;

procedure TFatImpressao.pImprimePDGenerico;
  Var
    intQtdDiv: Integer;
    strMeiaFolha: String;
Begin

  If FEspDoc = 'OR' Then
    strMeiaFolha := VS_strLay_Or
  Else
    strMeiaFolha := VS_strLay_Pd;

  If (strMeiaFolha <> '2') Then
  Begin

    If Pos(FEspDoc, VS_strNaoCab) > 0 Then
    Begin
      blnCabEmp    := False;
      intQtdFol    := 18;
      intQtdFolOri := 18;
      intQtdAdc    := 8;
    End
    Else
    Begin
      blnCabEmp    := True;
      intQtdFol    := 13;
      intQtdFolOri := 13;
      intQtdAdc    := 8;
    End;

  End
  Else
  Begin
    If Pos(FEspDoc, VS_strNaoCab) > 0 Then
    Begin
      blnCabEmp    := False;
      intQtdFol    := 60;
      intQtdFolOri := 60;
      intQtdAdc    := 8;
    End
    Else
    Begin
      blnCabEmp    := True;
      intQtdFol    := 55;
      intQtdFolOri := 55;
      intQtdAdc    := 8;
    End;
  End;

  If (blnTemSer) Then
  Begin
    Dec(intQtdFol, 2);
    Dec(intQtdFolOri, 2);
  End;

  If (FEspDoc = 'PD') Then
  Begin
    Dec(intQtdFol, 2);
    Dec(intQtdFolOri, 2);
  End;

  blnEntMat := False;
  If (FatGor('CONENT').AsString = 'S') And (Not VS_blnEmpGer) Then
  Begin
    Dec(intQtdFol, 1);
    Dec(intQtdFolOri, 1);
    blnEntMat := True;
  End;

  intQtdPag := 1;

  If (qryRelatorio.RecordCount > intQtdFol) Then
  Begin
    intQtdDiv := qryRelatorio.RecordCount - intQtdFol;
    intQtdPag := (intQtdDiv Div (intQtdFol + intQtdAdc));

    If (intQtdDiv / (intQtdFol + intQtdAdc) > intQtdPag) Then
      Inc(intQtdPag);

    Inc(intQtdPag);

  End;

  qryRelatorio.First;
  intIteImp    := 0;
  intTotIteImp := 0;

  With qryRelatorio Do
  Begin
    While (Not Eof) Do
    Begin

      If (intIteImp = 0) Or (intIteImp >= intQtdFol) Then
      Begin

        If (intIteImp = 0) Or (intQtdFol + intQtdAdc > intQtdFolOri + intQtdAdc) Then
        Begin
          pImprimePDCabGenerico;
          If (intIteImp > 0) Then
            Dec(intQtdFol, intQtdAdc);

          intIteImp := 0;
        End
        Else
        Begin
          If (intTotIteImp >= qryRelatorio.RecordCount) Then
          Begin
            pImprimePDCabGenerico;
            intIteImp := 0;
            Break;
          End
          Else
            Inc(intQtdFol, intQtdAdc);
        End;
      End;

      Imp(fPadR(FieldByName('CODITE').AsString, 08) +
          fPadR(FieldByName('DESITE').AsString, IIF(fEmptyStr(FieldByName('CODITE').AsString), 130, IIF(Self.blnComPre, 61, 80))) +
          fPadR(FieldByName('DESMAR').AsString, 29) +
          //fPadR(FieldByName('UNIDAD').AsString, 08) +
          fPadR(FieldByName('DESUNI').AsString, 08) +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 3)), 08) +
          IIF(Self.blnComPre, fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrf(FieldByName('VALUNI').AsFloat, ffFixed, 12, 4)), 11), '') +
          IIF(Self.blnComPre, fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrf(FieldByName('VALITE').AsFloat, ffFixed, 12, 2)), 11), ''));
      Inc(intIteImp);
      Inc(intTotIteImp);

      If (Not fEmptyStr(FieldByName('CODITE').AsString)) Then
      Begin
        fltTotIte := fltTotIte + FieldByName('VALITE').AsFloat;
      End;

      Next;
    End;
  End;

  If (intIteImp > intQtdFolOri) Then
  Begin
    pImprimePDCabGenerico;
  End;

  pImprimePDRodGenerico(True);
end;

procedure TFatImpressao.pImprimePDGenerico40Col;
Begin

  If Pos(FEspDoc, VS_strNaoCab) > 0 Then
    blnCabEmp    := False
  Else
    blnCabEmp    := True;

  blnEntMat := False;
  If (FatGor('CONENT').AsString = 'S') And (Not VS_blnEmpGer) Then
    blnEntMat := True;

  qryRelatorio.First;
  pImprimePDCabGenerico40Col;

  With qryRelatorio Do
  Begin
    While (Not Eof) Do
    Begin

      Imp(fPadR(FieldByName('CODITE').AsString, 05) + ' ' +
          fPadR(FieldByName('DESITE').AsString, 40));
      Imp(fPadL(FieldByName('UNIDAD').AsString, 19) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString), '', FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 2)), 06) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString) Or (Not blnImpPre), '', FloatToStrf(FieldByName('VALUNI').AsFloat, ffFixed, 12, 2)), 10) + ' ' +
          fPadL(IIF(fEmptyStr(FieldByName('CODITE').AsString) Or (Not blnImpPre), '', FloatToStrf(FieldByName('VALITE').AsFloat, ffFixed, 12, 2)), 10));

      If (Not fEmptyStr(FieldByName('CODITE').AsString)) Then
      Begin
        fltTotIte := fltTotIte + FieldByName('VALITE').AsFloat;
      End;

      Next;
    End;
  End;

  pImprimePDRodGenerico40Col;
end;

procedure TFatImpressao.pImprimePDRodGenerico(blnTotal: Boolean);
  Var
    strVended: String;
    strDigita: String;
    intContador: Integer;
begin

  If (blnTotal) And (intIteImp > intQtdFolOri) Then
  Begin
    For intContador := 1 To intQtdFolOri Do
    Begin
      Imp('');
    End;
  End
  Else
  Begin
    For intContador := intIteImp To intQtdFol Do
    Begin
      Imp('');
    End;
  End;

  If (blnTotal) Then
  Begin

    {*******************************************}
    {* APLICA A DIGDUPLIC COM UM VALOR QUALQUER*}
    {* E DEPOIS PEGA OS VALORES DE "VPARXX"    *}
    {****************************************MV*}
    fDigDuplic(FatGor('CONPAG').AsString, 0, FatGor('VLRCON').AsFloat, False, False, False,
               FatGor('DTAENT').AsFloat, False);

    strVended := FatGor('CODVEN').AsString + ' - ' + fRetNomVendRep(FatGor('CODVEN').AsString); //melhorar isso aqui
    strDigita := FatGor('CODDIG').AsString + ' - ' + fRetNomVendRep(FatGor('CODDIG').AsString); //melhorar isso aqui

    If (blnTemSer) Then
    Begin
      Imp(fPadL('Total de Servicos: % ISS: ' + FloatToStrF(FatGor('PERISS').AsFloat, ffFixed, 12, 2) + '          ' +
                    'Vr. ISS: ' + FloatToStrF(FatGor('VALISS').AsFloat, ffFixed, 12, 2) + '          ' +
                    'R$: ' + FloatToStrF(FatGor('TOTSER').AsFloat, ffFixed, 12, 2), 137));
    End;

    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    Imp('Peso: ' + fPadL(FormatFloat('#,###0.000', IIF(blnIteRep, 0.0, FatGor('PESBRU').AsFloat)), 10) +
              fPadL('Desconto: ' + FloatToStrF(IIF(blnIteRep, 0.0, FatGor('PORDES').AsFloat), ffFixed, 12, 2) + '          ' +
              'Desconto Especial: ' + FloatToStrF(IIF(blnIteRep, 0.0, FatGor('DESESP').AsFloat), ffFixed, 12, 2) + '          ' +
              'TOTAL: ' + FloatToStrF(IIF(blnIteRep, fltTotIte, FatGor('VLRCON').AsFloat), ffFixed, 12, 2), 121));
    Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
    Imp(fPadR('Vendedor.: ' + strVended, 121)                  + fPadR('Data: '   + FatGor('DTAENT').AsString, 16));

    If (VS_strUsaDig = 'S') Then
      Imp(fPadR('Digitador: ' + strDigita, 137))
    Else
      Imp('');

    If (FEspDoc = 'PD') Then
    Begin
      Imp(fPadR('Transpor.: ' + FatGor('CODTRA').AsString + ' - ' + fRetNomTransportadora(FatGor('CODTRA').AsString), 121) + fPadR('Hora:   ' + FatGor('HORENT').AsString, 16));
      Imp(fPadR(IIF(FatGor('TIPFRE').AsString = '1','Emitente    ','Destinatario    ') + 'Vr.Frete: ' + FloatToStrF(FatGor('TOTFRE').AsFloat, ffNumber, 15, 2), 137));
      Imp(fPadR('Mensagem.: ' + FatGor('MEN001').AsString, 137));
      Imp(fPadR('           ' + FatGor('MEN002').AsString, 137));
      Imp(fPadR('End.Entre: ' + CadCli('ENDENT').AsString, 100) + ' - ' + fPadR(fRetNomCidade(CadCli('CIDENT').AsString),37));
    End
    Else
    Begin
      Imp(fPadR('Mensagem.: ' + FatGor('MEN001').AsString, 121) + fPadR('Hora:   ' + FatGor('HORENT').AsString, 16));
      Imp(fPadR('           ' + FatGor('MEN002').AsString, 137));
    End;

    If (fStatusCndPag(FatGor('CONPAG').AsString) = A_VISTA) Then
    Begin
      If (FEspDoc = 'OR') Then
      Begin
        Imp('');
        Imp('');
      End;
    End
    Else
    Begin

      If (FEspDoc = 'OR') Then
      Begin
        
        For intContador := 0 To 5 Do
        Begin

          If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
          Begin
            Break;
          End;

          Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                    arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                    fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);
        End;

        Imp('');

        For intContador := 6 To 11 Do
        Begin

          If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
          Begin
            Break;
          End;

          Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                    arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                    fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);
        End;

      End;

    End;

    If (blnEntMat) Then
      Imp('ENTREGUE PELA MATRIZ');

    Imp('');

  End
  Else
  Begin
    Imp('IMPRESSAO CONTINUA NA PROXIMA PAGINA');
  End;

  Eject;

end;

procedure TFatImpressao.pImprimePDRodGenerico40Col;
  Var
    strVended: String;
    strDigita: String;
    intContador: Integer;
    strPeso    : String;
    strDesconto: String;
    strDesEsp  : String;
    strTotal   : String;
begin

  {*******************************************}
  {* APLICA A DIGDUPLIC COM UM VALOR QUALQUER*}
  {* E DEPOIS PEGA OS VALORES DE "VPARXX"    *}
  {****************************************AF*}
  fDigDuplic(FatGor('CONPAG').AsString, 0, FatGor('VLRCON').AsFloat, False, False, False,
             FatGor('DTAENT').AsFloat, False);

  strVended := FatGor('CODVEN').AsString + ' - ' + fRetNomVendRep(FatGor('CODVEN').AsString);
  strDigita := FatGor('CODDIG').AsString + ' - ' + fRetNomVendRep(FatGor('CODDIG').AsString);

  If (blnTemSer) Then
  Begin
    Imp(fPadL('Tot Serv: %ISS: ' + FloatToStrF(FatGor('PERISS').AsFloat, ffFixed, 12, 2) + ' ' +
                  'Vr. ISS: ' + FloatToStrF(FatGor('VALISS').AsFloat, ffFixed, 12, 2) + ' ' +
                  'R$: ' + FloatToStrF(FatGor('TOTSER').AsFloat, ffFixed, 12, 2), 48));
  End;

  Imp('-----------------------------------------------');

  strPeso     := 'Peso: '     + fPadL(FormatFloat('#,###0.00', IIF(blnIteRep, 0.0, FatGor('PESBRU').AsFloat)), 10);
  strDesconto := 'Desconto: ' + fPadL(FormatFloat('#,###0.00', IIF(blnIteRep, 0.0, FatGor('PORDES').AsFloat)), 10);
  strDesEsp   := 'Desc Esp: ' + fPadL(FormatFloat('#,###0.00', IIF(blnIteRep, 0.0, FatGor('DESESP').AsFloat)), 10);
  strTotal    := 'TOTAL: '    + fPadL(FormatFloat('#,###0.00', IIF(blnIteRep, fltTotIte, FatGor('VLRCON').AsFloat)), 10);

  Imp(fPadR('Este Documento Nao Tem', 22),False);
  Imp(fPadL(strPeso, 25));

  Imp(fPadR('   Validade Fiscal    ', 22),False);
  Imp(fPadL(strDesconto, 25));

  Imp(fPadR(' Peca Sua Nota Fiscal ', 22),False);
  Imp(fPadL(strDesEsp, 25));

  Imp(fPadL(strTotal,47));
  
  Imp('-----------------------------------------------');

  Imp(fPadR('Vendedor.: ' + strVended, 47));

  If (VS_strUsaDig = 'S') Then
    Imp(fPadR('Digitador: ' + strDigita, 47))
  Else
    Imp('');

  Imp(fPadR('Data: ' + FatGor('DTAENT').AsString, 16) + ' ' + fPadR('Hora: ' + FatGor('HORENT').AsString, 16));

  If (FEspDoc = 'PD') Then
  Begin
    Imp(fPadR('Transpor.: ' + FatGor('CODTRA').AsString + ' - ' + fRetNomTransportadora(FatGor('CODTRA').AsString), 47));
    Imp(fPadR(IIF(FatGor('TIPFRE').AsString = '1','Emitente    ','Destinatario    ') + 'Vr.Frete: ' + FloatToStrF(FatGor('TOTFRE').AsFloat, ffNumber, 15, 2), 47));
    Imp(fPadR('Mensagem.: ' + FatGor('MEN001').AsString, 47));
    Imp(fPadR('           ' + FatGor('MEN002').AsString, 47));
    Imp(fPadR('End.Entre: ' + CadCli('ENDENT').AsString, 30) + ' - ' + fPadR(fRetNomCidade(CadCli('CIDENT').AsString),17));
  End
  Else
  Begin
    Imp(fPadR('Mensagem.: ' + FatGor('MEN001').AsString, 47));
    Imp(fPadR('           ' + FatGor('MEN002').AsString, 47));
  End;

  If (fStatusCndPag(FatGor('CONPAG').AsString) = A_VISTA) Then
  Begin
    If (FEspDoc = 'OR') Then
    Begin
      Imp('');
      Imp('');
    End;
  End
  Else
  Begin

    If (FEspDoc = 'OR') Then
    Begin

      For intContador := 0 To 11 Do
      Begin

        If (fEmptyStr(arrDuplicata[intContador].strSequen)) Then
        Begin
          Break;
        End;

        Imp(fPadR(arrDuplicata[intContador].strSequen + ')' +
                  arrDuplicata[intContador].dtaDtaVen + ' ', 13) +
                  fPadL(FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2), 08) + ' ', False);

        If ((intContador + 1) Mod 2) = 0 Then
          Imp('');

      End;
      
    End;

  End;

  If (blnEntMat) Then
    Imp('ENTREGUE PELA MATRIZ');

  For intContador := 0 To VS_intQtdSal Do
  Begin
    Imp('');
  End;
 
end;

function TFatImpressao.FatGor(strCampo: String): TField;
begin
  Result := qryFatGor.FieldByName('FGO_' + strCampo);
end;

end.

