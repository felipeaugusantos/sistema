unit untConfiguraEtiquetasFuncoes;

interface

Uses System.SysUtils, Uni, untFuncoesSimples;

Type
  tpeImpressora = (tpiLaser, tpiZebra, tpiArgox);

  function fGetTipoImpressaoEtiquetas(strNomCfg : String) : String;
  function fGetFilaImpressaoEtiquetas(strNomCfg : String; tipoImpressao : tpeImpressora) : String;

implementation


function fGetTipoImpressaoEtiquetas(strNomCfg : String) : String;
  Var
    qryCfgEti : TUniQuery;
    arrTipoImp : Array Of String;
    arrTipoCfg : Array Of String;
Begin
  Try
    qryCfgEti := fCriaQuery;
    With qryCfgEti, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM CFGETI       ');
      Add('WHERE CFG_NOMETI = :NOMETI ');
      Add('  AND CFG_CODEMP = :CODEMP ');

      ParamByName('NOMETI').AsString := 'CFG_' + strNomCfg;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      SetLength(arrTipoImp,0);
      SetLength(arrTipoCfg,0);

      if not fEmptyStr(FieldByName('CFG_LASER_').AsString) Then
      Begin
        SetLength(arrTipoImp, Length(arrTipoImp) + 1 );
        arrTipoImp[Length(arrTipoImp) - 1] := 'Laser';

        SetLength(arrTipoCfg, Length(arrTipoCfg) + 1 );
        arrTipoCfg[Length(arrTipoCfg) - 1] := 'L';
      End;

      if not fEmptyStr(FieldByName('CFG_ZEBRA_').AsString) Then
      Begin
        SetLength(arrTipoImp, Length(arrTipoImp) + 1 );
        arrTipoImp[Length(arrTipoImp) - 1] := 'Zebra';

        SetLength(arrTipoCfg, Length(arrTipoCfg) + 1 );
        arrTipoCfg[Length(arrTipoCfg) - 1] := 'Z';
      End;

      if not fEmptyStr(FieldByName('CFG_ARGOX_').AsString) Then
      Begin
        SetLength(arrTipoImp, Length(arrTipoImp) + 1 );
        arrTipoImp[Length(arrTipoImp) - 1] := 'Argox';

        SetLength(arrTipoCfg, Length(arrTipoCfg) + 1 );
        arrTipoCfg[Length(arrTipoCfg) - 1] := 'A';
      End;

      if (Length(arrTipoImp) > 1) Then
        Result := arrTipoCfg[fMensagem('', 'Escolha o tipo de impressao', arrTipoImp, 1, False, 1, 0, False, 0, False, False, True) -1 ]
      Else if (Length(arrTipoImp) = 1) Then
        Result := arrTipoCfg[0]
      Else
        Result := fCfgSis(strNomCfg, varString);

    End;

  Finally
    FreeAndNil(qryCfgEti);
  End;

End;

function fGetFilaImpressaoEtiquetas(strNomCfg : String; tipoImpressao : tpeImpressora) : String;
  Var
    qryCfgEti : TUniQuery;
Begin
  Try
    qryCfgEti := fCriaQuery;
    With qryCfgEti, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM CFGETI       ');
      Add('WHERE CFG_NOMETI = :NOMETI ');
      Add('  AND CFG_CODEMP = :CODEMP ');

      ParamByName('NOMETI').AsString := 'CFG_' + strNomCfg;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      Case tipoImpressao Of
        tpiLaser : Result := FieldByName('CFG_LASER_').AsString;
        tpiZebra : Result := FieldByName('CFG_ZEBRA_').AsString;
        tpiArgox : Result := FieldByName('CFG_ARGOX_').AsString;
      End;

    End;

  Finally
    FreeAndNil(qryCfgEti);
  End;
End;

end.
