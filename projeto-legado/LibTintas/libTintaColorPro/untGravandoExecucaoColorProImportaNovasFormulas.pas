{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta PPX *}
{********************************************************************************AC*}
unit untGravandoExecucaoColorProImportaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Classes, StrUtils, System.Win.ComObj, Variants, Uni, UniClientDataSet,
  untIConfTinta, untFloatUtils, Data.DB, InterBaseUniProvider;

type
  TGravandoExecucaoColorProImportaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  Private
    blnCalcula2Por1,  blnCalcula4Por1,
    blnCalcula9Por2,  blnExisteNovaFormula: Boolean;
    qryNovasFormulas, qryBases : IDataSet;
    intPrxNfm, intTotRegistros: Integer;
    qryImpNfm, qryNfmLay: TUniQuery;
    blnNGravar: Boolean;
    sNGravar: String;
    fltTotalConcentrado, fltTotalDiluido, fltTotalDiluido2, fltTotalDiluido4, fltVolTinner2Por1, fltVolTinner4Por1,
    fltVolTinner9Por2, fltEmb2por1, fltEmb4por1, fltEmb9Por2, fltTamEmb2Por1, fltTamEmb4Por1, fltTamEmb9Por2, fltSomaR2,
    fltSomaR4, fltPerThinner2, fltPEThinner, fltFatBas, fltPerDil, fltPerCen, fltVolumeMassa, fltVolumeConcentrado,
    fltVolumeDiluido, fltDivisorEmb2Por1, fltDivisorEmb4Por1, fltMultiplicadorEmb2Por1, fltMultiplicadorEmb4Por1,
    fltDivisorEmb9Por2, fltMultiplicadorEmb9Por2, fltPerThinner4, fltVolumeDil4Por1, fltVolumeDil9Por2: Double;
    strLinPro, strLinDil, strBasDil, strCodNfm: String;
    arrLinPig: Array[1..20] Of String;
    arrCodPig: Array[1..20] Of String;
    arrBasDil: Array[1..20] Of String;
    arrQtdPigCon: Array[1..20] Of Double;
    arrQtdPigDil: Array[1..20] Of Double;
    arrQtdPigDil4Por1: Array[1..20] Of Double;
    arrQtdPigDil9Por2: Array[1..20] Of Double;
    arrPorcen: Array[1..20] Of Double;
    function fSqlIDNovasFormulas(): String;
    function fSQLImportacaoNovasFormulas(): String;
    function fVerificaNovFormulas(strCodNfm: String): Boolean;
    function fVerificaNfmCadastrada(sLinha, sNomLin, sDescri, sMontad, sAltern, sCamada, sCatali, sAtivo: String): Boolean;
    function fSqlSelectSQLBasesQuantidades(): String;
    function fSQLSelectBasesQuantidadesNao(intContador: Integer): String;
    function fSQLSelectBasesQuantidadesSim(intContador: Integer): String;
    Procedure ProcessarParametrosBasesQuantidades(qryNfm: IDataSet);
    Procedure ProcessarParametrosBasesQuantidadesSim(qryNfm: IDataSet; intContador: Integer);
    Procedure ProcessarParametrosBasesQuantidadesNao(qryNfm: IDataSet; intContador: Integer);
    function fConnectionFDB : TUniConnection;
    procedure GravarNovaFormula(qryDestino: IDataSet; qryOrigem: TUniQuery);
    function fCarregaCadastroBasesWandaPro(const gravando: IGravando): IDataSet;
    procedure pRetornaInfoLinhas(strLinha: String; var strLinDil, strBasDil: String; var fltFatBas, fltPerDil: Double; Conf: IConfTinta);
    procedure pRetornaInfoLinha(strLinha: String; Var strLinDil, strBasDil: String; Var fltFatBas, fltPerDil: Double);
    Procedure pCalculaTotalPorcentagemVolume;
    Procedure pCalculaTotalPorcentagemVolumeLinha8;
    Procedure pCalculaPrecos(intContador: Integer);
    Procedure pCalculaPrecosDemaisLinhas(intContador: Integer);
    Procedure pCalculaPrecosDiluido(intContador: Integer);
  //Calculos Concentrado e Diluido;
    function fRetornaPreco11(fltPerCen, fltPesEsp, fltEmbala, fltPrePig,
      fltTotalPerVolume: Double; Var fltVolumeMassa: Double): Double;
    function fRetornaPreco(fltPerCen, fltPesEsp, fltEmbala, fltPrePig,
      fltTotalPerVolume: Double; Var fltVolumeMassa: Double): Double;
    function fRetornaPrecoPU(fltPerCen, fltPesEsp, fltEmbala, fltPrePig,
      fltTotalPerVolume, fltQtdProduzir: Double; var fltVolumeMassa: Double): Double;
    function fGetPath: String;
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
    function fRetProxCodSeq : Integer;

  end;

Const
    TAM_EMBALAGEM_2POR1_BT100 = 618;
    TAM_EMBALAGEM_2POR1 = 640;
    TAM_EMBALAGEM_4POR1 = 750;
    TAM_EMBALAGEM_9POR2 = 750;
    ERROR_PRIMARY_KEY_INSERT = 1062;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoColorProImportaNovasFormulas }

constructor TGravandoExecucaoColorProImportaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoColorProImportaNovasFormulas.Executar(const gravando: IGravando);
Var
  intContador: Integer;
