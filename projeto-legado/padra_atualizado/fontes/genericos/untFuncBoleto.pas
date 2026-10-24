unit untFuncBoleto;

interface

uses SysUtils, Forms, untfuncoesSimples, Dialogs, Uni, untTypesSistema;

  //procedure pInicializaCamposUso(Var cpuCampos: TCamposUso; strArqCtr: String = '');
  procedure pInicializaCamposUso(Var cpuCampos : TCamposUso;
                                 Var qryGenBl1 : TUniQuery;
                                 Var qryGenBl2 : TUniQuery;
                                 Var qryGenBl3 : TUniQuery;
                                 strArqCtr : String = '');

  //procedure pAtualizaCamposUso(Var cpuCampos: TCamposUso; dpcDuplicata: TDuplicataCtr);
  procedure pAtualizaCamposUso(Var cpuCampos: TCamposUso;
                                   dpcDuplicata: TDuplicataCtr;
                               Var qryGenBl1 : TUniQuery;
                               Var qryGenBl2 : TUniQuery;
                               Var qryGenBl3 : TUniQuery);


  //procedure pAtribuiCamposUso(Var cpuCampos: TCamposUso);
  procedure pAtribuiCamposUso(Var cpuCampos: TCamposUso;
                              Var qryGenBl1 : TUniQuery;
                              Var qryGenBl2 : TUniQuery;
                              Var qryGenBl3 : TUniQuery);


  procedure pFinalizaCamposUso(Var cpuCampos: TCamposUso);

  procedure pImprimeRegistro(strNomeTabela: String;
                             Self: TObject;
                             strCodBco,
                             strCodPor,
                             strNosNum: String;
                             cpuCampos: TCamposUso;
                             strNomImp,
                             strNomPro,
                             strDesPro,
                             strBcoIni: String;
                             intCodCar: Integer;
                             qryCadOpe: TUniQuery);

  procedure pImprimeBoletosAgrupados(strNomeTabela: String; Self: TObject; strNumAgr, strNomeForm, strNomImp: String;
    Var strCodBco, strCodPor, strNosNum: String; fltValMor: Double;
    Var qryGenBl1 : TUniQuery;
    Var qryGenBl2 : TUniQuery;
    Var qryGenBl3 : TUniQuery);



  function fDigBoleto(Var strCodBco, strCodPor, strNosNum: String; Var fltValMor: Double): Boolean;


implementation

uses  untFuncMacro, DB, untDigBoleto, untCadRec;

{*****************************************}
{* INICIALIZA A VARIAVEL CAMPOS USO      *}
{**************************************JB*}
//procedure pInicializaCamposUso(Var cpuCampos: TCamposUso; strArqCtr: String = '');
procedure pInicializaCamposUso(Var cpuCampos : TCamposUso;
                               Var qryGenBl1 : TUniQuery;
                               Var qryGenBl2 : TUniQuery;
                               Var qryGenBl3 : TUniQuery;
                                   strArqCtr : String = '');
 Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  C.*, ';
  strSQL := strSQL + '  D1.CID_NOMCID AS CID_NOMCID, ';
  strSQL := strSQL + '  D1.CID_ESTADO AS CID_ESTADO, ';
  strSQL := strSQL + '  D2.CID_NOMCID AS CID_CIDCOB, ';
  strSQL := strSQL + '  D2.CID_ESTADO AS CID_ESTCOB, ';
  strSQL := strSQL + '  D3.CID_NOMCID AS CID_CIDENT, ';
  strSQL := strSQL + '  D3.CID_ESTADO AS CID_ESTENT ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI AS C ';
  strSQL := strSQL + 'JOIN CADCID AS D1 ON D1.CID_CODCID = C.CLI_CODCID ';
  strSQL := strSQL + 'LEFT JOIN CADCID D2 ON C.CLI_CIDCOB = D2.CID_CODCID ';
  strSQL := strSQL + 'LEFT JOIN CADCID D3 ON C.CLI_CIDENT = D3.CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  C.CLI_CODCLI = :CODCLI ';

  qryGenBl1.SQL.Clear;
  qryGenBl1.SQL.Add(strSQL);
  qryGenBl1.Open;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  R.*, ';
  strSQL := strSQL + '  O.OPE_NOMOPE AS OPE_NOMOPE, ';
  strSQL := strSQL + '  P.POR_NOMPOR AS POR_NOMPOR ';
  strSQL := strSQL + 'FROM ';

  If fEmptyStr(strArqCtr) Then
    strSQL := strSQL + ' CADREC R, '
  Else
    strSQL := strSQL + ' ' + strArqCtr + ' R, ';

  strSQL := strSQL + '  CADOPE O ';
  strSQL := strSQL + 'LEFT JOIN CADPOR P ON R.CTR_CODPOR = P.POR_CODPOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  R.CTR_CODVEN = O.OPE_CODOPE AND ';
  strSQL := strSQL + '  R.CTR_VALDUP > 0 AND ';
  strSQL := strSQL + '  R.CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  R.CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  R.CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  R.CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  R.CTR_CODCLI = :CODCLI ';

  qryGenBl2.SQL.Clear;
  qryGenBl2.SQL.Add(strSQL);
  qryGenBl2.Open;

  pAtribuiCamposUso(cpuCampos, qryGenBl1, qryGenBl2, qryGenBl3);

