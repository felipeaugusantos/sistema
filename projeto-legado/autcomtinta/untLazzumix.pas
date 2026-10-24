unit untLazzumix;

interface

uses
  Forms, Uni, Classes, SysUtils, Dialogs,
  StrUtils, untFuncoesSimples;

  function fDigEmbalagem(Var strTipEmb: String; Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;

  function fLazFormulaCadastrada(qryMixFor: TUniQuery; strCodigo, strDilCon: String;
    fltQtdPro: Double): Boolean;

  function fDigPrecoFormulas(qryCadMix, qryMixFor: TUniQuery; Var strTipPre: String;
    Var intLazQua: Integer): Boolean;

  function fRetornaUniTraProLazzumix(qryCadMix: TUniQuery; fltPreEmb, fltQuanti: Double;
    strTipPre, strIteTin: String): Double;

  function fRetornaPrecoLazzumix(Sender: TForm; qryTinta, qryTintaAux: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraEmbLazzumix(strTipEmb, strTipPre: String): Double;

  function fRetornaDescricaoLazzumix(qryCadMix: TUniQuery): String;

  function fGTinForLazzumix(strIdePro, strIteTin, strTipPre: String; intLazQua: Integer;
    fltQtdEmb: Double; fltQtdIte: Double; strDescri: String; qryMixFor: TUniQuery;
    Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
    Var stlItensTraMl: TStringList): Boolean;

  function fConsultaLazzumix(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaLazzumixGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaLazzumixVenda(Sender: TForm; strCodEmp: String;
    Var qryCadMix: TUniQuery): String; stdcall;

  procedure pRetornaDadosLazzumix(strIteTin: String; dicRetorno: TDicionario);


Const
  arrTabFor: Array [0..4, 1..3] Of Double = ((0.50, 0.50, 0.00),
                                             (1.00,  800,  660),
                                             (2.00, 1600, 1320),
                                             (3.00, 2400, 1980),
                                             (4.00, 3200, 2640));

implementation

uses untFatDigEmbalagem, untFuncEspecificas, untTintaMaquina, untIConfTinta, Data.DB, untFatLazDigPreFor,untConsultaCadMix,
untConsultaCadMixGeral,untConsultaCadMixVenda;

function fRetornaDescricaoLazzumix(qryCadMix: TUniQuery): String;
begin
  Result := qryCadMix.FieldByName('MIX_DESCRI').AsString + ' ' +
            qryCadMix.FieldByName('MIX_REFERE').AsString + ' ' +
            qryCadMix.FieldByName('MIX_CODIGO').AsString;
end;

function fGTinForLazzumix(strIdePro, strIteTin, strTipPre: String; intLazQua: Integer;
  fltQtdEmb: Double; fltQtdIte: Double; strDescri: String; qryMixFor: TUniQuery;
  Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
  Var stlItensTraMl: TStringList): Boolean;
  Var
    intContador: Integer;
    intPos: Integer;
    intPosGra: Integer;

    fltLazQua: Double;
    fltQtdGra: Double;

    strSQL: String;

    strPigmentos: String;
    dicPigmentos: TDicionario;
    qryConsulta01: TUniQuery;
begin

  intPosGra := 1;
  qryConsulta01 := fCriaQuery(Nil);

  strPigmentos := '';
  dicPigmentos := TDicionario.Create;

  For intContador := 1 To 3 Do
  Begin

    fltLazQua := arrTabFor[intLazQua, intContador];

    If (Not fLazFormulaCadastrada(qryMixFor, strIteTin, strTipPre, fltLazQua)) Then
    Begin
      Continue;
    End;

    While (Not qryMixFor.Eof)                                                                           And
          (qryMixFor.FieldByName('MIX_CODIGO').AsString = strIteTin)                                    And
          (LeftStr(qryMixFor.FieldByName('MIX_DILCON').AsString, 1) = strTipPre)                        And
          (fFormataFloat(qryMixFor.FieldByName('MIX_QTDPRO').AsFloat, 2) = fFormataFloat(fltLazQua, 2)) Do
    Begin

      fltQtdGra := qryMixFor.FieldByName('MIX_GRABAS').AsFloat;
      If (strTipPre = 'D') And (Pos('POLIURETANO', strDesCri) > 0) Then
      Begin

        If (intLazQua = 0) And (fFormataFloat(fltQtdIte, 2) <> fFormataFloat(0.33, 2)) Then
        Begin
          fltQtdGra := fltQtdGra * (fltQtdIte / 0.45);
        End;

        If (intLazQua = 1) And (fFormataFloat(fltQtdIte, 2) <> fFormataFloat(0.66, 2)) Then
        Begin
          fltQtdGra := fltQtdGra * (fltQtdIte / 0.66);
        End;

        If (intLazQua = 2) And (fFormataFloat(fltQtdIte, 2) <> fFormataFloat(1.32, 2)) Then
        Begin
          fltQtdGra := fltQtdGra * (fltQtdIte / 1.32);
        End;

        If (intLazQua = 3) And (fFormataFloat(fltQtdIte, 2) <> fFormataFloat(1.98, 2)) Then
        Begin
          fltQtdGra := fltQtdGra * (fltQtdIte / 1.98);
        End;

        If (intLazQua = 4) And (fFormataFloat(fltQtdIte, 2) <> fFormataFloat(2.64, 2)) Then
        Begin
          fltQtdGra := fltQtdGra * (fltQtdIte / 2.64);
        End;

      End
      Else
      Begin

        If (intLazQua = 0) And (fFormataFloat(fltQtdIte, 2) <> fFormataFloat(0.45, 2)) Then
        Begin
          fltQtdGra := fltQtdGra * (fltQtdIte / 0.45);
        End;

        If (intLazQua = 1) And (fFormataFloat(fltQtdIte, 2) <> fFormataFloat(0.90, 2)) Then
        Begin
          fltQtdGra := fltQtdGra * (fltQtdIte / 0.90);
        End;

        If (intLazQua = 2) And (fFormataFloat(fltQtdIte, 2) <> fFormataFloat(1.80, 2)) Then
        Begin
          fltQtdGra := fltQtdGra * (fltQtdIte / 1.80);
        End;

        If (intLazQua = 3) And (fFormataFloat(fltQtdIte, 2) <> fFormataFloat(2.70, 2)) Then
        Begin
          fltQtdGra := fltQtdGra * (fltQtdIte / 2.70);
        End;

        If (intLazQua = 4) And (fFormataFloat(fltQtdIte, 2) <> fFormataFloat(3.60, 2)) Then
        Begin
          fltQtdGra := fltQtdGra * (fltQtdIte / 3.60);
        End;

      End;

      arrFormul[intPosGra].strFormul := qryMixFor.FieldByName('MIX_CODBAS').AsString;
      arrFormul[intPosGra].fltQtdBas := fltQtdGra;

      dicPigmentos[arrFormul[intPosGra].strFormul] := arrFormul[intPosGra].fltQtdBas;

      {*******************************************}
      {* GUARDA PIGMENTOS PARA POSTERIOR BUSCA   *}
      {* DOS ITENS                               *}
      {****************************************MV*}
      strPigmentos := strPigmentos + QuotedStr(arrFormul[intPosGra].strFormul) + ', ';
      qryMixFor.Next;

      Inc(intPosGra);
      If (intPosGra > 15) Then
      Begin
        Result := True;
        Exit;
      End;

    End;

    strPigmentos := Trim(strPigmentos);
    If (RightStr(strPigmentos, 1) = ',') Then
      strPigmentos := Copy(strPigmentos, 1, Length(strPigmentos)-1);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  BAS_CODBAS, ';
    strSQL := strSQL + '  BAS_CODITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  LAZ_CADBAS ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  BAS_CODBAS IN (' + strPigmentos + ') ';

    With qryConsulta01 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      intPos := 0;
      SetLength(arrBaixaPigmentos, RecordCount);

      While (Not Eof) Do
      Begin

        {*******************************************}
        {* ITENS QUE TEM QUE FAZER TRANSFERENCIA   *}
        {* DE SALDO EM ML                          *}
        {****************************************MV*}
        stlItensTraMl.Add(FieldByName('BAS_CODITE').AsString);

        arrBaixaPigmentos[intPos].strCodIte   := FieldByName('BAS_CODITE').AsString;
        arrBaixaPigmentos[intPos].fltQtdBaixa := dicPigmentos[FieldByName('BAS_CODBAS').AsString];
        Inc(intPos);
        Next;
      End;

      Close;
    End;

    Break;

  End;
  FreeAndNil(qryConsulta01);

  Result := True;

end;

function fConsultaLazzumix(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndMix: TStringList;
    stlDesIndMix: TStringList;
    qryConsulta01: TUniQuery;
begin

  qryConsulta01 := fCriaQuery(Nil);
  Application.CreateForm(TfrmConsultaCadMix, frmConsultaCadMix);

  stlCamIndMix := TStringList.Create;
  stlDesIndMix := TStringList.Create;

  stlCamIndMix.Add('MIX_DESCRI');
  stlCamIndMix.Add('MIX_CODIGO');
  stlCamIndMix.Add('MIX_UNIVER');
  stlCamIndMix.Add('MIX_REFERE');

  stlDesIndMix.Add('Descricao');
  stlDesIndMix.Add('Codigo');
  stlDesIndMix.Add('Cód. Universal');
  stlDesIndMix.Add('Referencia');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  MIX_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  MIX_CODIGO AS "Codigo", ';
  strSQL := strSQL + '  MIX_REFERE AS "Referencia", ';
  strSQL := strSQL + '  MIX_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  MIX_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  MIX_UNIVER AS "Cód. Universal", ';
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

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadMix, qryConsulta01, 'LAZ_CADMIX',
      strSQL, stlCamIndMix, stlDesIndMix, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndMix);
  FreeAndNil(stlDesIndMix);

  FreeAndNil(frmConsultaCadMix);
  FreeAndNil(qryConsulta01);

end;

function fConsultaLazzumixGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndMix: TStringList;
    stlDesIndMix: TStringList;
    qryConsulta01: TUniQuery;
begin

  qryConsulta01 := fCriaQuery(Nil);
  Application.CreateForm(TfrmConsultaCadMixGeral, frmConsultaCadMixGeral);

  stlCamIndMix := TStringList.Create;
  stlDesIndMix := TStringList.Create;

  stlCamIndMix.Add('MIX_DESCRI');
  stlCamIndMix.Add('MIX_CODIGO');
  stlCamIndMix.Add('MIX_UNIVER');
  stlCamIndMix.Add('MIX_REFERE');

  stlDesIndMix.Add('Descricao');
  stlDesIndMix.Add('Codigo');
  stlDesIndMix.Add('Cód. Universal');
  stlDesIndMix.Add('Referencia');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  MIX_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  MIX_CODIGO AS "Codigo", ';
  strSQL := strSQL + '  MIX_REFERE AS "Referencia", ';
  strSQL := strSQL + '  MIX_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  MIX_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  MIX_UNIVER AS "Cód. Universal", ';
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

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadMixGeral, qryConsulta01, 'LAZ_CADMIX',
      strSQL, stlCamIndMix, stlDesIndMix, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndMix);
  FreeAndNil(stlDesIndMix);

  FreeAndNil(frmConsultaCadMixGeral);
  FreeAndNil(qryConsulta01);
end;

function fConsultaLazzumixVenda(Sender: TForm; strCodEmp: String;
  Var qryCadMix: TUniQuery): String;
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
  stlCamIndMix.Add('MIX_UNIVER');
  stlCamIndMix.Add('MIX_REFERE');

  stlDesIndMix.Add('Descricao');
  stlDesIndMix.Add('Codigo');
  stlDesIndMix.Add('Cód. Universal');
  stlDesIndMix.Add('Referencia');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  MIX_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  MIX_CODIGO AS "Codigo", ';
  strSQL := strSQL + '  MIX_REFERE AS "Referencia", ';
  strSQL := strSQL + '  MIX_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  MIX_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  MIX_UNIVER AS "Cód. Universal", ';
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

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadMixVenda, qryCadMix, 'LAZ_CADMIX',
      strSQL, stlCamIndMix, stlDesIndMix, '', False, True, 5, True) Then
  Begin
    If (Not qryCadMix.IsEmpty) Then
      Result := qryCadMix.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndMix);
  FreeAndNil(stlDesIndMix);

  FreeAndNil(frmConsultaCadMixVenda);