begin
  Try
    Try
      If Not FileExists(fGetPath) Then
      Begin
        Gravando.Texto := Format('O arquivo para Database [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
        Exit;
      End;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('WANPRO_CADNFM');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      intTotRegistros := 0;

      qryBases := fCarregaCadastroBasesWandaPro(Gravando);


      qryNovasFormulas := TAutcomTintaFactory.Get.fGetDataSet;
      qryNovasFormulas.SQL := ' SELECT * FROM WANPRO_CADNFM WHERE FALSE    ';
      qryNovasFormulas.Open;

      Gravando.Texto := 'Abrindo Importação de Novas Fórmulas: [ ' + fGetPath + ' ]';

      qryImpNfm := TUniQuery.Create(Nil);
      qryNfmLay := TUniQuery.Create(Nil);
      qryImpNfm.Connection := fConnectionFDB;
      qryNfmLay.Connection := fConnectionFDB;


      qryImpNfm.Close;
      qryImpNfm.SQL.Clear;
      qryImpNfm.SQL.Add(fSqlIDNovasFormulas);
      qryImpNfm.Open;

      While Not qryImpNfm.Eof Do
      Begin
        Inc(intTotRegistros);
        qryImpNfm.Next;
      End;

      qryImpNfm.First;

      Gravando.Texto := 'Processando Importação: [ ' + fGetPath + ' ]';

      While Not qryImpNfm.Eof Do
      Begin
        blnNGravar := True;

        qryNfmLay.Close;
        qryNfmLay.SQL.Clear;
        qryNfmLay.SQL.Add(fSQLImportacaoNovasFormulas);
        qryNfmLay.ParamByName('CODIGO').AsString := qryImpNfm.FieldByName('ID').AsString;
        qryNfmLay.ParamByName('CAMADA').AsString := qryImpNfm.FieldByName('CAMADA').AsString;
        qryNfmLay.ParamByName('LINHA').AsString := qryImpNfm.FieldByName('LINHA').AsString;
        qryNfmLay.Open;

        If qryNfmLay.IsEmpty Then
        Begin
          qryImpNfm.Next;
          Gravando.RegistrarProgresso(0, qryImpNfm.RecNo, qryImpNfm.RecordCount);
          Continue;
        End;

        pCalculaTotalPorcentagemVolume;

        If Not blnNGravar Then
        Begin
          Gravando.Texto := sNGravar;
          qryImpNfm.Next;
          Gravando.RegistrarProgresso(0, qryImpNfm.RecNo, qryImpNfm.RecordCount);
          Continue;
        End;

        For intContador := Low(arrCodPig) To High(arrCodPig) Do
        Begin
          arrLinPig[intContador] := '';
          arrCodPig[intContador] := '';
          arrCodPig[intContador] := '';
          arrQtdPigCon[intContador] := 0.0;
          arrQtdPigDil[intContador] := 0.0;
          arrQtdPigDil4Por1[intContador] := 0.0;
          arrQtdPigDil9Por2[intContador] := 0.0;
          arrPorcen[intContador] := 0.0;
        End;

        intContador  := 1;

        qryNfmLay.First;

        {*******************************************}
        {* REALIZA CALCULO DO PREÇO DILUIDO        *}
        {****************************************RG*}
        fltVolTinner2Por1 := 0;
        fltVolTinner4Por1 := 0;
        fltVolTinner9Por2 := 0;
        fltEmb2por1       := 0;
        fltEmb4por1       := 0;
        fltTamEmb2Por1    := 0;
        fltTamEmb4Por1    := 0;
        fltTamEmb9Por2    := 0;

        fltVolumeMassa := 0.0;
        fltVolumeDiluido := 0;
        fltVolumeDil4Por1 := 0.0;
        fltVolumeDil9Por2 := 0.0;

        While (Not qryNfmLay.Eof) Do
        Begin
          If (Not qryBases.Locate('Linha;Base', VarArrayOf([qryNfmLay.FieldByName('CODLIN').AsString, qryNfmLay.FieldByName('CODBAS').AsString]), [])) Then
          Begin
            qryNfmLay.Next;
            Continue;
          End;

          pCalculaPrecos(intContador);
          pCalculaPrecosDemaisLinhas(intContador);

          Inc(intContador);
          qryNfmLay.Next;
        End;

        fltVolumeMassa := 0.0;
        fltVolumeDil4Por1 := 0.0;
        fltVolumeDil9Por2 := 0.0;

        pCalculaPrecosDiluido(intContador);

        If (Gravando.Status <> sgGravando) Then
          Break;

        intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetInteger('NFMPRO');


        Repeat
          strCodNfm := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp + TStrUtils.fStrZero(intPrxNfm, 5);

          Inc(intPrxNfm);
        Until (fVerificaNovFormulas(strCodNfm));



        blnExisteNovaFormula := fVerificaNfmCadastrada(qryNfmLay.FieldByName('CODLIN').AsString,
                                                      qryNfmLay.FieldByName('DESLIN').AsString,
                                                      qryNfmLay.FieldByName('DESCRI').AsString,
                                                      '',
                                                      qryNfmLay.FieldByName('ALTERN').AsString,
                                                      qryNfmLay.FieldByName('CAMAD').AsString,
                                                      '',
                                                      'S');


        GravarNovaFormula(qryNovasFormulas, qryNfmLay);
        TAutcomTintaFactory.Get.fGetConfTinta('WCP').pSet('NFMPRO', TStrUtils.fStrZero(intPrxNfm, 5));

        qryImpNfm.Next;
        Gravando.RegistrarProgresso(0, qryImpNfm.RecNo, qryImpNfm.RecordCount);
      End;
    Except
      on E: Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
  End;
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fCarregaCadastroBasesWandaPro(
  const gravando: IGravando): IDataSet;
begin
  Gravando.Texto := 'Carregando cadastro de Bases ...';

  Result := TAutcomTintaFactory.Get.fGetDataSet;

  Result.SQL := 'SELECT                           ' +
                '  BAS_LINHA_ AS Linha,           ' +
                '  BAS_CODBAS AS Base,            ' +
                '  BAS_DESBAS AS Descricao,       ' +
                '  " "        AS Status,          ' +
                '  0.0        AS Preco,           ' +
                '  BAS_PESESP AS PesoEsp,         ' +
                '  BAS_EMBALA * 1000 AS TamEmbala ' +
                'FROM                             ' +
                '  WANPRO_CADBAS                  ';
  Result.Open;

  If Result.IsEmpty Then
  Begin
    gravando.Texto := 'O Cadastro de Bases está vazio, favor gerar o cadastro de bases ...';
    gravando.Cancelar;
    Exit;
  End;

  Gravando.Texto := 'Cadastro de bases carregando com sucesso ...';
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fConnectionFDB: TUniConnection;
Var
  conf   : IConfTinta;
  Con    : TUniConnection;
begin
  conf  := TAutcomTintaFactory.Get.fGetConfTinta('WCP');

  Con := TUniConnection.Create(nil);;

  try
    Con.Database     := conf.fGet('WCPPAT');
    Con.Username     := conf.fGet('WCPUSU');
    Con.Password     := conf.fGet('WCPSEN');

    if (conf.fGet('WCPSER') <> 'LOCALHOST' ) then
    begin
      Con.Server       := conf.fGet('WCPSER');
      Con.Port         := conf.fGetInteger('WCPPOR');
    end;

    Con.ProviderName := 'Interbase';
    Con.Connect;

    Result := Con;

  except on e : Exception do
    begin
      Result := Nil;
    end;
  end;
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Importação de Novas Fórmulas';
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fGetPath: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGet('WCPPAT');
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGet('USAINV') <> 'N';
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fRetornaPreco(fltPerCen,
  fltPesEsp, fltEmbala, fltPrePig, fltTotalPerVolume: Double;
  var fltVolumeMassa: Double): Double;
Var
  fltPerVolume: Double;
  fltVolumeLitro: Double;
  fltPesoBase: Double;
begin
  fltPerCen      := fltPerCen;
  fltPerVolume   := fltPerCen / fltPesEsp;
  fltVolumeLitro := fltPerVolume * 900 / fltTotalPerVolume;
  fltVolumeMassa := TFloatUtils.fFormataFloat(fltVolumeLitro * fltPesEsp, 1);
  fltPesoBase    := TFloatUtils.fFormataFloat(fltEmbala * fltPesEsp, 3);
  Result         := TFloatUtils.fFormataFloat(fltVolumeMassa * fltPrePig / fltPesoBase, 3);
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fRetornaPreco11(
  fltPerCen, fltPesEsp, fltEmbala, fltPrePig, fltTotalPerVolume: Double;
  var fltVolumeMassa: Double): Double;
Var
  fltPerVolume: Double;
  fltVolumeLitro: Double;
  fltPesoBase: Double;
  fltPerBases: Double;
begin
  fltPerCen      := fltPerCen;
  fltPerBases    := fltPerCen * 100 / (100 - 23);
  fltPerVolume   := fltPerBases  / fltPesEsp;
  fltVolumeLitro := (450 * fltPerVolume)/ fltTotalPerVolume;
  fltVolumeMassa := TFloatUtils.fFormataFloat(fltVolumeLitro * fltPesEsp, 1);
  fltPesoBase    := TFloatUtils.fFormataFloat(fltEmbala * fltPesEsp, 3);
  Result         := TFloatUtils.fFormataFloat(fltVolumeMassa * fltPrePig / fltPesoBase, 3);
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fRetornaPrecoPU(
  fltPerCen, fltPesEsp, fltEmbala, fltPrePig, fltTotalPerVolume,
  fltQtdProduzir: Double; var fltVolumeMassa: Double): Double;
Var
  fltPerVolume: Double;
  fltVolumeLitro: Double;
  fltPesoBase: Double;
begin
  fltPerCen      := fltPerCen;
  fltPerVolume   := fltPerCen / fltPesEsp;
  fltVolumeLitro := fltPerVolume * fltQtdProduzir / fltTotalPerVolume;

  {*******************************************}
  {* QUANDO É O CALCULO DO TINNER, JÁ TEM A  *}
  {* QUANTIDADE EM MASSA                     *}
  {****************************************MV*}
  If (fltQtdProduzir = 0.0) Then
    fltVolumeMassa := TFloatUtils.fFormataFloat(fltPerCen,1)
  Else
    fltVolumeMassa := TFloatUtils.fFormataFloat(fltVolumeLitro * fltPesEsp, 1);

  fltPesoBase    := TFloatUtils.fFormataFloat(fltEmbala * fltPesEsp, 3);
  Result         := TFloatUtils.fFormataFloat(fltVolumeMassa * fltPrePig / fltPesoBase, 3);
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fRetProxCodSeq: Integer;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT (IFNULL(MAX(PPX_CODSEQ), 0) + 1) PROX '+
                '  FROM PPX_CADPPX;';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;

end;


function TGravandoExecucaoColorProImportaNovasFormulas.fSqlIDNovasFormulas: String;
begin
  Result := '';
  Result := Result + '  SELECT DISTINCT                   ';
  Result := Result + '    F.imitationid AS ID,            ';
  Result := Result + '    F.layernr AS CAMADA,            ';
  Result := Result + '    L.IDLINHAMS AS LINHA            ';
  Result := Result + '  FROM                              ';
  Result := Result + '    formulacolorant F               ';
  Result := Result + '  LEFT JOIN imitation I ON          ';
  Result := Result + '    F.imitationid = I.imitationid   ';
  Result := Result + '  LEFT JOIN tonner T ON             ';
  Result := Result + '    F.idtonner = T.idtonner AND     ';
  Result := Result + '    F.idlinha = T.idlinha           ';
  Result := Result + '  LEFT JOIN linhas L ON             ';
  Result := Result + '    L.idlinha = F.idlinha           ';
  Result := Result + '  LEFT JOIN colordescription CD ON  ';
  Result := Result + '    I.externalcolorid = CD.externalcolorid  ';
  Result := Result + '  LEFT JOIN color C ON              ';
  Result := Result + '    CD.externalcolorid = C.externalcolorid  ';
  Result := Result + '  WHERE 0=0 AND                    ';
  Result := Result + '    L.descricao <> ''Autocoat BT120'' AND     ';
  Result := Result + '    C.originaltypeofproductnr = ''-1''        ';
//  Result := Result + '    L.idlinhams = ''13''                      ';
  Result := Result + '  ORDER BY C.externalcolorid                ';
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fSQLImportacaoNovasFormulas: String;
begin
  Result := '';
  Result := Result + '  SELECT                            ';
  Result := Result + '    F.imitationid AS ID,            ';
  Result := Result + '    F.layernr AS CAMAD,             ';
  Result := Result + '    F.idlinha AS ID_L,              ';
  Result := Result + '    F.idtonner AS ID_T,             ';
  Result := Result + '    F.weightpercentage AS Percentual, ';
  Result := Result + '    I.ALTERNATIVENR AS ALTERN,      ';
  Result := Result + '    CD.descricao AS DESCRI,          ';
  Result := Result + '    T.codtonnerorig AS CODBAS,      ';
  Result := Result + '    L.percentthinner AS Perc,       ';
  Result := Result + '    L.descricao AS DESLIN,          ';
  Result := Result + '    L.IDLINHAMS AS CODLIN           ';
  Result := Result + '  FROM                              ';
  Result := Result + '    formulacolorant F               ';
  Result := Result + '  LEFT JOIN imitation I ON          ';
  Result := Result + '    F.imitationid = I.imitationid   ';
  Result := Result + '  LEFT JOIN tonner T ON             ';
  Result := Result + '    F.idtonner = T.idtonner AND     ';
  Result := Result + '    F.idlinha = T.idlinha           ';
  Result := Result + '  LEFT JOIN linhas L ON             ';
  Result := Result + '    L.idlinha = F.idlinha           ';
  Result := Result + '  LEFT JOIN colordescription CD ON  ';
  Result := Result + '    I.externalcolorid = CD.externalcolorid  ';
  Result := Result + '  LEFT JOIN color C ON              ';
  Result := Result + '    CD.externalcolorid = C.externalcolorid  ';
  Result := Result + '  WHERE 0=0 AND                     ';
  Result := Result + '    L.descricao <> ''Autocoat BT120'' AND     ';
  Result := Result + '    C.originaltypeofproductnr = ''-1'' AND    ';
  Result := Result + '    F.imitationid = :CODIGO  AND              ';
  Result := Result + '    F.layernr = :CAMADA AND                   ';
  Result := Result + '    L.IDLINHAMS = :LINHA                      ';
  Result := Result + '  ORDER BY C.externalcolorid                  ';
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fSQLSelectBasesQuantidadesNao(
  intContador: Integer): String;
begin
  Result := '';

  If arrCodPig[intContador].IsEmpty Then
    Exit;

  If (Not arrCodPig[intContador].IsEmpty) Then
    Result := Result + 'AND NFM_CODB' + TStrUtils.fStrZero(intContador, 2) + ' = :CODB' + TStrUtils.fStrZero(intContador, 2) + '    ';

  If arrQtdPigCon[intContador] <> 0 Then
    Result := Result + 'AND NFM_QTDC' + TStrUtils.fStrZero(intContador, 2) + ' = :QTDC' + TStrUtils.fStrZero(intContador, 2) + '    ';

  If arrLinPig[intContador] = '72' Then
  Begin
    If arrQtdPigDil9Por2[intContador] <> 0 Then
      Result := Result + 'AND NFM_QTDD' + TStrUtils.fStrZero(intContador, 2) + ' = :QTDD' + TStrUtils.fStrZero(intContador, 2) + '    ';
  End
  Else
  Begin
    If arrQtdPigDil[intContador] <> 0 Then
      Result := Result + 'AND NFM_QTDD' + TStrUtils.fStrZero(intContador, 2) + ' = :QTDD' + TStrUtils.fStrZero(intContador, 2) + '    ';
  End;

  If arrQtdPigDil4Por1[intContador] <> 0 Then
    Result := Result + 'AND NFM_QD41' + TStrUtils.fStrZero(intContador, 2) + ' = :QD41' + TStrUtils.fStrZero(intContador, 2) + '    ';
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fSQLSelectBasesQuantidadesSim(
  intContador: Integer): String;
begin
  Result := '';

  If arrCodPig[intContador].IsEmpty Then
    Exit;

  If (Not arrCodPig[intContador].IsEmpty) Then
    Result := Result + 'AND NFM_CODDIL  = :CODDIL         ';

  If arrLinPig[intContador] = '72' Then
  Begin
    If arrQtdPigDil9Por2[intContador] <> 0 Then
      Result := Result + 'AND NFM_QTDDIL = :QTDDIL        ';
  End
  Else
  Begin
    If arrQtdPigDil[intContador] <> 0 Then
      Result := Result + 'AND NFM_QTDDIL = :QTDDIL        ';
  End;

  If arrQtdPigDil4Por1[intContador] <> 0 Then
    Result := Result + 'AND NFM_QTDDI4 = :QTDDI4          ';
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fSqlSelectSQLBasesQuantidades(): String;
Var
  intContador: Integer;
begin
  Result := '';

  For intContador := 2 To 20 Do
  Begin
    If arrBasDil[intContador] = 'N' Then
    Begin
      Result := Result + fSQLSelectBasesQuantidadesNao(intContador);
    End
    Else If arrBasDil[intContador] = 'S' Then
    Begin
      Result := Result + fSQLSelectBasesQuantidadesSim(intContador);
      Break;
    End;
  End;
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fVerificaNfmCadastrada(sLinha, sNomLin, sDescri, sMontad, sAltern, sCamada, sCatali, sAtivo: String): Boolean;
Var
  qryNfm: IDataSet;
begin
  Try
    qryNfm := TAutcomTintaFactory.Get.fGetDataSet;
    qryNfm.Close;
    qryNfm.SQL := ' SELECT                    ';
    qryNfm.SQL := qryNfm.SQL + '    *         ';
    qryNfm.SQL := qryNfm.SQL + '  FROM        ';
    qryNfm.SQL := qryNfm.SQL + '    WANPRO_CADNFM      ';
    qryNfm.SQL := qryNfm.SQL + '  WHERE       ';
    qryNfm.SQL := qryNfm.SQL + '    TRUE AND        ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_LINHA_ = :LINHA_ AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_NOMLIN = :NOMLIN AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_DESCRI = :DESCRI AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_ALTERN = :ALTERN AND      ';
    qryNfm.SQL := qryNfm.SQL + '    WAN_CAMADA = :CAMADA AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_ATIVO_ = :ATIVO_ AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_CODB01 = :CODB01 AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_QTDC01 = :QTDC01 AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_QTDD01 = :QTDD01 AND      ';
    qryNfm.SQL := qryNfm.SQL + '    NFM_QD4101 = :QD4101          ';


    qryNfm.SQL := qryNfm.SQL + fSqlSelectSQLBasesQuantidades();

    qryNfm.ParamByName('LINHA_').AsString := sLinha;
    qryNfm.ParamByName('NOMLIN').AsString := sNomLin;
    qryNfm.ParamByName('DESCRI').AsString := sDescri;
    qryNfm.ParamByName('ALTERN').AsString := sAltern;
    qryNfm.ParamByName('CAMADA').AsString := sCamada;
    qryNfm.ParamByName('ATIVO_').AsString := sAtivo;
    qryNfm.ParamByName('CODB01').AsString := arrCodPig[1];
    qryNfm.ParamByName('QTDC01').AsFloat  := arrQtdPigCon[1];
    qryNfm.ParamByName('QTDD01').AsFloat  := TAutcomTintaFactory.Get.IIF(arrLinPig[1] = '72', arrQtdPigDil9Por2[1], arrQtdPigDil[1]);
    qryNfm.ParamByName('QD4101').AsFloat  := arrQtdPigDil4Por1[1];

    ProcessarParametrosBasesQuantidades(qryNfm);

    qryNfm.Open;

    Result := (Not qryNfm.IsEmpty);
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
end;

function TGravandoExecucaoColorProImportaNovasFormulas.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                              ';
  qryGen.SQL := qryGen.SQL + '    * FROM WANPRO_CADNFM     ';
  qryGen.SQL := qryGen.SQL + '  WHERE NFM_CODNFM = :NFM ';
  qryGen.ParamByName('NFM').AsString  :=  strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

procedure TGravandoExecucaoColorProImportaNovasFormulas.GravarNovaFormula(qryDestino: IDataSet; qryOrigem: TUniQuery);
Var
  intContador: Integer;
  intBasDilui: Integer;
begin
  If blnExisteNovaFormula Then
    Exit;

  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('WANPRO_CADNFM', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('NFM_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('NFM_CODNFM').AsString := strCodNfm;
  qryDestino.FieldByName('NFM_DESCRI').AsString := qryOrigem.FieldByName('DESCRI').AsString;
  qryDestino.FieldByName('NFM_DTACAD').AsDate := Date;
  qryDestino.FieldByName('NFM_LINHA_').AsString := qryOrigem.FieldByName('CODLIN').AsString;
  qryDestino.FieldByName('NFM_NOMLIN').AsString := qryOrigem.FieldByName('DESLIN').AsString;
  qryDestino.FieldByName('NFM_ALTERN').AsString := qryOrigem.FieldByName('ALTERN').AsString;
  qryDestino.FieldByName('NFM_MONTAD').AsString := '';
  qryDestino.FieldByName('NFM_CATALI').AsString := '';
  qryDestino.FieldByName('WAN_CAMADA').AsInteger := qryOrigem.FieldByName('CAMAD').AsInteger;
  qryDestino.FieldByName('NFM_ATIVO_').AsString := 'S';

  intBasDilui := 1;


  For intContador := 1 To 20 Do
  Begin
    If arrCodPig[intContador].IsEmpty Then
      Break;

    If arrBasDil[intContador] <> 'N' Then
      Break;

    qryDestino.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString := arrCodPig[intContador];
    qryDestino.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := arrQtdPigCon[intContador];

    If arrLinPig[intContador] = '72' Then
      qryDestino.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := arrQtdPigDil9Por2[intContador]
    Else
      qryDestino.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := arrQtdPigDil[intContador];

    qryDestino.FieldByName('NFM_QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := arrQtdPigDil4Por1[intContador];
    Inc(intBasDilui);
  End;

  If arrBasDil[intBasDilui] = 'S' Then
  Begin
    qryDestino.FieldByName('NFM_CODDIL').AsString := arrCodPig[intBasDilui];


    If arrLinPig[intBasDilui] = '72' Then
    Begin
      If arrQtdPigDil9Por2[intBasDilui] <> 0 Then
        qryDestino.FieldByName('NFM_QTDDIL').AsFloat := arrQtdPigDil9Por2[intBasDilui];
    End
    Else
    Begin
      If arrQtdPigDil[intBasDilui] <> 0 Then
        qryDestino.FieldByName('NFM_QTDDIL').AsFloat := arrQtdPigDil[intBasDilui];
    End;

    If arrQtdPigDil4Por1[intBasDilui] <> 0 Then
      qryDestino.FieldByName('NFM_QTDDI4').AsFloat := arrQtdPigDil4Por1[intBasDilui];
  End;

  qryDestino.Post;
end;

procedure TGravandoExecucaoColorProImportaNovasFormulas.pCalculaPrecos(intContador: Integer);
begin
  If (Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '01_04_06_09_11_12_14_19_16_37_15_17_27_67_74_75_76_') > 0) Then
  Begin
    fltPerCen := qryNfmLay.FieldByName('Percentual').AsFloat;

    If (Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '11_') > 0) Then
    Begin
      If qryNfmLay.FieldByName('CODBAS').AsString = 'Q065' Then
        fltVolumeMassa := 0
      Else
        fRetornaPreco11(fltPerCen,
                        qryBases.FieldByName('PesoEsp').AsFloat,
                        qryBases.FieldByName('TamEmbala').AsFloat,
                        qryBases.FieldByName('Preco').AsFloat,
                        fltTotalConcentrado,
                        fltVolumeMassa);
    End
    Else
      fRetornaPreco(fltPerCen,
                    qryBases.FieldByName('PesoEsp').AsFloat,
                    qryBases.FieldByName('TamEmbala').AsFloat,
                    qryBases.FieldByName('Preco').AsFloat,
                    fltTotalConcentrado,
                    fltVolumeMassa);

    fltVolumeConcentrado := fltVolumeMassa;

    If (Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '01_04_12_14_19_16') > 0) Then
    Begin
      fRetornaPreco(fltPerCen * fltFatBas,
                    qryBases.FieldByName('PesoEsp').AsFloat,
                    qryBases.FieldByName('TamEmbala').AsFloat,
                    qryBases.FieldByName('Preco').AsFloat,
                    fltTotalDiluido,
                    fltVolumeMassa);
    End
    Else If (Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '37_') > 0) Then
    Begin
      fRetornaPrecoPU(fltPerCen * fltFatBas,
                      qryBases.FieldByName('PesoEsp').AsFloat,
                      qryBases.FieldByName('TamEmbala').AsFloat,
                      qryBases.FieldByName('Preco').AsFloat,
                      fltTotalDiluido,
                      900*fltFatBas,
                      fltVolumeMassa);
    End
    Else
      fltVolumeMassa := 0.0;

    fltVolumeDiluido := fltVolumeMassa;

    arrLinPig[intContador]    := qryNfmLay.FieldByName('CODLIN').AsString;
    arrCodPig[intContador]    := qryNfmLay.FieldByName('CODBAS').AsString;
    arrBasDil[intContador]    := 'N';
    arrQtdPigCon[intContador] := fltVolumeConcentrado;
    arrQtdPigDil[intContador] := fltVolumeDiluido;
    arrPorcen[intContador]    := qryNfmLay.FieldByName('Percentual').AsFloat;
  End
