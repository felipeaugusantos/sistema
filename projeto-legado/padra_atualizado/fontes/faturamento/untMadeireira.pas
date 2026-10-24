unit untMadeireira;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  UniClientDataSet,
{$ENDIF}
  SysUtils,
  DB;

function fCarregaItensMadeiraImpressao(qryDados: TDataSet; Var cdsDados: TUniClientDataSet;
  blnDocSep, blnQtdOri: Boolean; strEspDoc, strDestin: String): Boolean;

function fCalculaQuantidadePecas(fltQtdTot,
                                 fltComprimento,
                                 fltLargura,
                                 fltEspessura: Double;
                                 strSiglaUni : String): Double;

Procedure pConverteMedidas(Var fltAltura : Double;
                           Var fltLargura: Double;
                           strSiglaUni   : String);

implementation

uses
{$IFDEF LINUX}
  untFuncoesGenerica;
{$ELSE}
  untFuncoesSimples;
{$ENDIF}

function fCalculaQuantidadePecas(fltQtdTot,
                                 fltComprimento,
                                 fltLargura,
                                 fltEspessura: Double;
                                 strSiglaUni  : String): Double;
begin
  If fCfgSis('VENVID',varBoolean) Then
    pConverteMedidas(fltComprimento, fltLargura, strSiglaUni);

  If fCfgSis('VENMTL',varBoolean) Then
  Begin
    If fltComprimento = 0 Then
    Begin
      Result := 0;
      Exit;
    End;

    fltLargura   := 1;
    fltEspessura := 1;
  End;

  Result := IIF(fltComprimento <= 0, 1, fltComprimento) * fltLargura * fltEspessura;

  If Result > 0 Then
    Result := fltQtdTot / Result
  Else
    Result := 0.0;

  Result := fFormataFloat(Result, 5);//Quantidade de Pecas possui precisao 5 fixa no sistema
end;

Procedure pConverteMedidas(Var fltAltura : Double;
                           Var fltLargura: Double;
                           strSiglaUni   : String);
  Var
    fltUniMed : Double;
begin
//  fltUniMed := 1;

  If (strSiglaUni = 'M2') Then
    fltUniMed := 1000 {* MILÍMETROS *}
  Else
    fltUniMed := 100; {* CENTÍMETROS *}

  fltAltura  := fltAltura / fltUniMed;
  fltLargura := fltLargura / fltUniMed;
End;

function fCarregaItensMadeiraImpressao(qryDados: TDataSet; Var cdsDados: TUniClientDataSet;
  blnDocSep, blnQtdOri: Boolean; strEspDoc, strDestin: String): Boolean;
  Var
    intCont  : Integer;
    fltQtdPec: Double;
    strApaBen: String;

  function fDeveCarregarInformacoesMadeira: Boolean;
  begin
    Result := (fltQtdPec > 0) And
              (fCfgSis('VENMTL',varBoolean) Or (Not blnDocSep) Or
               fCfgSis('MEDPED',varBoolean)) And
              (Pos(strEspDoc, 'PD_OR_MI_FF_NF_NV_IF_D1_TR_TE') > 0) And
              // Caso tenha alguma informacao de metragen
              (qryDados.FieldByName('COMPEC').AsFloat +    // Comprimento
               qryDados.FieldByName('ESPPEC').AsFloat +    // Espessura
               qryDados.FieldByName('LARPEC').AsFloat > 0);// Largura
  end;