end;

{*******************************************}
{* VERIFICA SE UMA FORMULA ESTA CADASTRADA *}
{* E RETORNA UMA QUERY POSICIONADA NESSA   *}
{* FORMULA                                 *}
{****************************************MV*}
function fLazFormulaCadastrada(qryMixFor: TUniQuery; strCodigo, strDilCon: String;
  fltQtdPro: Double): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_MIXFOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MIX_CODIGO = :CODIGO AND ';
  strSQL := strSQL + '  LEFT(MIX_DILCON, 1) = :DILCON AND ';
  strSQL := strSQL + '  MIX_QTDPRO = :QTDPRO ';

  With qryMixFor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODIGO').AsString := strCodigo;
    ParamByName('DILCON').AsString := strDilCon;
    ParamByName('QTDPRO').AsFloat  := fFormataFloat(fltQtdPro, 4);
    Open;
    Result := (RecordCount > 0);
  End;

end;

function fDigPrecoFormulas(qryCadMix, qryMixFor: TUniQuery; Var strTipPre: String;
  Var intLazQua: Integer): Boolean;
  Var
    blnEncFor: Boolean;
    intContador: Integer;
    conf: IConfTinta;
begin

  blnEncFor := False;
  conf      := fGetConfTinta('LAZ');
  Try
    Application.CreateForm(TfrmFatLazDigPreFor, frmFatLazDigPreFor);
    frmFatLazDigPreFor.edtDilCon.Text := strTipPre;
    frmFatLazDigPreFor.intLazQua      := intLazQua;
    frmFatLazDigPreFor.showModal;
  Finally
    Result := frmFatLazDigPreFor.blnConfirma;
    {*****************************************}
    {* CASO TENHA CANCELADO, SAI, SENAO      *}
    {* ATUALIZA AS VARIAVEIS                 *}
    {**************************************MV*}
    If (Result) Then
    Begin
      intLazQua := frmFatLazDigPreFor.intLazQua;
      strTipPre := frmFatLazDigPreFor.edtDilCon.Text;
    End;
    FreeAndNil(frmFatLazDigPreFor);
  End;