end;

procedure TGravandoExecucaoColorProImportaNovasFormulas.pCalculaPrecosDemaisLinhas(
  intContador: Integer);
begin
  If (Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '01_04_06_09_11_12_14_19_16_37_15_17_27_67_74_75_76_') > 0) Then
    Exit;


  If TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString,2) = '13' Then
  Begin
    fltDivisorEmb2por1 := 1.10;
    fltDivisorEmb4por1 := 1.25;
    fltMultiplicadorEmb2Por1 := 10.00;
    fltMultiplicadorEmb4Por1 := 25.00;
    fltEmb2Por1 := TAM_EMBALAGEM_2POR1_BT100;
    fltEmb4por1 := TAM_EMBALAGEM_4POR1;
    fltTamEmb2Por1 := fltEmb2Por1 / fltDivisorEmb2por1;
    fltTamEmb4Por1 := fltEmb4por1 / fltDivisorEmb4por1;
    fltVolTinner2Por1 := (fltTamEmb2Por1 * fltMultiplicadorEmb2Por1 / 100.0);
    fltVolTinner4Por1 := (fltTamEmb4Por1 * fltMultiplicadorEmb4Por1 / 100.0);
  End
  Else If (TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2) = '72') Then
  Begin
    fltDivisorEmb9Por2 := 1.11;
    fltMultiplicadorEmb9Por2 := 11.1;
    fltEmb9Por2 := TAM_EMBALAGEM_9POR2;
    fltTamEmb9Por2 := fltEmb9Por2 / fltDivisorEmb9Por2;
    fltVolTinner9Por2 := (fltTamEmb9Por2 * fltMultiplicadorEmb9Por2 / 100.0);
  End
  Else If Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString,2), '58_59_') > 0 Then
  Begin
    fltEmb4por1 := TAM_EMBALAGEM_4POR1;
    fltMultiplicadorEmb4Por1 := 20;
    fltVolTinner2Por1 := 0.0;
    fltVolTinner4Por1 := (fltEmb4Por1 * fltMultiplicadorEmb4Por1 / 100.0);
    fltTamEmb2Por1 := 0;
    fltTamEmb4Por1 := fltEmb4por1 - fltVolTinner4Por1;
  End
  Else If TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString,2) = '08' Then
  Begin
    fltEmb2Por1 := TAM_EMBALAGEM_2POR1;
    fltEmb4por1 := TAM_EMBALAGEM_4POR1;
    fltVolTinner2Por1 := (fltEmb2Por1 * ((100 * 23.076) / fltSomaR2))/100;
    fltVolTinner4Por1 := (fltEmb4Por1 * ((100 * 25.000) / fltSomaR4))/100;
  End;

  fltPerCen    := qryNfmLay.FieldByName('Percentual').AsFloat;

  fRetornaPrecoPU(fltPerCen,
                  qryBases.FieldByName('PesoEsp').AsFloat,
                  qryBases.FieldByName('TamEmbala').AsFloat,
                  qryBases.FieldByName('Preco').AsFloat,
                  fltTotalConcentrado,
                  900,
                  fltVolumeMassa);

  fltVolumeConcentrado := fltVolumeMassa;
  fltVolumeDiluido := 0.0;

  If Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '08_13_') > 0 Then
  Begin
    Try
      blnCalcula2Por1 := Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString,2), '08_13_') > 0;
      fRetornaPrecoPU(TAutcomTintaFactory.Get.IIF(blnCalcula2Por1, fltPerCen, 0),
                        qryBases.FieldByName('PesoEsp').AsFloat,
                        qryBases.FieldByName('TamEmbala').AsFloat,
                        qryBases.FieldByName('Preco').AsFloat,
                        TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString,2), '08_') > 0, fltTotalDiluido2, fltTotalDiluido),
                        TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString,2), '08_') > 0, fltEmb2Por1, fltTamEmb2Por1),
                        fltVolumeMassa);

      fltVolumeDiluido := fltVolumeMassa;
    Except
      fltVolumeDiluido := fltVolumeConcentrado;
    End;

  End;

  If Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '08_13_58_59_') > 0 Then
  Begin
    Try
      blnCalcula4Por1 := Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '08_13_58_59_') > 0;
      fRetornaPrecoPU(TAutcomTintaFactory.Get.IIF(blnCalcula4Por1, fltPerCen, 0),
                      qryBases.FieldByName('PesoEsp').AsFloat,
                      qryBases.FieldByName('TamEmbala').AsFloat,
                      qryBases.FieldByName('Preco').AsFloat,
                      TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString,2), '08_') > 0, fltTotalDiluido4, fltTotalDiluido),
                      TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString,2), '08_') > 0, fltEmb4Por1, fltTamEmb4Por1),
                      fltVolumeMassa);

      fltVolumeDil4Por1 := fltVolumeMassa;
    Except
      fltVolumeDil4Por1 := fltVolumeConcentrado;
    End;
  End;

  If Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '072_') > 0 Then
  Begin
    Try
      blnCalcula9Por2 := Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '72_') > 0;
      fRetornaPrecoPU(TAutcomTintaFactory.Get.IIF(blnCalcula9Por2, fltPerCen, 0),
                      qryBases.FieldByName('PesoEsp').AsFloat,
                      qryBases.FieldByName('TamEmbala').AsFloat,
                      qryBases.FieldByName('Preco').AsFloat,
                      fltTotalDiluido,
                      fltTamEmb9Por2,
                      fltVolumeMassa);

      fltVolumeDil9Por2 := fltVolumeMassa;
    Except
      fltVolumeDil9Por2 := fltVolumeConcentrado;
    End;
  End;

  arrLinPig[intContador]         := qryNfmLay.FieldByName('CODLIN').AsString;
  arrCodPig[intContador]         := qryNfmLay.FieldByName('CODBAS').AsString;
  arrBasDil[intContador]         := 'N';
  arrQtdPigCon[intContador]      := fltVolumeConcentrado;
  arrQtdPigDil[intContador]      := fltVolumeDiluido;
  arrQtdPigDil4Por1[intContador] := fltVolumeDil4Por1;
  arrQtdPigDil9Por2[intContador] := fltVolumeDil9Por2;
  arrPorcen[intContador]         := qryNfmLay.FieldByName('Percentual').AsFloat;
