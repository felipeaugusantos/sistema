unit untImpOrdemServico;

interface

uses SysUtils, Uni, DB, WinSpool, untImpNaoFiscal, Dialogs, StrUtils,UniDataSetProvider,
  Windows, Forms, Classes, UniClientDataSet, frxClass, untFuncFatTypes, untConsertoEquipamento,
  untFuncoesSimples, untFuncoesGenerica, Math, Graphics, MaskUtils, DateUtils, untImpMatricial;


Type
  TImpOrdemServico = class(TObject)
    protected
      FEmpFat: Boolean;
      FBarSep: Boolean;
      FDesImp: String;
      F40ColS: String;
      FDadSep: TUniClientDataSet;
      FTipNomEmp: String;

      FConEqu: TConEqu;
      FcdsEqu: TUniClientDataSet;
      FDesEqu: TStringList;
      FObsEqu: TStringList;

      FQtdLin: Integer;
      FNomImp: String;
      FArqImp: TextFile;

      FNumDoc: String;
      FNumPed: String;
      FTransp: String;
      FEspDoc: String;
      FCodEmp: String;
      FMsg_CD: String;
      FEntRet: String;
      FDocSep: Boolean;
      FSepFut: Boolean;
      FEnt_CD: Boolean;

      FImpTck: Boolean;
      FConfir: Boolean;
      FValSep: Boolean;

      FblnRecCliGar: Boolean;
      FOpcDoc: String;

      FstlRod: TStringList; //Usado para impressao de um rodape adicional para MI e FF

      intPagina: Integer;
      intLinImp: Integer;
      intQtdFol: Integer;
      intLinPag: Integer;
      intQtdFolOri: Integer;
      intQtdAdc: Integer; // quantidade de itens adicionais quando tem mais de uma pagina
      intQtdPag: Integer;
      intIteImp: Integer;
      intTotIteImp: Integer;

      strRisco : String;
      PrinterHandler: NativeUInt;
      impMatricial: TImpMatricial;
      blnMeiFol: Boolean; // Impressao em Meia Folha

      qryCadEmp: TUniQuery;
      qryCadEmpPed: TUniQuery;

      procedure pCarregaEmpresa(strCodEmp: String);

      procedure SetNomImp(strImp: String);

      procedure pImprimeOS;
      procedure pImprimeOSGenerico;
      procedure pImprimeOSCabGenerico;
      procedure pImprimeOSRodGenerico(blnTotal: Boolean);

      function CadEmp(strCampo: String): TField;
      function CadEmpPed(strCampo: String): TField;

      procedure pCabEmpresa74Col(blnEmpPed: Boolean = False);
    public
      strNroVia: String;

      procedure pImprimeOrdemServico(objConEqu: TConEqu; cdsImpressao: TUniClientDataSet);

      Constructor Create(strNomImp: String; blnConfir: Boolean);
      Destructor Destroy; override;
  end;

implementation

uses untFuncoes, untConstantes, untValorPorExtenso;

{TImpOrdemServico}


constructor TImpOrdemServico.Create(strNomImp: String; blnConfir: Boolean);
begin
  inherited Create;

  qryCadEmpPed := fCriaQuery;
  qryCadEmp    := fCriaQuery;

  FNomImp      := strNomImp;

  impMatricial := TImpMatricial.Create(FNomImp);
end;

destructor TImpOrdemServico.Destroy;
begin
  qryCadEmp.Close;
  qryCadEmpPed.Close;

  FreeAndNil(qryCadEmp);
  FreeAndNil(qryCadEmpPed);

  FreeAndNil(impMatricial);

  inherited Destroy;
end;

procedure TImpOrdemServico.pCarregaEmpresa(strCodEmp: String);
Begin
  With qryCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SQL_NO_CACHE           ');
    SQL.Add('  CADEMP.*,                   ');
    SQL.Add('  CID_NOMCID AS EMP_NOMCID,   ');
    SQL.Add('  CID_ESTADO AS EMP_ESTADO    ');
    SQL.Add('FROM                          ');
    SQL.Add('  CADEMP,                     ');
    SQL.Add('  CADCID                      ');
    SQL.Add('WHERE                         ');
    SQL.Add('  CID_CODCID = EMP_CODCID AND ');
    SQL.Add('  EMP_CODEMP = :CODEMP        ');
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
  End;
End;