//  If (fArqIniTinta(0, 'USA_FORMUL', 'LAZ', 'S') = 'S') Then
  If (conf.fGet('USAFOR') = 'S') Then
  Begin

    For intContador := 1 To 3 Do
    Begin

      If fLazFormulaCadastrada(qryMixFor,
                               qryCadMix.FieldByName('MIX_CODIGO').AsString,
                               strTipPre,
                               arrTabFor[intLazQua, intContador]) Then      {DETINHO -> IRA VOLTAR (ESQUINA)}
      Begin
        blnEncFor := True;
        Break;
      End;

    End;

  End
  Else
  Begin
    blnEncFor := True;
  End;

  If (Not blnEncFor) Then
  Begin
    fMensagem('', 'A quantidade escolhida não foi encontrada para este tipo de preço: ' +
                   IIF(strTipPre = 'D', 'Diluido', 'Concentrado'), ['&O K']);
    Result := False;
    Exit;
  End;

  {*****************************************}
  {* AQUI AS VARIAVEIS TIPPRE (D/C) E      *}
  {* LAZQUA JA ESTAO ATRIBUIDAS E SERAO    *}
  {* RETORNADAS PARA O AUTCOM              *}
  {**************************************MV*}
  Result := True;
end;

function fRetornaUniTraProLazzumix(qryCadMix: TUniQuery; fltPreEmb, fltQuanti: Double;
  strTipPre, strIteTin: String): Double;
  Var
    strCampoPreco: String;
    strPreLaz: String;
    fltFatLaz: Double;
    strSQL: String;
    conf: IConfTinta;