end;

procedure TGravandoExecucaoColorProImportaNovasFormulas.pCalculaPrecosDiluido(
  intContador: Integer);
begin
  If (Not TStrUtils.fEmptyStr(strLinDil)) And (qryBases.Locate('Linha;Base', VarArrayOf([IntToStr(StrToInt(strLinDil)), strBasDil]), [])) Then
  Begin
    If (Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '01_04_12_14_19_16') > 0) Then
    Begin
      fRetornaPreco(fltPerDil,
                    qryBases.FieldByName('PesoEsp').AsFloat,
                    qryBases.FieldByName('TamEmbala').AsFloat,
                    qryBases.FieldByName('Preco').AsFloat,
                    fltTotalDiluido,
                    fltVolumeMassa);
    End
    Else If (Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '37_') > 0) Then
    Begin
      fltVolumeMassa := (900 * fltPerDil / 100) * qryBases.FieldByName('PesoEsp').AsFloat;
      fltVolumeMassa := TFloatUtils.fTruncaFloat(fltVolumeMassa, 1);
    End
    Else If (Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString,2), '08_58_59_13') > 0) Then
    Begin
      fRetornaPrecoPU(fltVolTinner2Por1 * qryBases.FieldByName('PesoEsp').AsFloat,
                      qryBases.FieldByName('PesoEsp').AsFloat,
                      qryBases.FieldByName('TamEmbala').AsFloat,
                      qryBases.FieldByName('Preco').AsFloat,
                      TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString,2), '08_') > 0, fltTotalDiluido2, fltTotalDiluido),
                      0.0,
                      fltVolumeMassa);

      fRetornaPrecoPU(fltVolTinner4Por1 * qryBases.FieldByName('PesoEsp').AsFloat,
                      qryBases.FieldByName('PesoEsp').AsFloat,
                      qryBases.FieldByName('TamEmbala').AsFloat,
                      qryBases.FieldByName('Preco').AsFloat,
                      TAutcomTintaFactory.Get.IIF(Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString,2), '08_') > 0, fltTotalDiluido4, fltTotalDiluido),
                      0.0,
                      fltVolumeDil4Por1);
    End
    Else If Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 3), '072_') > 0 Then
    Begin
      fRetornaPrecoPU(fltVolTinner9Por2 * qryBases.FieldByName('PesoEsp').AsFloat,
                      qryBases.FieldByName('PesoEsp').AsFloat,
                      qryBases.FieldByName('TamEmbala').AsFloat,
                      qryBases.FieldByName('Preco').AsFloat,
                      fltTotalDiluido,
                      0.0,
                      fltVolumeDil9Por2);
    End;

    arrLinPig[intContador]         := strLinDil;
    arrCodPig[intContador]         := strBasDil;
    arrBasDil[intContador]         := 'S';
    arrQtdPigCon[intContador]      := 0.0;
    arrQtdPigDil[intContador]      := fltVolumeMassa;
    arrQtdPigDil4Por1[intContador] := fltVolumeDil4Por1;
    arrQtdPigDil9Por2[intContador] := fltVolumeDil9Por2;
    arrPorcen[intContador]         := 0.0;
  End;
