unit untLazzumixAutomotivaDOS;

interface

  uses  SysUtils,  Classes, Uni, StrUtils, Variants,
        Dialogs, Forms,
        DB;

Type
  TMatGra = Record
    fltGraAcm: Double;
    bkmRecNo : TBookmark;
End;

  function fRetValFor(strValStr: String): Double;
  function fFormulaExiste(strCodigo, strDilCon: String; fltQtdPro, fltNumBas: Double): Boolean;
  function fProdutoExiste(strCodigo: String): Boolean;

  function fGravaLazMixFor(strCodigo,
                           strDilCon: String;
                           fltQtdPro,
                           fltNumBas: Double;
                           strCodBas: String;
                           fltGraAcm: Double): Boolean;

  function fGravaLazCadMix(strCodigo,
                           strDescri,
                           strRefere,
                           strAno,
                           strMontad,
                           strUniver: String;
                           fltPreco2,
                           fltPreco3,
                           fltPreco4: Double;
                           strLin10,
                           strLin11: String): Boolean;


  //function fConsultaLazzumix(Sender: TForm): Integer;
  //function fConsultaLazzumixGeral(Sender: TForm): Integer;
  //function fConsultaLazzumixVenda(Sender: TForm; Var qryCadMix: TUniQuery): Integer;

  function fLazzumixGeraArquivoDOS: Boolean;

  Var
    intAutIncMixFor: Integer;

implementation

uses untFuncoesSimples, untFuncoes,
    untModuloTinta,  untIConfTinta, untFuncTinta;

//uses untConsultaCadMix, untConsultaCadMixVenda, untConsultaCadMixGeral;

function fRetValFor(strValStr: String): Double;
begin
{  
  If (strLazSep = ',') Then
  Begin
    strValAtu := AnsiReplaceStr(strValStr, ',', '');
    strValAtu := AnsiReplaceStr(strValAtu, '.', ',');
  End
  Else
  Begin
    strValAtu := strValStr;
  End;}

  Result := fStrToFloat(AnsiReplaceStr(strValStr, '.', ','));
end;

function fFormulaExiste(strCodigo, strDilCon: String; fltQtdPro, fltNumBas: Double): Boolean;
  Var
    strSQL: String;
begin

  fltQtdPro := fFormataFloat(fltQtdPro, 04);
  fltNumBas := fFormataFloat(fltNumBas, 04);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_MIXFOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MIX_CODIGO = :CODIGO AND ';
  strSQL := strSQL + '  LEFT(MIX_DILCON, 1) = :DILCON AND ';
  strSQL := strSQL + '  MIX_QTDPRO = :QTDPRO AND ';
  strSQL := strSQL + '  MIX_NUMBAS = :NUMBAS AND ';
  strSQL := strSQL + '  MIX_CODEMP = :CODEMP ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODIGO').AsString := strCodigo;
    ParamByName('DILCON').AsString := LeftStr(strDilCon, 1);
    ParamByName('QTDPRO').AsFloat  := fltQtdPro;
    ParamByName('NUMBAS').AsFloat  := fltNumBas;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;

end;

function fProdutoExiste(strCodigo: String): Boolean;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_CADMIX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MIX_CODIGO = :CODIGO ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODIGO').AsString := strCodigo;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;
end;