begin
  Result := False;

  cdsDados  := fCriaClientDatset(qryDados, True);

  With cdsDados Do
  Begin
    qryDados.First;

    While Not qryDados.Eof Do
    Begin

      Append;
      For intCont := 0 To qryDados.Fields.Count -1 Do
      Begin
        Case Fields[intCont].DataType Of
          ftDate,
          ftDateTime : Fields[intCont].AsDateTime := qryDados.Fields[intCont].AsDateTime;

          ftString,
          ftWideString: Fields[intCont].AsString := qryDados.Fields[intCont].AsString;

          ftInteger,
          ftLargeInt,
          ftWord      : Fields[intCont].AsInteger := qryDados.Fields[intCont].AsInteger;

          ftFloat     : Fields[intCont].AsFloat := qryDados.Fields[intCont].AsFloat;
        Else
          Fields[intCont].Value := qryDados.Fields[intCont].Value;
        End;
      End;

      If Not blnQtdOri Then
        FieldByName('QTDPEC').AsFloat := fCalculaQuantidadePecas(FieldByName('QTDITE').AsFloat,
                                                                 FieldByName('COMPEC').AsFloat,
                                                                 FieldByName('LARPEC').AsFloat,
                                                                 FieldByName('ESPPEC').AsFloat,
                                                                 FieldByName('UNIDAD').AsString);

      If (strEspDoc = 'RQ') Then
      Begin
        FieldByName('QTDPEC').AsFloat := qryDados.FieldByName('QTDPEC').AsFloat;
        FieldByName('COMPEC').AsFloat := qryDados.FieldByName('COMPEC').AsFloat;
        FieldByName('LARPEC').AsFloat := qryDados.FieldByName('LARPEC').AsFloat;
      End;

      fltQtdPec := FieldByName('QTDPEC').AsFloat;

      If (blnDocSep) And (fltQtdPec > 0) Then
        FieldByName('DESITE').AsString := fRetNomProduto(FieldByName('CODITE').AsString);

      If fDeveCarregarInformacoesMadeira And fCfgSis('VENMTL',varBoolean) Then
      Begin
        FieldByName('SIGUNI').AsString := 'PC';
        FieldByName('UNIDAD').AsString := 'PC';
        FieldByName('DESUNI').AsString := 'PECAS';

        FieldByName('QTDITE').AsFloat := fltQtdPec;
        FieldByName('VALUNI').AsFloat := qryDados.FieldByName('VALUNI').AsFloat * qryDados.FieldByName('QTDITE').AsFloat / fltQtdPec;
        FieldByName('UNIORI').AsFloat := qryDados.FieldByName('UNIORI').AsFloat * qryDados.FieldByName('QTDITE').AsFloat / fltQtdPec;
        FieldByName('UNIDIG').AsFloat := qryDados.FieldByName('UNIDIG').AsFloat * qryDados.FieldByName('QTDITE').AsFloat / fltQtdPec;
      End;

      Post;

      strApaBen := '';

      If FieldByName('APAREL').AsString = 'S' Then strApaBen := strApaBen + '/APARELHADA';
      If FieldByName('BENEFI').AsString = 'S' Then strApaBen := strApaBen + '/BENEFICIADA';

      If Not fEmptyStr(strApaBen) Then
        system.Delete(strApaBen, 1, 1);

      If fDeveCarregarInformacoesMadeira And fCfgSis('IPMDAD',varBoolean) Then
      Begin
        Result := True;

        Append;

        If fCfgSis('VENMAD',varBoolean) Then
          FieldByName('DESITE').AsString := 'QTD.: '   + FloatToStrF( fltQtdPec                             , ffFixed, 12, 00 ) + ' ' +
                                            'COMP.: '  + FloatToStrF( qryDados.FieldByName('COMPEC').AsFloat, ffFixed, 12, 05 ) + ' ' +
                                            'LARG.: '  + FloatToStrF( qryDados.FieldByName('LARPEC').AsFloat, ffFixed, 12, 05 ) + ' ' +
                                            'ESPES.: ' + FloatToStrF( qryDados.FieldByName('ESPPEC').AsFloat, ffFixed, 12, 05 ) + ' ' + strApaBen
        Else If fCfgSis('VENMTL', varBoolean) Then
          FieldByName('DESITE').AsString := FloatToStrF( fltQtdPec                             , ffFixed, 12, 05 ) + ' PECAS DE ' +
                                            FloatToStrF( qryDados.FieldByName('COMPEC').AsFloat, ffFixed, 12, 05 ) + ' MTS = ' +
                                            FloatToStrF( qryDados.FieldByName('QTDITE').AsFloat, ffFixed, 12, 05 ) + ' '
        Else
          FieldByName('DESITE').AsString := 'QTD.: '   + FloatToStrF( fltQtdPec                             , ffFixed, 12, 00 ) + ' ' +
                                            'LARG.: '  + FloatToStrF( qryDados.FieldByName('LARPEC').AsFloat, ffFixed, 12, StrToIntDef(fFormataCasaDecimalVIDRO('5'),0)) + ' ' +
                                            UpperCase(fRetornaInfMedVIDRO(True,True,False,False,True))+ FloatToStrF( qryDados.FieldByName('COMPEC').AsFloat, ffFixed, 12, StrToIntDef(fFormataCasaDecimalVIDRO('5'),0)) + ' ' ;

        Post;
      End;

      qryDados.Next;
    End;

  End;

end;

end.