end;

procedure TGravandoExecucaoColorProImportaNovasFormulas.pCalculaTotalPorcentagemVolume;
begin
  fltTotalConcentrado  := 0.0;
  fltTotalDiluido  := 0.0;
  fltTotalDiluido2 := 0.0;
  fltTotalDiluido4 := 0.0;
  fltSomaR2      := 0.0;
  fltSomaR4      := 0.0;
  fltPEThinner   := 0.0;

  strLinPro := qryNfmLay.FieldByName('CODLIN').AsString;

  pRetornaInfoLinha(strLinPro, strLinDil, strBasDil, fltFatBas, fltPerDil);

  If (Pos(TStrUtils.fStrZero(strLinPro,2), '08_58_59_13_72_') > 0) Then
    fltFatBas := 1;

  While Not qryNfmLay.Eof Do
  Begin
    If (Not qryBases.Locate('Linha;Base', VarArrayOf([qryNfmLay.FieldByName('CODLIN').AsString, qryNfmLay.FieldByName('CODBAS').AsString]), [])) Then
    Begin
      qryNfmLay.Next;
      blnNGravar := False;
      sNGravar := Format('Não foi possível gravar está nova fórmula ID: %s - %s, pois não existe base cadastrada: Cód.Base: %s | Cód.Linha: %s',
      [qryNfmLay.FieldByName('ID').AsString, qryNfmLay.FieldByName('DESCRI').AsString, qryNfmLay.FieldByName('CODBAS').AsString, qryNfmLay.FieldByName('CODLIN').AsString]);
      Exit;
    End;

    If Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '11_') > 0 Then
    Begin
      If qryNfmLay.FieldByName('CODBAS').AsString <> 'Q065' Then
          fltTotalConcentrado := fltTotalConcentrado + (((qryNfmLay.FieldByName('Percentual').AsFloat * 100) / (100 - 23))/ qryBases.FieldByName('PesoEsp').AsFloat);
    End
    Else If (Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '08_') > 0) Then
    Begin
        fltTotalConcentrado := fltTotalConcentrado + (qryNfmLay.FieldByName('Percentual').AsFloat / qryBases.FieldByName('PesoEsp').AsFloat);

        fltSomaR2 := fltSomaR2 + qryNfmLay.FieldByName('Percentual').AsFloat;
        fltSomaR4 := fltSomaR4 + qryNfmLay.FieldByName('Percentual').AsFloat;
    End
    Else If qryBases.FieldByName('PesoEsp').AsFloat > 0 Then
    Begin
      fltTotalDiluido := fltTotalDiluido + ((qryNfmLay.FieldByName('Percentual').AsFloat * fltFatBas) / qryBases.FieldByName('PesoEsp').AsFloat);
      fltTotalConcentrado := fltTotalConcentrado + (qryNfmLay.FieldByName('Percentual').AsFloat / qryBases.FieldByName('PesoEsp').AsFloat);
    End;

    qryNfmLay.Next;
  End;

  pCalculaTotalPorcentagemVolumeLinha8;

  If (Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '37_72_') <= 0) Then
  Begin
    If (Not TStrUtils.fEmptyStr(strLinDil)) And (qryBases.Locate('Linha;Base', VarArrayOf([IntToStr(StrToInt(strLinDil)), strBasDil]), [])) Then
    Begin
      If qryBases.FieldByName('PesoEsp').AsFloat > 0 Then
        fltTotalDiluido := fltTotalDiluido + (fltPerDil / qryBases.FieldByName('PesoEsp').AsFloat);
    End;
  End;