end;

procedure pAtualizaCamposUso(Var cpuCampos: TCamposUso;
                                 dpcDuplicata: TDuplicataCtr;
                             Var qryGenBl1 : TUniQuery;
                             Var qryGenBl2 : TUniQuery;
                             Var qryGenBl3 : TUniQuery);
begin
  //With frmModuloSPR.qryGen004' Do
  With qryGenBl1 Do
  Begin
    Close;
    ParamByName('CODCLI').AsString := dpcDuplicata.strCodCli;
    Open;
  End;

  //With frmModuloSPR.qryGen005 Do
  With qryGenBl2 Do
  Begin
    Close;
    ParamByName('NUMDUP').AsString := dpcDuplicata.strNumDup;
    ParamByName('PARCEL').AsString := dpcDuplicata.strParcel;
    ParamByName('ESPDOC').AsString := dpcDuplicata.strEspDoc;
    ParamByName('CODEMP').AsString := dpcDuplicata.strCodEmp;
    ParamByName('CODCLI').AsString := dpcDuplicata.strCodCli;
    Open;
  End;

  //With frmModuloSPR.qryGen011 Do
  With qryGenBl3 Do
  Begin
    Close;
    ParamByName('NUMDUP').AsString := dpcDuplicata.strNumDup;
    ParamByName('CODEMP').AsString := dpcDuplicata.strCodEmp;
    Open;
  End;

  pFinalizaCamposUso(cpuCampos);
  pAtribuiCamposUso(cpuCampos, qryGenBl1, qryGenBl2, qryGenBl3);
end;

//procedure pAtribuiCamposUso(Var cpuCampos: TCamposUso);
procedure pAtribuiCamposUso(Var cpuCampos: TCamposUso;
                            Var qryGenBl1 : TUniQuery;
                            Var qryGenBl2 : TUniQuery;
                            Var qryGenBl3 : TUniQuery);

begin
  If cpuCampos = Nil Then
  Begin
    cpuCampos := TCamposUso.Create;
  End
  Else
  Begin
    cpuCampos.LimparCampos;
  End;

  cpuCampos.AdicionaCampos(qryGenBl2, 'CADREC');
  cpuCampos.AdicionaCampos(qryGenBl1, 'CADCLI');
  cpuCampos.AdicionaCampos(qryGenBl3, 'CADREC');
end;

procedure pFinalizaCamposUso(Var cpuCampos: TCamposUso);
begin
  If cpuCampos <> Nil Then
    FreeAndNil(cpuCampos);
end;

function fDigBoleto(Var strCodBco, strCodPor, strNosNum: String; Var fltValMor: Double): Boolean;
  Var
    frmDigBoleto : TfrmDigBoleto;
begin

  Try
    pCriarFormularios(TfrmDigBoleto, frmDigBoleto);
    frmDigBoleto.edtCodPor.Text := strCodPor;
    frmDigBoleto.showModal;

    Result      := frmDigBoleto.blnConfirma;
    strCodBco   := frmDigBoleto.strCodBco;
    strCodPor   := frmDigBoleto.strCodPor;
    fltValMor   := frmDigBoleto.fltValMor;
    strNosNum   := frmDigBoleto.strNosNum;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fDigBoleto]');
    End;
  End;

  pFreeAndNil(frmDigBoleto);

end;