function TImpOrdemServico.CadEmp(strCampo: String): TField;
begin
  Result := qryCadEmp.FieldByName('EMP_' + strCampo);
end;

function TImpOrdemServico.CadEmpPed(strCampo: String): TField;
begin
  Result := qryCadEmpPed.FieldByName('EMP_' + strCampo);
end;

procedure TImpOrdemServico.pImprimeOrdemServico(objConEqu: TConEqu; cdsImpressao: TUniClientDataSet);
Begin
  FConEqu := objConEqu;
  FcdsEqu := cdsImpressao;

  If (fEmptyStr(FNomImp)) Then
  Begin
    Raise Exception.Create('O nome da impressora não está definido!');
  End;

  blnMeiFol := (fCfgSis('LAY_OS') = '1');

  impMatricial.pSetaInfoImpressoraMatricial('Impressão de Ordem de Serviço', True, True);
  intPagina    := 0;

  pCarregaEmpresa(FConEqu.strCodEmp);

  impMatricial.pInicializarImpressoraMatricial;

  pImprimeOS;

  impMatricial.pFinalizarImpressoraMatricial;
End;

procedure TImpOrdemServico.SetNomImp(strImp: String);
begin
  If (fEmptyStr(strImp)) Then
    Raise Exception.Create('O nome da impressora deve ser informado!');

  FNomImp := strImp;
end;


procedure TImpOrdemServico.pCabEmpresa74Col(blnEmpPed: Boolean = False);
begin
  If (fCfgSis('RAZFAN') = 'R') Then
  Begin
    If (blnEmpPed) Then
      impMatricial.Imp(impMatricial.Expandido(True) + Copy(fPadR(CadEmpPed('NOMEMP').AsString, 74), 1, 40) + impMatricial.Expandido(False) + fPadR(strNroVia,   6))
    Else
      impMatricial.Imp(impMatricial.Expandido(True) + Copy(fPadR(CadEmp('NOMEMP').AsString, 74), 1, 40) + impMatricial.Expandido(False) + fPadR(strNroVia,   6));
  End
  Else
  Begin
    If Not fEmptyStr(CadEmp('NOMFAN').AsString) Then
    Begin
      If (blnEmpPed) Then
        impMatricial.Imp(impMatricial.Expandido(True) + Copy(fPadR(CadEmpPed('NOMFAN').AsString, 74), 1, 40) + impMatricial.Expandido(False) + fPadR(strNroVia,   6))
      Else
        impMatricial.Imp(impMatricial.Expandido(True) + Copy(fPadR(CadEmp('NOMFAN').AsString, 74), 1, 40) + impMatricial.Expandido(False) + fPadR(strNroVia,   6));
    End
    Else
    Begin
      If (blnEmpPed) Then
        impMatricial.Imp(impMatricial.Expandido(True) + Copy(fPadR(CadEmpPed('NOMEMP').AsString, 74), 1, 40) + impMatricial.Expandido(False) + fPadR(strNroVia,   6))
      Else
        impMatricial.Imp(impMatricial.Expandido(True) + Copy(fPadR(CadEmp('NOMEMP').AsString, 74), 1, 40) + impMatricial.Expandido(False) + fPadR(strNroVia,   6));
    End;
  End;
end;


procedure TImpOrdemServico.pImprimeOS;
begin
  pImprimeOSGenerico

end;

procedure TImpOrdemServico.pImprimeOSGenerico;
  Var
    intQtdDiv: Integer;
    intQtdReg: Integer;
    intCabPri: Integer;