function fGravaLazMixFor(strCodigo,
                         strDilCon: String;
                         fltQtdPro,
                         fltNumBas: Double;
                         strCodBas: String;
                         fltGraAcm: Double): Boolean;
  Var
    strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'INSERT DELAYED IGNORE INTO ';
    strSQL := strSQL + '  LAZ_MIXFOR ';
    strSQL := strSQL + '( ';
    strSQL := strSQL + '  MIX_CODIGO, ';
    strSQL := strSQL + '  MIX_DILCON, ';
    strSQL := strSQL + '  MIX_QTDPRO, ';
    strSQL := strSQL + '  MIX_NUMBAS, ';
    strSQL := strSQL + '  MIX_CODBAS, ';
    strSQL := strSQL + '  MIX_GRABAS, ';
    strSQL := strSQL + '  MIX_GRAACM, ';
    strSQL := strSQL + '  MIX_CODEMP, ';
    strSQL := strSQL + '  AUTOINCREM ) ';
    strSQL := strSQL + 'VALUES ';
    strSQL := strSQL + '(  ';
    strSQL := strSQL + '  :MIX_CODIGO, ';
    strSQL := strSQL + '  :MIX_DILCON, ';
    strSQL := strSQL + '  :MIX_QTDPRO, ';
    strSQL := strSQL + '  :MIX_NUMBAS, ';
    strSQL := strSQL + '  :MIX_CODBAS, ';
    strSQL := strSQL + '  :MIX_GRABAS, ';
    strSQL := strSQL + '  :MIX_GRAACM, ';
    strSQL := strSQL + '  :MIX_CODEMP, ';
    strSQL := strSQL + '  :AUTOINCREM ) ';

    With frmModuloTinta.qryGen001 Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('MIX_CODIGO').AsString  := strCodigo;
      ParamByName('MIX_DILCON').AsString  := AnsiUpperCase(strDilCon);
      ParamByName('MIX_QTDPRO').AsFloat   := fltQtdPro;
      ParamByName('MIX_NUMBAS').AsFloat   := fltNumBas;
      ParamByName('MIX_CODBAS').AsString  := strCodBas;
      ParamByName('MIX_GRABAS').AsFloat   := fltGraAcm;
      ParamByName('MIX_GRAACM').AsFloat   := 0.0;
      ParamByName('MIX_CODEMP').AsString  := VS_strCodEmp;
      ParamByName('AUTOINCREM').AsString  := fFormataAutInc(intAutIncMixFor, VS_strCodEmp);
      ExecSQL;
      Close;

      Inc(intAutIncMixFor);

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaLazMixFor]');
      Result := False;
    End;
  End;

end;

function fGravaLazCadMix(strCodigo,
                         strDescri,
                         strRefere,
                         strAno,
                         strMontad,
                         strUniver: String;
                         fltPreco2,
                         fltPreco3,
                         fltPreco4: Double;
                         strLin10,
                         strLin11: String): Boolean;
begin

  Try

    With frmModuloTinta.qryLaz_CadMix Do
    Begin

      If (Not Active) Then
      Begin
        Open;
      End;

      Insert;
      FieldByName('MIX_CODIGO').AsString  := AnsiReplaceStr(strCodigo, '.', '');
      FieldByName('MIX_DESCRI').AsString  := strDescri;
      FieldByName('MIX_REFERE').AsString  := strRefere;
      FieldByName('MIX_A_N_O_').AsString  := RightStr(strAno, 4);
      FieldByName('MIX_MONTAD').AsString  := strMontad;
      FieldByName('MIX_UNIVER').AsString  := strUniver;
      FieldByName('MIX_PRECO2').AsFloat   := fFormataFloat(fltPreco2, 3);
      FieldByName('MIX_PRECO3').AsFloat   := fFormataFloat(fltPreco3, 3);
      FieldByName('MIX_PRECO4').AsFloat   := fFormataFloat(fltPreco4, 3);

      If (LeftStr(strCodigo, 2) <> '04') Then
        FieldByName('MIX_PRECO1').AsFloat := fFormataFloat(fRetValFor(strLin10), 2)
      Else
        FieldByName('MIX_PRECO1').AsFloat := fFormataFloat(fRetValFor(strLin11), 2);

//      If (LeftStr(strCodigo, 2) <> '04') Then
//        FieldByName('MIX_PRECO1').AsFloat := fFormataFloat(fStrToFloat(strLin10), 2)
//      Else
//        FieldByName('MIX_PRECO1').AsFloat := fFormataFloat(fStrToFloat(strLin11), 2);

      FieldByName('MIX_CODEMP').AsString  := VS_strCodEmp;
      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('LAZ_CADMIX', VS_strCodEmp);
      Post;
      Result := True;

    End;

  Except
    On E: Exception Do
    Begin
      Result := True;
      //pMensagensErro(E.Message, '[fGravaLazCadMix]');
    End;
  End;