end;

procedure TGravandoExecucaoColorProImportaNovasFormulas.pCalculaTotalPorcentagemVolumeLinha8;
begin
  If (Pos(TStrUtils.fStrZero(qryNfmLay.FieldByName('CODLIN').AsString, 2), '08_') > 0) Then
  Begin
    If (Not TStrUtils.fEmptyStr(strLinDil)) And (qryBases.Locate('Linha;Base', VarArrayOf([IntToStr(StrToInt(strLinDil)), strBasDil]), [])) Then
      fltPEThinner := qryBases.FieldByName('PesoEsp').AsFloat;

    fltSomaR2 := fltSomaR2 + 23.076;
    fltSomaR4 := fltSomaR4 + 25.000;

    fltPerThinner2    := (100 * 23.076) / fltSomaR2;
    fltPerThinner2    := (fltPerThinner2 * fltTotalConcentrado * fltPEThinner) / (100 - fltPerThinner2);

    fltPerThinner4    := (100 * 25.000) / fltSomaR4;
    fltPerThinner4    := (fltPerThinner4 * fltTotalConcentrado * fltPEThinner) / (100 - fltPerThinner4);

    qryNfmLay.First;
    While Not qryNfmLay.Eof Do
    Begin
      If (Not qryBases.Locate('Linha;Base', VarArrayOf([qryNfmLay.FieldByName('CODLIN').AsString, qryNfmLay.FieldByName('CODBAS').AsString]), [])) Then
      Begin
        qryNfmLay.Next;
        Continue;
      End;

      fltTotalDiluido2 := fltTotalDiluido2 + (qryNfmLay.FieldByName('Percentual').AsFloat / qryBases.FieldByName('PesoEsp').AsFloat);
      fltTotalDiluido4 := fltTotalDiluido4 + (qryNfmLay.FieldByName('Percentual').AsFloat / qryBases.FieldByName('PesoEsp').AsFloat);
      qryNfmLay.Next;
    End;

    fltTotalDiluido2 := fltTotalDiluido2 + (fltPerThinner2/fltPEThinner);
    fltTotalDiluido4 := fltTotalDiluido4 + (fltPerThinner4/fltPEThinner);
  End;