begin

  If blnMeiFol Then
  Begin
    intQtdFol    := 25;
    intQtdFolOri := 25;
    intQtdAdc    := 4;
  End
  Else
  Begin
    intQtdFol    := 70;
    intQtdFolOri := 70;
    intQtdAdc    := 4;
  End;

  intQtdPag := 1;

  FDesEqu      := TStringList.Create;
  FDesEqu.Text := FConEqu.strDescri;

  FObsEqu      := TStringList.Create;
  FObsEqu.Text := FConEqu.strObserv;

  intCabPri := 6 + FDesEqu.Count + IIF(FObsEqu.Count=0,0,FObsEqu.Count+1); // TAMANHO DO CABECALHO QUE SO ENTRA NA PRIMEIRA PAGINA
  intQtdReg := FcdsEqu.RecordCount + intCabPri;

  If (intQtdReg > intQtdFol) Then
  Begin
    intQtdDiv := intQtdReg - intQtdFol;
    intQtdPag := (intQtdDiv Div (intQtdFol + intQtdAdc));
    If (intQtdDiv / (intQtdFol + intQtdAdc) > intQtdPag) Then
      Inc(intQtdPag);
    Inc(intQtdPag);
  End;

  FcdsEqu.First;
  intIteImp    := 0;
  intTotIteImp := 0;

  With FcdsEqu Do
  Begin
    While (Not Eof) Do
    Begin

      If (intIteImp = 0) Or (intIteImp >= intQtdFol) Then
      Begin

        If (intIteImp = 0) Or (intQtdFol > intQtdFolOri) Then
        Begin
          pImprimeOSCabGenerico;

          If (intIteImp > 0) Then
            Dec(intQtdFol, intQtdAdc);

          intIteImp := 0;

          If IntPagina = 1 Then
          Begin
            intIteImp    := intCabPri;
            intTotIteImp := intCabPri;
          End;
        End
        Else
        Begin
          If (intTotIteImp >= intQtdReg) Then
          Begin
            pImprimeOSCabGenerico;
            intIteImp := 0;
            Break;
          End
          Else
            Inc(intQtdFol, intQtdAdc);
        End;
      End;

      If Not fEmptyStr(FieldByName('DESITE').AsString) Then
      Begin
        If fEmptyStr(FieldByName('QTDITE').AsString) Then
          impMatricial.Imp(fPadR(FieldByName('CODITE').AsString, 08) + ' ' +
              fPadR(FieldByName('DESITE').AsString,
              70) + ' ' +
              fPadR(FieldByName('LOCFIS').AsString, 10) + ' ' +
              fPadL('', 10) + ' ' +
              fPadL('', 14) + ' ' +
              fPadL(FloatToStrf(FieldByName('TOTITE').AsFloat, ffFixed, 14, 2), 14))
        Else
          impMatricial.Imp(fPadR(FieldByName('CODITE').AsString, 08) + ' ' +
              fPadR(FieldByName('DESITE').AsString,
              70) + ' ' +
              fPadR(FieldByName('LOCFIS').AsString, 10) + ' ' +
              fPadL(FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 14, fCfgSis('DECQTD', varInteger)), 10) + ' ' +
              fPadL(FloatToStrf(FieldByName('UNITAR').AsFloat, ffFixed, 14, 2), 14) + ' ' +
              fPadL(FloatToStrf(FieldByName('TOTITE').AsFloat, ffFixed, 14, 2), 14));
      End;

      Inc(intIteImp);
      Inc(intTotIteImp);

      Next;
    End;
  End;

  If (intIteImp > intQtdFolOri) Or (FcdsEqu.IsEmpty) Then
  Begin
    pImprimeOSCabGenerico;

    If (IntPagina = 1) And (FcdsEqu.IsEmpty) Then
    Begin
      intIteImp    := intCabPri;
      intTotIteImp := intCabPri;
    End;
  End;

  pImprimeOSRodGenerico(True);
end;

procedure TImpOrdemServico.pImprimeOSCabGenerico;
  Var
    strControle: String;
    intContador: Integer;