end;

(*function fConsultaLazzumix(Sender: TForm): Integer;
  Var
    strSQL: String;
    stlCamIndMix: TStringList;
    stlDesIndMix: TStringList;
begin

  Application.CreateForm(TfrmConsultaCadMix, frmConsultaCadMix);

  stlCamIndMix := TStringList.Create;
  stlDesIndMix := TStringList.Create;

  stlCamIndMix.Add('MIX_DESCRI');
  stlCamIndMix.Add('MIX_CODIGO');
  stlCamIndMix.Add('MIX_REFERE');

  stlDesIndMix.Add('Descricao');
  stlDesIndMix.Add('Codigo');
  stlDesIndMix.Add('Referencia');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  MIX_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  MIX_CODIGO AS "Codigo", ';
  strSQL := strSQL + '  MIX_REFERE AS "Referencia", ';
  strSQL := strSQL + '  MIX_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  MIX_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  MIX_PRECO1, ';
  strSQL := strSQL + '  MIX_PRECO2, ';
  strSQL := strSQL + '  MIX_PRECO3, ';
  strSQL := strSQL + '  MIX_PRECO4, ';
  strSQL := strSQL + '  (MIX_PRECO1 * 4) AS MIX_PRECO1_4, ';
  strSQL := strSQL + '  (MIX_PRECO2 * 4) AS MIX_PRECO2_4, ';
  strSQL := strSQL + '  (MIX_PRECO3 * 4) AS MIX_PRECO3_4, ';
  strSQL := strSQL + '  (MIX_PRECO4 * 4) AS MIX_PRECO4_4, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_CADMIX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM > 0 ';

  Result := -1;
  If pConsultaEspecifica(Sender, frmConsultaCadMix, frmModuloCons.qryConsulta01, 'LAZ_CADMIX',
      strSQL, stlCamIndMix, stlDesIndMix) Then
  Begin
    Result := frmModuloCons.qryConsulta01.FieldByName('AUTOINCREM').AsInteger;
  End;

  FreeAndNil(stlCamIndMix);
  FreeAndNil(stlDesIndMix);

  FreeAndNil(frmConsultaCadMix);

end;

function fConsultaLazzumixGeral(Sender: TForm): Integer;
  Var
    strSQL: String;
    stlCamIndMix: TStringList;
    stlDesIndMix: TStringList;
begin

  Application.CreateForm(TfrmConsultaCadMixGeral, frmConsultaCadMixGeral);

  stlCamIndMix := TStringList.Create;
  stlDesIndMix := TStringList.Create;

  stlCamIndMix.Add('MIX_DESCRI');
  stlCamIndMix.Add('MIX_CODIGO');
  stlCamIndMix.Add('MIX_REFERE');

  stlDesIndMix.Add('Descricao');
  stlDesIndMix.Add('Codigo');
  stlDesIndMix.Add('Referencia');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  MIX_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  MIX_CODIGO AS "Codigo", ';
  strSQL := strSQL + '  MIX_REFERE AS "Referencia", ';
  strSQL := strSQL + '  MIX_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  MIX_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  MIX_PRECO1, ';
  strSQL := strSQL + '  MIX_PRECO2, ';
  strSQL := strSQL + '  MIX_PRECO3, ';
  strSQL := strSQL + '  MIX_PRECO4, ';
  strSQL := strSQL + '  (MIX_PRECO1 * 4) AS MIX_PRECO1_4, ';
  strSQL := strSQL + '  (MIX_PRECO2 * 4) AS MIX_PRECO2_4, ';
  strSQL := strSQL + '  (MIX_PRECO3 * 4) AS MIX_PRECO3_4, ';
  strSQL := strSQL + '  (MIX_PRECO4 * 4) AS MIX_PRECO4_4, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_CADMIX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM > 0 ';

  Result := -1;
  If pConsultaEspecifica(Sender, frmConsultaCadMixGeral, frmModuloCons.qryConsulta01, 'LAZ_CADMIX',
      strSQL, stlCamIndMix, stlDesIndMix) Then
  Begin
    Result := frmModuloCons.qryConsulta01.FieldByName('AUTOINCREM').AsInteger;
  End;

  FreeAndNil(stlCamIndMix);
  FreeAndNil(stlDesIndMix);

  FreeAndNil(frmConsultaCadMixGeral);
end;

function fConsultaLazzumixVenda(Sender: TForm; Var qryCadMix: TUniQuery): Integer;
  Var
    strSQL: String;
    stlCamIndMix: TStringList;
    stlDesIndMix: TStringList;
begin

  Application.CreateForm(TfrmConsultaCadMixVenda, frmConsultaCadMixVenda);

  stlCamIndMix := TStringList.Create;
  stlDesIndMix := TStringList.Create;

  stlCamIndMix.Add('MIX_DESCRI');
  stlCamIndMix.Add('MIX_CODIGO');
  stlCamIndMix.Add('MIX_REFERE');

  stlDesIndMix.Add('Descricao');
  stlDesIndMix.Add('Codigo');
  stlDesIndMix.Add('Referencia');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  MIX_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  MIX_CODIGO AS "Codigo", ';
  strSQL := strSQL + '  MIX_REFERE AS "Referencia", ';
  strSQL := strSQL + '  MIX_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  MIX_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  MIX_PRECO1, ';
  strSQL := strSQL + '  MIX_PRECO2, ';
  strSQL := strSQL + '  MIX_PRECO3, ';
  strSQL := strSQL + '  MIX_PRECO4, ';
  strSQL := strSQL + '  (MIX_PRECO1 * 4) AS MIX_PRECO1_4, ';
  strSQL := strSQL + '  (MIX_PRECO2 * 4) AS MIX_PRECO2_4, ';
  strSQL := strSQL + '  (MIX_PRECO3 * 4) AS MIX_PRECO3_4, ';
  strSQL := strSQL + '  (MIX_PRECO4 * 4) AS MIX_PRECO4_4, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_CADMIX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM > 0 ';

  Result := -1;
  If pConsultaEspecifica(Sender, frmConsultaCadMixVenda, qryCadMix, 'LAZ_CADMIX',
      strSQL, stlCamIndMix, stlDesIndMix) Then
  Begin
    Result := qryCadMix.FieldByName('AUTOINCREM').AsInteger;
  End;

  FreeAndNil(stlCamIndMix);
  FreeAndNil(stlDesIndMix);

  FreeAndNil(frmConsultaCadMixVenda);

end;*)