end;

procedure TGravandoExecucaoColorProImportaNovasFormulas.pRetornaInfoLinha(
  strLinha: String; var strLinDil, strBasDil: String; var fltFatBas,
  fltPerDil: Double);
Var
  conf   : IConfTinta;
begin
  conf  := TAutcomTintaFactory.Get.fGetConfTinta('WCP');

  strLinDil := '';
  strBasDil := '';
  fltFatBas := 0.0;
  fltPerDil := 0.0;

  If (strLinha = '4') Then
  Begin
    strLinDil := Conf.fGet('LD1WAN');
    strBasDil := Conf.fGet('BD1WAN');

    fltPerDil := 33.33;
  End
  Else If (strLinha = '1') Then
  Begin
    strLinDil := Conf.fGet('LD1ABS_100_50');
    strBasDil := Conf.fGet('BD1ABS_100_50');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '14') Then
  Begin
    strLinDil := Conf.fGet('LD1ABS_100_80');
    strBasDil := Conf.fGet('BD1ABS_100_80');
    fltPerDil := 44.4;
  End
  Else If (strLinha = '8') Then
  Begin
    strLinDil := Conf.fGet('LD1PU_HS');
    strBasDil := Conf.fGet('BD1PU_HS');
  End
  Else If (strLinha = '58') Then
  Begin
    strLinDil := Conf.fGet('LD1PU_MS');
    strBasDil := Conf.fGet('BD1PU_MS');
  End
  Else If (strLinha = '16') Then
  Begin
    strLinDil := Conf.fGet('LD1BT120');
    strBasDil := Conf.fGet('BD1BT120');
    fltPerDil := 30;
  End;

  pRetornaInfoLinhas(strLinha, strLinDil, strBasDil, fltFatBas, fltPerDil, Conf);

  If (fltPerDil > 0.0) Then
    fltFatBas := (100 - fltPerDil) / 100;