(*procedure pImprimeRegistro(strNomeTabela: String; Self: TObject; strCodBco, strCodPor, strNosNum: String;
  cpuCampos: TCamposUso; strNomImp: String);
  Var
    intLinhaAtu: Integer;
    intLinha: Integer;
    strNumDig: String;
begin

  intLinhaAtu := 1;
  intLinha    := 0;

  {*****************************************}
  {* CHAMA AS CONFIGURAÇÕES DE IMPRESSÃO   *}
  {**************************************MV*}
  If fVerEmiBoleto(strCodBco) Then
  Begin
    With frmModuloSPR.qryCnfGen Do
    Begin
      Close;
      ParamByName('CODBCO').AsString := strCodBco;
      Open;
      First;

      While Not Eof Do
      Begin
        pI_Linhas(Self, cpuCampos, intLinhaAtu, intLinha, strNomImp);
      End;
      Close;
    End;
  End;

  {*****************************************}
  {* ATUALIZA CAMPOS NO CADREC             *}
  {**************************************MV*}
  frmModuloCadRec.fGravaNumBco(strNomeTabela, strCodBco, strCodPor, strNosNum, strNumDig, frmModuloSPR.qryGen005);

end;*)

procedure pImprimeRegistro(strNomeTabela: String;
                           Self: TObject;
                           strCodBco,
                           strCodPor,
                           strNosNum: String;
                           cpuCampos: TCamposUso;
                           strNomImp,
                           strNomPro,
                           strDesPro,
                           strBcoIni: String;
                           intCodCar: Integer;
                           qryCadOpe: TUniQuery);
  Var
    intLinhaAtu: Integer;
    intLinha: Integer;
    strNumDig: String;
    qryCnfBol: TUniQuery;
    strSQL: String;
begin

  intLinhaAtu := 1;
  intLinha    := 0;

  {*******************************************}
  {* CARREGA AS CONFIGURAÇÕES DE IMPRESSÃO   *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CNFBOL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CNF_CODBCO = :CODBCO AND ';
  strSQL := strSQL + '  CNF_CODEMP = :CODEMP ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_CODBCO, CNF_IDENTI, CNF_LINIMP, CNF_COLIMP ';

  qryCnfBol := fCriarQuery(strSQL);
  With qryCnfBol Do
  Begin
    ParamByName('CODBCO').AsString := strCodBco;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    First;

    While Not Eof Do
    Begin
      pI_Linhas(Self, cpuCampos, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, qryCnfBol);
    End;
    Close;
  End;
  FreeAndNil(qryCnfBol);

  {*****************************************}
  {* ATUALIZA CAMPOS NO CADREC             *}
  {**************************************MV*}
  fGravaNumBco(strCodBco,
               strCodPor,
               strNosNum,
               strNumDig,
               qryCadOpe,
               Nil,
               strBcoIni,
               intCodCar);

end;

Procedure pImprimeBoletosAgrupados(strNomeTabela: String; Self: TObject; strNumAgr, strNomeForm, strNomImp: String;
                                   Var strCodBco, strCodPor, strNosNum: String; fltValMor: Double;
                                   Var qryGenBl1 : TUniQuery;
                                   Var qryGenBl2 : TUniQuery;
                                   Var qryGenBl3 : TUniQuery);
  Var
    strSQL: String;

    cpuCampos: TCamposUso;
    dpcDuplicata: TDuplicataCtr;
    blnConfirma: Boolean;
    qryGenRec : TUniQuery;

begin
  Try
    qryGenRec := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strNomeTabela + ' ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = "AG" ';

    blnConfirma := True;
    If fEmptyStr(strCodBco) Then
    Begin
      blnConfirma := fDigBoleto(strCodBco, strCodPor, strNosNum, fltValMor);
    End;

    {*****************************************}
    {* SE CANCELAR, SAI                      *}
    {**************************************MV*}
    If Not blnConfirma Then
    Begin
      Exit;
    End;

    cpuCampos := Nil;

    pInicializaCamposUso(cpuCampos, qryGenBl1, qryGenBl2, qryGenBl3);

    With qryGenRec Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumAgr;
      Open;

      While Not Eof Do
      Begin

        dpcDuplicata.strNumDup := FieldByName('CTR_NUMDUP').AsString;
        dpcDuplicata.strParcel := FieldByName('CTR_PARCEL').AsString;
        dpcDuplicata.strEspDoc := FieldByName('CTR_ESPDOC').AsString;
        dpcDuplicata.strCodEmp := FieldByName('CTR_CODEMP').AsString;
        dpcDuplicata.strCodCli := FieldByName('CTR_CODCLI').AsString;

        pAtualizaCamposUso(cpuCampos, dpcDuplicata, qryGenBl1, qryGenBl2, qryGenBl3);
        //pImprimeRegistro(strNomeTabela, Self, strCodBco, strCodPor, strNosNum, cpuCampos, strNomImp);
        Next;

      End;

      Close;
    End;

  Finally
    FreeAndNil(qryGenRec);
  End;

  If Assigned(cpuCampos) Then
    FreeAndNil(cpuCampos);

end;

end.