function fLazzumixGeraArquivoDOS: Boolean;
  Var
    strPatLpr: String;
    strPatLfo: String;

    stlArqPro: TStringList;
    stlArqFor: TStringList;

    intQtdLin: Integer;
    intPosSpc: Integer;
    intContador1: Integer;
    intContador2: Integer;

    blnGraReg: Boolean;

    arqLazTxt: TextFile;

    strLin01: String;
    strLin02: String;
    strLin03: String;
    strLin04: String;
    strLin05: String;
    strLin06: String;
    strLin07: String;
    strLin08: String;
    strLin09: String;
    strLin10: String;
    strLin11: String;
    strLin12: String;
    strAnterior: String;

    fltQtdPro: Double;

    intContProc: Integer;

    stlArqMixFor: TStringList;
    intLinhaMixFor: Integer;
    intQtdMixFor: Integer;

    fltValAcu: Double;
    strLin01Ant: String;
    strLin03Ant: String;
    fltQtdGra: Double;
    conf: IConfTinta;
begin

  Result := False;
  intAutIncMixFor := 1;

  stlArqMixFor := TStringList.Create;

  stlArqPro := TStringList.Create;
  stlArqFor := TStringList.Create;

  conf := fGetConfTinta('LAZ');

  strPatLpr := conf.fGet('LAZPPR');
  strPatLfo := conf.fGet('LAZPFO');

  If (Not FileExists(strPatLpr)) Then
  Begin
    fMensagem('', 'Não foi possivel encontrar o arquivo de atualização PRODUTO.TXT no ' +
                  'diretorio ' + strPatLpr, ['&Ok']);
    Exit;
  End;

  If (fArqIniTinta(0, 'USA_FORMUL', 'LAZ', 'S') = 'S') Then
  Begin
    If (Not FileExists(strPatLfo)) Then
    Begin
      fMensagem('', 'Não foi possivel encontrar o arquivo de atualização FORMULA.TXT no ' +
                    'diretorio ' + strPatLfo, ['&Ok']);
      Exit;
    End;
  End;

  If (Not fEmptyStr(strPatLpr)) Then
    stlArqPro.Add(strPatLpr);

  If (Not fEmptyStr(strPatLfo)) Then
    stlArqFor.Add(strPatLfo);

  {*****************************************}
  {* ZAPEIA ARQUIVO DE FORMULAS            *}
  {**************************************MV*}
  pZapTable('LAZ_MIXFOR');

  {*****************************************}
  {* IMPORTA ARQUIVO DE FORMULAS           *}
  {**************************************MV*}
  fltValAcu   := 0.0;
  strLin01Ant := '';
  strLin03Ant := '';

  intQtdLin := 6;
  For intContador1 := 0 To stlArqFor.Count -1 Do   //DETINHO -> IRA VOLTAR (ESQUINA)
  Begin

    intContProc := 0;
    intLinhaMixFor := 0;
    stlArqMixFor.LoadFromFile(stlArqFor[intContador1]);
    intQtdMixFor   := stlArqMixFor.Count;

    While (intLinhaMixFor < intQtdMixFor) Do
    Begin

      If intContProc > 2000 Then
      Begin
        Application.ProcessMessages;
        intContProc := 0;
      End;

      Inc(intContProc);

      blnGraReg := False;
      For intContador2 := 1 To intQtdLin Do
      Begin

        If (Ord(stlArqMixFor[intLinhaMixFor][1]) < 32) Then
        Begin
          Inc(intLinhaMixFor);
          Break;
        End;

        {****************************************************}
        {* A ANTIGA LINHA 3 NO ARQUIVO DA LAZZUMIX, É AGORA *}
        {* UM INDICADOR SE É TINTA ANTIGA OU NAO            *}
        {*************************************************MV*}
        Case intContador2 Of

          1:Begin
              strLin01 := stlArqMixFor[intLinhaMixFor];
              If (Not fEmptyStr(strLin01)) Then
              Begin
                blnGraReg := True;
              End;
            End;
          {2: strLin02    := stlArqMixFor[intLinhaMixFor];
          3: strAnterior := stlArqMixFor[intLinhaMixFor]; // Linha 3: Anterior
          4: strLin03    := stlArqMixFor[intLinhaMixFor];
          5: strLin04    := stlArqMixFor[intLinhaMixFor];
          6: strLin05    := stlArqMixFor[intLinhaMixFor];
          7: strLin06    := stlArqMixFor[intLinhaMixFor];}

          2: strLin02    := stlArqMixFor[intLinhaMixFor];
          3: strLin03    := stlArqMixFor[intLinhaMixFor];
          4: strLin04    := stlArqMixFor[intLinhaMixFor];
          5: strLin05    := stlArqMixFor[intLinhaMixFor];
          6: strLin06    := stlArqMixFor[intLinhaMixFor];

        End;
        Inc(intLinhaMixFor);

      End;

      If (Pos('ANTERIOR', AnsiUpperCase(strAnterior)) > 0) Then
        Continue;

      If (Trim(strLin01) <> Trim(strLin01Ant))  Or
         (Trim(strLin03) <> Trim(strLin03Ant)) Then
      Begin
        fltValAcu := 0;
        strLin01Ant := strLin01;
        strLin03Ant := strLin03;
      End;

      If blnGraReg Then
      Begin

        If (LeftStr(strLin03, 1) = Chr(171)) Or (LeftStr(strLin03, 3) = '1/2') Then
        Begin
          fltQtdPro := 0.5;
        End
        Else
        Begin
          strLin03  := Trim(strLin03);
          intPosSpc := Pos(' ', strLin03);
          fltQtdPro := fStrToFloat(Trim(LeftStr(strLin03, intPosSpc-1)));
        End;

        strLin01 := Trim(strLin01);
        strLin01 := AnsiReplaceStr(strLin01, '.', '');

        strLin02 := Trim(strLin02);
        strLin04 := Trim(strLin04);
        strLin05 := Trim(strLin05);
        strLin06 := Trim(strLin06);

        Application.ProcessMessages;

        If (fArqIniTinta(0, 'USA_FORMUL', 'LAZ', 'S') = 'S') Then
        Begin

  //        If (Not fFormulaExiste(strLin01, strLin02, fltQtdPro, fStrToFloat(strLin04))) Then
          If (Pos('QUARTO', AnsiUpperCase(strLin03)) > 0) Or
             (Pos('CUARTO', AnsiUpperCase(strLin03)) > 0) Or
             (Pos('ML', AnsiUpperCase(strLin03)) > 0)     Then
          Begin

            fltQtdGra := fRetValFor(strLin06);

            fltQtdGra := fltQtdGra - fltValAcu;

            fltValAcu := fltValAcu + fltQtdGra;

            strLin06  := FloatToStr(fltQtdGra);

            If (Not fGravaLazMixFor(strLin01,
                                    strLin02,
                                    fltQtdPro,
                                    fStrToFloat(strLin04),
                                    strLin05,
                                    fRetValFor(strLin06))) Then
            Begin
              Result := False;
              Exit;
            End;

          End;

        End;

      End;

    End;

  End;

  {*****************************************}
  {* ZAPEIA ARQUIVO DE PRODUTOS            *}
  {**************************************MV*}
  pZapTable('LAZ_CADMIX');

  intQtdLin := 12;
  For intContador1 := 0 To stlArqFor.Count -1 Do
  Begin

    AssignFile(arqLazTxt, stlArqPro[intContador1]);
    Reset(arqLazTxt);

    While (Not Eof(arqLazTxt)) Do
    Begin

      Application.ProcessMessages;

      blnGraReg := False;

      For intContador2 := 1 To intQtdLin Do
      Begin

        Case intContador2 Of

          01: Begin
                ReadLn(arqLazTxt, strLin01);
                If (Not fEmptyStr(strLin01)) Then
                  blnGraReg := True;
              End;
          02: ReadLn(arqLazTxt, strLin02);
          03: ReadLn(arqLazTxt, strLin03);
          04: ReadLn(arqLazTxt, strLin04);
          05: ReadLn(arqLazTxt, strLin05);
          06: ReadLn(arqLazTxt, strLin06);
          07: ReadLn(arqLazTxt, strLin07);
          08: ReadLn(arqLazTxt, strLin08);
          09: ReadLn(arqLazTxt, strLin09);
          10: ReadLn(arqLazTxt, strLin10);
          11: ReadLn(arqLazTxt, strLin11);
          12: ReadLn(arqLazTxt, strLin12);

        End;

      End;

      If (Not blnGraReg) Then
        Break;

//      If (fProdutoExiste(Trim(strLin01))) Then
//        Continue;

      Application.ProcessMessages;

      If (Not fGravaLazCadMix(Trim(strLin01),
                              Trim(strLin02),
                              Trim(strLin03),
                              Trim(strLin04),
                              Trim(strLin07),
                              Trim(strLin06),
                              fRetValFor(Trim(strLin08)),
                              fRetValFor(Trim(strLin11)),
                              fRetValFor(Trim(strLin09)),
                              strLin10,
                              strLin10)) Then
      Begin
        Break;
      End;

    End;

  End;

  FreeAndNil(stlArqMixFor);

end;

end.