begin
  strControle := '';

  Inc(intPagina);

  strControle := IntToStr(intPagina) + '/' + IntToStr(intQtdPag);

  If intPagina > 1 Then
  Begin
    pImprimeOSRodGenerico(False);
    intLinImp := 0;
  End;

  strRisco  := fReplicatorStr('-', 80);

  {*******************************************}
  {* CONFIGURA O RELATÓRIO                   *}
  {****************************************MV*}
  impMatricial.Reseta;
  impMatricial.Imp(impMatricial.Cond_10CPI(False), False);
  impMatricial.Imp(impMatricial.CPI_12(False), False);
  impMatricial.Imp(impMatricial.Um_Oitavo(True), False);

  If blnMeiFol Then
    impMatricial.Imp(impMatricial.TamPag(43), False)
  Else
    impMatricial.Imp(impMatricial.TamPag(87), False);

  {*******************************************}
  {* IMPRIME DADOS DA EMPRESA                *}
  {****************************************MV*}
  pCabEmpresa74Col;

  impMatricial.Imp(impMatricial.Expandido(True) + fPadR(fFormataFone(CadEmp('FONE01').AsString), 74) + impMatricial.Expandido(False) + fPadR(strControle, 5));
  impMatricial.Imp('Cidade..: ' + fPadR(CadEmp('NOMCID').AsString + '-' + CadEmp('ESTADO').AsString , 40) + ' Bairro.: ' + fPadR(CadEmp('BAIRRO').AsString, 18));
  impMatricial.Imp('Endereco: ' + fPadR(CadEmp('ENDERE').AsString + ' ' + CadEmp('ENDNUM').AsString + ' ' + CadEmp('ENDCMP').AsString, 40) + 'Cep....: ' + fPadR(CadEmp('C_E_P_').AsString, 18));
  strControle := '';
  impMatricial.Imp(strRisco);

  impMatricial.Imp(FConEqu.strTitImp, True);

  If intPagina = 1 Then
  Begin
    impMatricial.Imp(strRisco);
    impMatricial.Imp('Cliente..: ' + fPadR(FConEqu.strCliImp, 69));
    impMatricial.Imp('Endereco.: ' + fPadR(FConEqu.strEndImp, 69));
    impMatricial.Imp('Bairro...: ' + fPadR(FConEqu.strBaiImp, 23) + ' CEP: ' + fPadR(FConEqu.strCepImp, 09) + ' Municipio: ' + fPadR(FConEqu.strCidImp, 19));
    impMatricial.Imp('Fone.....: ' + fPadR(fFormataFone(FConEqu.strFonImp), 18));
    impMatricial.Imp(impMatricial.Cond_10CPI(True) + '-----------------------------------------------------------------------------------------------------------------------------------------');

    If FDesEqu.Count > 0 Then
      impMatricial.Imp('EQUIPAMENTO: ' + FDesEqu[0])
    Else
      impMatricial.Imp('EQUIPAMENTO: ');

    For intContador := 1 To FDesEqu.Count - 1 Do
      impMatricial.Imp('             ' + FDesEqu[intContador]);

    FreeAndNil(FDesEqu);

    If Not fEmptyStr(FObsEqu.Text) Then
    Begin
      impMatricial.Imp('-----------------------------------------------------------------------------------------------------------------------------------------');
      impMatricial.Imp('OBSERVACOES: ' + FObsEqu[0]);

      For intContador := 1 To FObsEqu.Count - 1 Do
        impMatricial.Imp('             ' + FObsEqu[intContador]);
    End;

    FreeAndNil(FObsEqu);
  End;

  impMatricial.Imp(impMatricial.Cond_10CPI(True) + '-----------------------------------------------------------------------------------------------------------------------------------------');
  impMatricial.Imp('CODIGO  DESCRICAO DO ITEM                                                       LOC.FISICA QUANTIDADE    VR UNITARIO    VALOR TOTAL');
  impMatricial.Imp('-----------------------------------------------------------------------------------------------------------------------------------------');

end;

procedure TImpOrdemServico.pImprimeOSRodGenerico(blnTotal: Boolean);
  Var
    intContador: Integer;
begin

  If (blnTotal) And (intIteImp > intQtdFolOri) And (Not FcdsEqu.IsEmpty) Then
  Begin
    For intContador := 1 To intQtdFolOri Do
    Begin
      impMatricial.Imp('');
    End;
  End
  Else
  Begin
    For intContador := Succ(intIteImp) To intQtdFol Do
    Begin
      impMatricial.Imp('');
    End;
  End;

  If (blnTotal) Then
  Begin

    impMatricial.Imp('-----------------------------------------------------------------------------------------------------------------------------------------');

    //  'CODIGO DESCRICAO DO ITEM                                                                    QUANTIDADE    VR UNITARIO    VALOR TOTAL');

    impMatricial.Imp('                                                                                                              TOTAL:  ' + fPadL(FloatToStrf(FConEqu.fltVlrCon, ffFixed, 14, 2), 14));
    impMatricial.Imp('-----------------------------------------------------------------------------------------------------------------------------------------');

    impMatricial.Imp('VENDEDOR: ' + fPadR(FConEqu.strCodVen + ' - ' + fRetNomVendRep(FConEqu.strCodVen), 91) + 'DATA: ' + FConEqu.strDtaEnt + ' HORA: ' + FConEqu.strHorEnt);
    impMatricial.Imp('TECNICO.: ' + FConEqu.strCodTec + ' - ' + fRetNomeOperador(FConEqu.strCodTec));
  End
  Else
  Begin
    impMatricial.Imp('IMPRESSAO CONTINUA NA PROXIMA PAGINA');
  End;

  impMatricial.Eject;
end;

end.