begin

conf := fGetConfTinta('LAZ');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_CADMIX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MIX_CODIGO = :ITETIN ';

  With qryCadMix Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

  End;

  strCampoPreco := 'MIX_PRECO';
  If (strTipPre = 'D') Then
  Begin
    strPreLaz := conf.fGet('TRADLZ');;
    fltFatLaz := conf.fGetDouble('FATDLZ');
  End
  Else
  Begin
    strPreLaz := conf.fGet('TRACLZ');
    fltFatLaz := conf.fGetDouble('FATCLZ');
  End;
  strCampoPreco := strCampoPreco + strPreLaz;

  Result := fFormataFloat(qryCadMix.FieldByName(strCampoPreco).AsFloat, 2);

//  fltValEmb := fFormataFloat(fltPreEmb / fltQuanti, 2);
//  Result := fFormataFloat(Result + fltValEmb, 2);

  Result := fFormataFloat(Result / 0.900, 2);

  Result := fFormataFloat(Result * fltFatLaz, 2);

end;

function fRetornaPrecoLazzumix(Sender: TForm; qryTinta, qryTintaAux: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
  Var
    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    blnUsaPreCus: Boolean;
    strTipPre: String;
    intLazQua: Integer;
    strTipEmb: String;
    intQtdEmb: Integer;

    strIteTin: String;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;
    fltFatTin: Double;
    fltPrcTin: Double;
    fltPrvTin: Double;

    strIteEmb: String;
    
    strMontad: String;
    strA_n_o_: String;

    stlDesEmb: TStringList;
    stlProEmb: TStringList;
    conf: IConfTinta;
begin

  Result := False;

  stlDesEmb := TStringList.Create;
  stlProEmb := TStringList.Create;

  strIteTin := '';
  fltPreCus := 0.0;
  fltUnitar := 0.0;
  fltFatTin := 0.0;
  fltPrcTin := 0.0;
  fltPrvTin := 0.0;

  strTipPre := '';
  intLazQua := 0;
  strTipEmb := '';
  intQtdEmb := 0;
  fltPreEmb := 0.0;
  fltEmbala := 0.0;

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTipPre    := dicRetorno['tippre'];
  intLazQua    := dicRetorno['lazqua'];
  strTipEmb    := dicRetorno['tipemb'];
  intQtdEmb    := dicRetorno['qtdemb'];

  stlDesEmb.Add('SINTETICO');
  stlDesEmb.Add('LACA');
  stlDesEmb.Add('POLIESTER');
  stlDesEmb.Add('P. U.');

  If (fConsultaLazzumixVenda(Sender, strCodEmp, qryTinta) = '-1') Then
  Begin
    Exit;
  End;

  strIteTin := qryTinta.FieldByName('MIX_CODIGO').AsString;
  strMontad := qryTinta.FieldByName('MIX_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('MIX_A_N_O_').AsString;

  If (Not fDigPrecoFormulas(qryTinta, qryTintaAux, strTipPre, intLazQua)) Then
  Begin
    Exit;
  End;

  If (Not fDigEmbalagem(strTipEmb, intQtdEmb, fltPreEmb, fltEmbala)) Then
  Begin
    Exit;
  End;

  conf := fGetConfTinta('LAZ');

  If (strTipEmb = 'LT') Then
  Begin
    stlProEmb.Add(conf.fGet('LAZIEM'));
    stlProEmb.Add(conf.fGet('LAZLLA'));
    stlProEmb.Add(conf.fGet('LAZLPO'));
    stlProEmb.Add(conf.fGet('LAZLPU'));

  End
  Else If (strTipEmb = 'GL') Then
  Begin
    stlProEmb.Add(conf.fGet('LAZIGL'));
    stlProEmb.Add(conf.fGet('LAZGLA'));
    stlProEmb.Add(conf.fGet('LAZGPO'));
    stlProEmb.Add(conf.fGet('LAZGPU'));
  End;

  If (Not fDigTipoEmbalagem(stlDesEmb, stlProEmb, strIteEmb)) Then
  Begin
    Exit;
  End;

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  If (strTipPre = 'D') Then
  Begin

    fltFatTin := conf.fGetDouble('FATDLZ');

    fltPrcTin := qryTinta.FieldByName('MIX_PRECO4').AsFloat / 0.900;
    fltPreCus := qryTinta.FieldByName('MIX_PRECO4').AsFloat / 0.900;
    
    If (blnUsaPreCus)      And
       (strOpcDoc <> 'BR') Then
    Begin
      fltPrvTin := qryTinta.FieldByName('MIX_PRECO4').AsFloat / 0.900;
      fltUnitar := qryTinta.FieldByName('MIX_PRECO4').AsFloat / 0.900;
    End
    Else
    Begin
      fltPrvTin := qryTinta.FieldByName('MIX_PRECO3').AsFloat / 0.900;
      fltUnitar := qryTinta.FieldByName('MIX_PRECO3').AsFloat / 0.900;
    End;

  End

  Else If (strTipPre = 'C') Then
  Begin           
    fltFatTin := conf.fGetDouble('FATCLZ');

    fltPrcTin := qryTinta.FieldByName('MIX_PRECO2').AsFloat / 0.900;
    fltPreCus := qryTinta.FieldByName('MIX_PRECO2').AsFloat / 0.900;
    
    If (blnUsaPreCus)      And
       (strOpcDoc <> 'BR') Then
    Begin
      fltPrvTin := qryTinta.FieldByName('MIX_PRECO2').AsFloat / 0.900;
      fltUnitar := qryTinta.FieldByName('MIX_PRECO2').AsFloat / 0.900;
    End
    Else
    Begin
      fltPrvTin := qryTinta.FieldByName('MIX_PRECO1').AsFloat / 0.900;
      fltUnitar := qryTinta.FieldByName('MIX_PRECO1').AsFloat / 0.900;
    End;
  End;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['fattin'] := fltFatTin;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROLAZ');
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['tippre'] := strTipPre;
  dicRetorno['lazqua'] := intLazQua;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['chafor'] := fRetornaDescricaoLazzumix(qryTinta) + strTipEmb;

  Result := True;

End;

function fRetornaUniTraEmbLazzumix(strTipEmb, strTipPre: String): Double;
  Var
    fltPreEmb: Double;
    conf: IConfTinta;
begin

  conf := fGetConfTinta('LAZ');

  If (strTipEmb = 'LT') Then
    fltPreEmb := conf.fGetDouble('EMBLAZ')
  Else
    fltPreEmb := conf.fGetDouble('GALLAZ');

  If (strTipPre = 'C') Then
    Result := fltPreEmb * conf.fGetDouble('FATCLZ')
  Else
    Result := fltPreEmb * conf.fGetDouble('FATDLZ');
end;

{*******************************************}
{* DIGITAÇÃO DE EMBALAGEM (TIPO E QTD)     *}
{****************************************MV*}
function fDigEmbalagem(Var strTipEmb: String;
  Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;
begin

  Try
    Application.CreateForm(TfrmFatDigEmbalagem, frmFatDigEmbalagem);
    frmFatDigEmbalagem.strTipEmb      := strTipEmb;
    frmFatDigEmbalagem.edtQtdEmb.Text := IntToStr(intQtdEmb);
    frmFatDigEmbalagem.showModal;
  Finally
    Result := frmFatDigEmbalagem.blnConfirma;
    {*****************************************}
    {* CASO TENHA CANCELADO, SAI, SENAO      *}
    {* ATUALIZA AS VARIAVEIS                 *}
    {**************************************MV*}
    If (Result) Then
    Begin
      strTipEmb := frmFatDigEmbalagem.strTipEmb;
      intQtdEmb := StrToInt(frmFatDigEmbalagem.edtQtdEmb.Text);
    End;
    FreeAndNil(frmFatDigEmbalagem);
  End;

  If (Not Result) Then
    Exit;

  {*****************************************}
  {* LITRO                                 *}
  {**************************************MV*}
  If (strTipEmb = 'LT') Then
  Begin

    fltPreEmb := fGetConfTinta('LAZ').fGetDouble('EMBLAZ') * intQtdEmb;
    fltEmbala := fFormataFloat(0.9, 4);
  End
  {*****************************************}
  {* GALÃO                                 *}
  {**************************************MV*}
  Else
  Begin
    fltPreEmb := fGetConfTinta('LAZ').fGetDouble('GALLAZ') * intQtdEmb;
    fltEmbala := fFormataFloat(3.6, 4);
  End;

end;

procedure pRetornaDadosLazzumix(strIteTin: String; dicRetorno: TDicionario);
  Var
    strSQL: String;
    qryCadMix: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_CADMIX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MIX_CODIGO = :ITETIN ';

  qryCadMix := fCriaQuery(Nil);

  With qryCadMix Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := qryCadMix.FieldByName('MIX_CODIGO').AsString;
    dicRetorno['montad'] := qryCadMix.FieldByName('MIX_MONTAD').AsString;
    dicRetorno['martin'] := qryCadMix.FieldByName('MIX_REFERE').AsString;
    Close;
  End;

  FreeAndNil(qryCadMix);
end;

end.