end;

procedure TGravandoExecucaoColorProImportaNovasFormulas.pRetornaInfoLinhas(
  strLinha: String; var strLinDil, strBasDil: String; var fltFatBas,
  fltPerDil: Double; Conf: IConfTinta);
begin
  If (strLinha = '59') Then
  Begin
    strLinDil := Conf.fGet('LD1BT90');
    strBasDil := Conf.fGet('BD1BT90');
  End
  Else If (strLinha = '37') Then
  Begin
    strLinDil := Conf.fGet('LD1BT80');
    strBasDil := Conf.fGet('BD1BT80');
    fltPerDil := 15;
  End
  Else If (strLinha = '13') Then
  Begin
    strLinDil := Conf.fGet('LD1BT100');
    strBasDil := Conf.fGet('BD1BT100');
  End
  Else If (strLinha = '12') Then
  Begin
    strLinDil := Conf.fGet('LPAPB_10080');
    strBasDil := Conf.fGet('BPAPB_10080');
    fltPerDil := 44.40;
  End
  Else If (strLinha = '19') Then
  Begin
    strLinDil := Conf.fGet('LD1ABS_BASELINE');
    strBasDil := Conf.fGet('BD1ABS_BASELINE');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '72') Then
  Begin
    strLinDil := Conf.fGet('LD1BT362');
    strBasDil := Conf.fGet('BD1BT362');
    fltPerDil := 11.111;
  End;
end;

Procedure TGravandoExecucaoColorProImportaNovasFormulas.ProcessarParametrosBasesQuantidades(qryNfm: IDataSet);
Var
  intContador: integer;
begin
  For intContador := 2 To 20 Do
  Begin
    If arrBasDil[intContador] = 'N' Then
    Begin
      ProcessarParametrosBasesQuantidadesNao(qryNfm, intContador);
    End
    Else If arrBasDil[intContador] = 'S' Then
    Begin
      ProcessarParametrosBasesQuantidadesSim(qryNfm, intContador);
      Break;
    End;
  End;
end;

procedure TGravandoExecucaoColorProImportaNovasFormulas.ProcessarParametrosBasesQuantidadesNao(
  qryNfm: IDataSet; intContador: Integer);
begin
  If (Not arrCodPig[intContador].IsEmpty) Then
    qryNfm.ParamByName('CODB' + TStrUtils.fStrZero(intContador, 2)).AsString := arrCodPig[intContador];

  If arrQtdPigCon[intContador] <> 0 Then
    qryNfm.ParamByName('QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := arrQtdPigCon[intContador];

  If arrLinPig[intContador] = '72' Then
  Begin
    If arrQtdPigDil9Por2[intContador] <> 0 Then
      qryNfm.ParamByName('QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := arrQtdPigDil9Por2[intContador];
  End
  Else
  Begin
    If arrQtdPigDil[intContador] <> 0 Then
      qryNfm.ParamByName('QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := arrQtdPigDil[intContador];
  End;

  If arrQtdPigDil4Por1[intContador] <> 0 Then
    qryNfm.ParamByName('QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloat := arrQtdPigDil4Por1[intContador];
end;

procedure TGravandoExecucaoColorProImportaNovasFormulas.ProcessarParametrosBasesQuantidadesSim(
  qryNfm: IDataSet; intContador: Integer);
begin
  If (Not arrCodPig[intContador].IsEmpty) Then
    qryNfm.ParamByName('CODDIL').AsString := arrCodPig[intContador];

  If arrLinPig[intContador] = '72' Then
  Begin
    If arrQtdPigDil9Por2[intContador] <> 0 Then
      qryNfm.ParamByName('QTDDIL').AsFloat := arrQtdPigDil9Por2[intContador];
  End
  Else
  Begin
    If arrQtdPigDil[intContador] <> 0 Then
      qryNfm.ParamByName('QTDDIL').AsFloat := arrQtdPigDil[intContador];
  End;

  If arrQtdPigDil4Por1[intContador] <> 0 Then
    qryNfm.ParamByName('QTDDI4').AsFloat := arrQtdPigDil4Por1[intContador];
end;

end.
