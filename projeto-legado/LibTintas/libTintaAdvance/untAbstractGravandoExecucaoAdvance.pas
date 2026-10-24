{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Advance *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoAdvance;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni, Variants, untStatusGravando, ComObj,  DBFUniProvider;

Type
  TColAdv = Record
    strCodCol:String;
    fltQtdCol:Double;
  End;

type
  TAbstractGravandoExecucaoAdvance = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    //Querys para processar as gerações GDATA;
    qryProduts    : TUniQuery;
    qrySubProduts : TUniQuery;
    qryMask       : TUniQuery;
    qryBases      : TUniQuery;
    qryCnts       : TUniQuery;
    ////////////////////////////////////////////

    //Conexoes para processar as gerações GDATA;
    conProduts    : TUniConnection;
    conSubProduts : TUniConnection;
    conMask       : TUniConnection;
    conBases      : TUniConnection;
    conCnts       : TUniConnection;
    ////////////////////////////////////////////

    //Querys responsaveis pelos cadastros & objetos
    qryADV_CADBAS : IDataSet;
    qryADV_CADCOL : IDataSet;
    qryADV_CADEMB : IDataSet;
    qryADV_CADNFM : IDataSet;
    qryADV_CADADV : IDataSet;
    qryADV_GERFRM : IDataSet;

    ExcelFrm : Variant;
    intMaxLinhaFrm,
    intLinhaAtualFrm : Integer;
    ////////////////////////////////////////////



    //funcões para processar as gerações GDATA;
    function GetPath : String;
    function fStrEspaco(str:String; Tamanho:Integer; intPos:Integer = 1):String;
    function fCalQtdEmb(fltQtdCol:Double; strEmbCon, strQtdEmb:String):Double;
    function fMaxLinha(Excel:Variant):Integer;
    function fRetProximoCodSeq():Integer;
    function fValidaDiretorio(): Boolean;
    function fVerificaCadBases():Boolean;
    function fVerificaCadColorantes():Boolean;
    function fVerificaCadEmbalagem():Boolean;
    function fRetUnidadeEmbalagem(fltQtd:Double):String;
    function fGravarCadAdvance(intCodSeq:Integer; strBase__:String; strProKey:String; strSubKey:String; strDescri:String; arrColAdv: Array Of TColAdv): Boolean;
    function fGravaCadEmbalagem(Gravando: IGravando):Boolean;
    function fGravaCadBases(strBase__:String; strProKey:String; strSubKey:String; strDescri:String):Boolean;
    function fGravaCadColorantes(arrColAdv: Array Of TColAdv; Gravando: IGravando):Boolean;
    function fGravarCadNovasFormulas(qryNfm_:IDataSet; Gravando: IGravando): Boolean;
    ////////////////////////////////////////////

    //procedures para processar as gerações GDATA;
    procedure pAtualizaTabelas();
    procedure pApagandoTemporarias();
    procedure pPreencheTemporariaFRM(Gravando: IGravando);
    procedure pCarregarBases(Gravando: IGravando);
    procedure pCarregarProduts(Gravando: IGravando);
    procedure pCarregarSubProduts(strPatPro:String; Gravando:IGravando);
    procedure pCarregarFrm(strPatPro:String; strPatSub:String; Gravando: IGravando);
    procedure pCarregarMask(strPatSub:String; Gravando: IGravando);

    //Funções de GetSql e Conexão
    function GetDbfAdvance(DataBase:String):TUniConnection;
    function GetSQLAdvance(strSQL:String; Conexao:TUniConnection):TUniQuery;





  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untAutcomTintaFactory, untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoAdvanceCores }


constructor TAbstractGravandoExecucaoAdvance.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ADV');

  qryADV_CADBAS := TAutcomTintaFactory.Get.fGetDataSet;
  qryADV_CADCOL := TAutcomTintaFactory.Get.fGetDataSet;
  qryADV_CADEMB := TAutcomTintaFactory.Get.fGetDataSet;
  qryADV_CADNFM := TAutcomTintaFactory.Get.fGetDataSet;
  qryADV_CADADV := TAutcomTintaFactory.Get.fGetDataSet;

  qryADV_CADBAS.Close;
  qryADV_CADCOL.Close;
  qryADV_CADEMB.Close;
  qryADV_CADNFM.Close;
  qryADV_CADADV.Close;

  qryADV_CADBAS.SQL.Empty;
  qryADV_CADCOL.SQL.Empty;
  qryADV_CADEMB.SQL.Empty;
  qryADV_CADNFM.SQL.Empty;
  qryADV_CADADV.SQL.Empty;

  qryADV_CADBAS.SQL := '  SELECT * FROM ADVCOR_CADBAS     ';
  qryADV_CADCOL.SQL := '  SELECT * FROM ADVCOR_CADCOL     ';
  qryADV_CADEMB.SQL := '  SELECT * FROM ADVCOR_CADEMB     ';
  qryADV_CADNFM.SQL := '  SELECT * FROM ADVCOR_CADNFM     ';
  qryADV_CADADV.SQL := '  SELECT * FROM ADVCOR_CADADV     ';

  qryADV_CADBAS.Open;
  qryADV_CADCOL.Open;
  qryADV_CADEMB.Open;
  qryADV_CADNFM.Open;
  qryADV_CADADV.Open;

  qryADV_CADBAS.First;
  qryADV_CADCOL.First;
  qryADV_CADEMB.First;
  qryADV_CADNFM.First;
  qryADV_CADADV.First;

end;

destructor TAbstractGravandoExecucaoAdvance.Destroy;
begin
  inherited;
  FreeAndNil(qryProduts);
  FreeAndNil(qrySubProduts);
  FreeAndNil(qryMask);
  FreeAndNil(qryBases);
  FreeAndNil(qryCnts);

  If Assigned(conProduts) Then FreeAndNil(conProduts);
  If Assigned(conSubProduts) Then FreeAndNil(conSubProduts);
  If Assigned(conMask) Then FreeAndNil(conMask);
  If Assigned(conBases) Then FreeAndNil(conBases);
  If Assigned(conCnts) Then FreeAndNil(conCnts);

  pApagandoTemporarias

end;


function TAbstractGravandoExecucaoAdvance.fCalQtdEmb(fltQtdCol: Double;
  strEmbCon, strQtdEmb: String): Double;
Var
  fltEmbAtu,
  fltEmbMas:Double;
begin
  {**************************************************************************}
  {* FAZ O CALCULO POR EMBALAGEM E JÁ POSICIONA O CADEMB PARA GRAVAR A BASE *}
  {***********************************************************************PH*}

  qryADV_CADEMB.Locate('EMB_CODEMB', strEmbCon, []);
  fltEmbAtu := qryADV_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  qryADV_CADEMB.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qryADV_CADEMB.FieldByName('EMB_QTDEMB').AsFloat;

  Result := fltEmbMas * fltQtdCol / fltEmbAtu;
end;

function TAbstractGravandoExecucaoAdvance.fGravaCadBases(strBase__, strProKey,
  strSubKey, strDescri: String): Boolean;
begin
  Result := False;
  If Not qryADV_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD', VarArrayOf([strBase__, strProKey, strSubKey,
    qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    Result := True;
    qryADV_CADBAS.Insert;
    qryADV_CADBAS.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADVCOR_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryADV_CADBAS.FieldByName('BAS_BASE__').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryADV_CADBAS.FieldByName('BAS_BASE__').AsString := strBase__;
    qryADV_CADBAS.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryADV_CADBAS.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryADV_CADBAS.FieldByName('BAS_UNIDAD').AsString := qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString;
    qryADV_CADBAS.FieldByName('BAS_DESCRI').AsString := strDescri;
    qryADV_CADBAS.Post;
  End;
end;

function TAbstractGravandoExecucaoAdvance.fGravaCadColorantes(
  arrColAdv: array of TColAdv; Gravando: IGravando): Boolean;
Var
  intContador : Integer;
  function fRetornaDescColorante(strColId:String):String;
  Begin
    Result := '';
    strColId := fStrEspaco(IntToStr(StrToIntDef(strColId, 0)), 5, 2);
    If qryCnts.Locate('ID', strColId, []) Then
      Result := qryCnts.FieldByName('DESCR').AsString;
  End;
begin
  Result := False;
  For intContador := Low(arrColAdv) To High(arrColAdv) Do
  Begin
    qryADV_CADCOL.First;
    If Not qryADV_CADCOL.Locate('COL_CODCOL', arrColAdv[intContador].strCodCol, []) Then
    Begin
      If Not TStrUtils.fEmptyStr(arrColAdv[intContador].strCodCol) Then
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryADV_CADCOL.Insert;
        qryADV_CADCOL.FieldByName('COL_CODCOL').AsString := arrColAdv[intContador].strCodCol;
        qryADV_CADCOL.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADVCOR_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
        qryADV_CADCOL.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryADV_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColAdv[intContador].strCodCol);
        qryADV_CADCOL.Post;
      End;
    End
    Else If TStrUtils.fEmptyStr(qryADV_CADCOL.FieldByName('COL_DESCRI').AsString) Then
    Begin
      qryADV_CADCOL.Edit;
      qryADV_CADCOL.FieldByName('COL_DESCRI').AsString := fRetornaDescColorante(arrColAdv[intContador].strCodCol);
      qryADV_CADCOL.Post;
    End;
  End;


end;

function TAbstractGravandoExecucaoAdvance.fGravaCadEmbalagem(
  Gravando: IGravando): Boolean;
Var
  qryCans: TUniQuery;
  conCans: TUniConnection;
begin
  Result := False;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Carregando dados do Cadastro de Embalagem...';

  Gravando.Texto := 'Deletando cadastro de embalagem inconsistente...';
  qryADV_CADEMB.Close;
  qryADV_CADEMB.SQL.Empty;
  qryADV_CADEMB.SQL := '    DELETE FROM ADVCOR_CADEMB     ';
  qryADV_CADEMB.ExecSQL;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('ADVCOR_CADEMB');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.RegistrarProgresso(0, 0, 0);
  Gravando.Texto := 'Processando Cadastro de Embalagem...';

  qryADV_CADEMB.SQL := '    SELECT * FROM ADVCOR_CADEMB     ';
  qryADV_CADEMB.Open;

  conCans := TUniConnection.Create(Nil);
  conCans.ProviderName := 'DBF';
  conCans.LoginPrompt  := False;
  conCans.Database := GetPath;

  If Not conCans.Connected Then
    conCans.Connected := True;

  qryCans := TUniQuery.Create(Nil);
  qryCans.Connection := conCans;
  qryCans.SQL.Add('   SELECT * FROM \CANS.DBF   ');
  qryCans.Open;
  qryCans.First;

  While Not qryCans.Eof Do
  Begin
    Result := True;
    If (Gravando.Status <> sgGravando) Then
      Break;

    qryADV_CADEMB.Insert;
    qryADV_CADEMB.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(Trim(qryCans.FieldByName('ID').AsString), 2);
    qryADV_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := qryCans.FieldByName('NOM_Q').AsFloat;
    qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString := fRetUnidadeEmbalagem(qryCans.FieldByName('NOM_Q').AsFloat);
    qryADV_CADEMB.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryADV_CADEMB.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADVCOR_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
    qryADV_CADEMB.Post;

    qryCans.Next;
    Gravando.RegistrarProgresso(0, qryCans.RecNo, qryCans.RecordCount);

  End;

  FreeAndNil(qryCans);
  If Assigned(conCans) Then
    FreeAndNil(conCans);

end;

function TAbstractGravandoExecucaoAdvance.fGravarCadAdvance(intCodSeq: Integer;
  strBase__, strProKey, strSubKey, strDescri: String;
  arrColAdv: array of TColAdv): Boolean;
Var
  intContador:Integer;
  strMd5Key:String;
begin
  Result := False;
  If qryADV_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD', VarArrayOf([strBase__, strProKey, strSubKey,
    qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString]), []) Then
  Begin
    If (qryADV_CADADV.FieldByName('ADV_DESCRI').AsString <> strDescri) Or (qryADV_CADADV.FieldByName('ADV_CODIGO').AsString <> qryADV_GERFRM.FieldByName('KEY1').AsString) Or
       (qryADV_CADADV.FieldByName('ADV_CODIG2').AsString <> qryADV_GERFRM.FieldByName('KEY2').AsString) Or (qryADV_CADADV.FieldByName('ADV_UNIDAD').AsString <> qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString) Or
       (qryADV_CADADV.IsEmpty) Then
    Begin
      qryADV_CADADV.Insert;
      qryADV_CADADV.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADVCOR_CADADV', TAutcomTintaFactory.Get.GetCodEmp);
      qryADV_CADADV.FieldByName('ADV_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryADV_CADADV.FieldByName('ADV_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
      qryADV_CADADV.FieldByName('ADV_DESCRI').AsString := strDescri;
      qryADV_CADADV.FieldByName('ADV_CODIGO').AsString := qryADV_GERFRM.FieldByName('KEY1').AsString;
      qryADV_CADADV.FieldByName('ADV_CODIG2').AsString := AnsiUpperCase(qryADV_GERFRM.FieldByName('KEY2').AsString);
      qryADV_CADADV.FieldByName('ADV_UNIDAD').AsString := qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString;
      qryADV_CADADV.FieldByName('ADV_BASE__').AsString := strBase__;
      qryADV_CADADV.FieldByName('ADV_PROKEY').AsString := strProKey;
      qryADV_CADADV.FieldByName('ADV_SUBKEY').AsString := strSubKey;

      strMd5Key := strMd5Key + qryADV_CADADV.FieldByName('ADV_DESCRI').AsString;
      strMd5Key := strMd5Key + qryADV_CADADV.FieldByName('ADV_CODIGO').AsString;
      strMd5Key := strMd5Key + qryADV_CADADV.FieldByName('ADV_CODIG2').AsString;
      strMd5Key := strMd5Key + qryADV_CADADV.FieldByName('ADV_UNIDAD').AsString;

      For intContador := Low(arrColAdv) To High(arrColAdv) Do
      Begin

        If TStrUtils.fEmptyStr(arrColAdv[intContador].strCodCol) Then
          Break;

        qryADV_CADADV.FieldByName('ADV_FORM' + TStrUtils.fStrZero(intContador + 1, 2)).AsString :=
          arrColAdv[intContador].strCodCol;

        If conf.fGetInteger('QTDORI') = 1 Then
        Begin
          If qryADV_CADCOL.Locate('COL_CODCOL', VarArrayOf([arrColAdv[intContador].strCodCol]), []) Then
            arrColAdv[intContador].fltQtdCol := arrColAdv[intContador].fltQtdCol / qryADV_CADCOL.FieldByName('COL_PESESP').AsFloat;
        End;

        qryADV_CADADV.FieldByName('ADV_QTDB' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat :=
          arrColAdv[intContador].fltQtdCol;

        strMd5Key := strMd5Key + qryADV_CADADV.FieldByName('ADV_FORM' + TStrUtils.fStrZero(intContador + 1, 2)).AsString;
        strMd5Key := strMd5Key + StringReplace(Format('%.4f', [qryADV_CADADV.FieldByName('ADV_QTDB' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat]), ',' , '.', [rfReplaceAll]);
      End;

      qryADV_CADADV.FieldByName('ADV_MD5KEY').AsString := GetMD5(strMd5Key);
      qryADV_CADADV.Post;
      Result := True;
    End;
  End;
end;

function TAbstractGravandoExecucaoAdvance.fGravarCadNovasFormulas(
  qryNfm_: IDataSet; Gravando: IGravando): Boolean;
Var
  strMd5Key:String;
  intContador: Integer;
begin
  Try
    If (Gravando.Status <> sgGravando) Then
    Begin
      Result := False;
      Exit;
    End;

    If qryNfm_.IsEmpty Then
    Begin
      Gravando.Texto := 'O Cadastro de Novas Fórmulas está vazio...';
      Result := False;
      Exit;
    End;

    qryADV_CADADV.Close;
    qryADV_CADADV.SQL.Empty;
    qryADV_CADADV.SQL := '    DELETE FROM ADVCOR_CADADV WHERE ADV_CODIGO = :FORMULA   ';
    qryADV_CADADV.ParamByName('FORMULA').AsString := qryNfm_.FieldByName('NFM_CODPRO').AsString;
    qryADV_CADADV.ExecSQL;

    qryADV_CADADV.SQL.Empty;
    qryADV_CADADV.SQL := '    SELECT * FROM ADVCOR_CADADV LIMIT 0     ';
    qryADV_CADADV.Open;

    qryADV_CADBAS.Close;
    qryADV_CADBAS.SQL.Empty;
    qryADV_CADBAS.SQL   := '    SELECT * FROM ADVCOR_CADBAS      ' +
                           '      INNER JOIN CADITE ON           ' +
                           '      ITE_CODITE = BAS_CODITE        ' +
                           '    WHERE                            ' +
                           '      BAS_BASE__ = :BASE__   AND     ' +
                           '      BAS_PROKEY = :PROKEY   AND     ' +
                           '      BAS_SUBKEY = :SUBKEY           ';
    qryADV_CADBAS.ParamByName('BASE__').AsString := qryNfm_.FieldByName('NFM_BASE__').AsString;
    qryADV_CADBAS.ParamByName('PROKEY').AsString := qryNfm_.FieldByName('NFM_PROKEY').AsString;
    qryADV_CADBAS.ParamByName('SUBKEY').AsString := qryNfm_.FieldByName('NFM_SUBKEY').AsString;
    qryADV_CADBAS.Open;

    While Not qryADV_CADBAS.Eof Do
    Begin

      If (Gravando.Status <> sgGravando) Then
        Break;

      qryADV_CADADV.Insert;
      qryADV_CADADV.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADVCOR_CADADV', TAutcomTintaFactory.Get.GetCodEmp);
      qryADV_CADADV.FieldByName('ADV_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryADV_CADADV.FieldByName('ADV_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
      qryADV_CADADV.FieldByName('ADV_CODIGO').AsString := qryNfm_.FieldByName('NFM_CODPRO').AsString;
      qryADV_CADADV.FieldByName('ADV_CODIG2').AsString := qryNfm_.FieldByName('NFM_CODPRO').AsString;
      qryADV_CADADV.FieldByName('ADV_CODITE').AsString := qryADV_CADBAS.FieldByName('BAS_CODITE').AsString;
      qryADV_CADADV.FieldByName('ADV_DESCRI').AsString := qryNfm_.FieldByName('NFM_DESCRI').AsString + ' ' + qryNfm_.FieldByName('NFM_CODPRO').AsString;
      qryADV_CADADV.FieldByName('ADV_UNIDAD').AsString := qryADV_CADBAS.FieldByName('BAS_UNIDAD').AsString;
      qryADV_CADADV.FieldByName('ADV_BASE__').AsString := qryNfm_.FieldByName('NFM_BASE__').AsString;
      qryADV_CADADV.FieldByName('ADV_PROKEY').AsString := qryNfm_.FieldByName('NFM_PROKEY').AsString;
      qryADV_CADADV.FieldByName('ADV_SUBKEY').AsString := qryNfm_.FieldByName('NFM_SUBKEY').AsString;
      qryADV_CADADV.FieldByName('ADV_DTACAD').AsDate   := qryNfm_.FieldByName('NFM_DTACAD').AsDate;

      strMd5Key := strMd5Key + qryADV_CADADV.FieldByName('ADV_DESCRI').AsString;
      strMd5Key := strMd5Key + qryADV_CADADV.FieldByName('ADV_CODIGO').AsString;
      strMd5Key := strMd5Key + qryADV_CADADV.FieldByName('ADV_CODIG2').AsString;
      strMd5Key := strMd5Key + qryADV_CADADV.FieldByName('ADV_UNIDAD').AsString;

      For intContador := 1 To 20 Do
      Begin

        If TStrUtils.fEmptyStr(qryNfm_.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
          Break;

        qryADV_CADADV.FieldByName('ADV_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString :=
          qryNfm_.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString;

        qryADV_CADADV.FieldByName('ADV_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
          fCalQtdEmb(qryNfm_.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intContador, 2)).AsFloat,
            qryNfm_.FieldByName('NFM_UNIDAD').AsString,
            qryADV_CADBAS.FieldByName('BAS_UNIDAD').AsString);

        strMd5Key := strMd5Key + qryADV_CADADV.FieldByName('ADV_FORM' + TStrUtils.fStrZero(intContador + 1, 2)).AsString;
        strMd5Key := strMd5Key + StringReplace(Format('%.4f', [qryADV_CADADV.FieldByName('ADV_QTDB' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat]),
         ',' , '.' , [rfReplaceAll]);

      End;

      qryADV_CADADV.FieldByName('ADV_MD5KEY').AsString := GetMD5(strMd5Key);
      qryADV_CADADV.Post;
      qryADV_CADBAS.Next;
    End;

    Result := True;
  Finally
    //
  End;

end;

function TAbstractGravandoExecucaoAdvance.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAdvance.fMaxLinha(Excel: Variant): Integer;
begin
  Excel.Selection.SpecialCells(11).Select;
  Result := Excel.ActiveCell.Row;
end;

function TAbstractGravandoExecucaoAdvance.fRetProximoCodSeq: Integer;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT ADV_CODSEQ FROM ADVCOR_CADADV ORDER BY ADV_CODSEQ DESC LIMIT 1   ';
  qryGen.Open;

  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('ADV_CODSEQ').AsInteger + 1;
end;

function TAbstractGravandoExecucaoAdvance.fRetUnidadeEmbalagem(
  fltQtd: Double): String;
begin
  Result := '';
  If (fltQtd >= 900) And (fltQtd <= 1000) Then
    Result := 'LT'
  Else If (fltQtd > 3000) And (fltQtd <= 4500) Then
    Result := 'GL'
  Else If (fltQtd > 16500) And (fltQtd <= 20000) Then
    Result := 'LA';

end;

function TAbstractGravandoExecucaoAdvance.fStrEspaco(str: String; Tamanho,
  intPos: Integer): String;
Var
  I: Integer;
begin
  Case IntPos Of
    1: For I := Length(str) To Tamanho - 1 Do
         str := str + ' ';
    2: For I := Length(str) To Tamanho - 1 Do
         str := ' ' + str;
  End;

  fStrEspaco := Str;
end;

function TAbstractGravandoExecucaoAdvance.fValidaDiretorio: Boolean;
begin
  Result := True;

  If Not FileExists(GetPath + '\PRODUCTS.DBF') Then
    Result := False;
end;

function TAbstractGravandoExecucaoAdvance.fVerificaCadBases: Boolean;
begin
  pAtualizaTabelas;
  Result := Not (qryADV_CADBAS.IsEmpty);
end;

function TAbstractGravandoExecucaoAdvance.fVerificaCadColorantes: Boolean;
begin
  pAtualizaTabelas;
  Result := Not (qryADV_CADCOL.IsEmpty);
end;

function TAbstractGravandoExecucaoAdvance.fVerificaCadEmbalagem: Boolean;
Var
  qryCans  : TUniQuery;
  conCans  : TUniConnection;
  intConta : Integer;
  intErros : Integer;
begin
  intErros := 0;
  conCans := TUniConnection.Create(Nil);
  conCans.ProviderName := 'DBF';
  conCans.LoginPrompt := False;
  ConCans.Database := GetPath;

  If Not conCans.Connected Then
    ConCans.Connected := True;

  qryCans := TUniQuery.Create(Nil);
  qryCans.Connection := conCans;
  qryCans.SQL.Add('   SELECT * FROM \CANS.DBF    ');
  qryCans.Open;
  qryCans.First;

  If Not qryADV_CADEMB.IsEmpty Then
  Begin
    For intConta := 1 To qryCans.RecordCount Do
    Begin
      If (qryCans.FieldByName('NOM_Q').AsFloat > 0) And (Not TStrUtils.fEmptyStr(qryCans.FieldByName('NOM_Q').AsString)) Then
      Begin
        If Not qryADV_CADEMB.Locate('EMB_CODEMB', TStrUtils.fStrZero(Trim(qryCans.FieldByName('ID').AsString), 2), []) Then
        Begin
          Inc(intErros);
          Break;
        End
        Else If TStrUtils.fEmptyStr(qryADV_CADEMB.FieldByName('EMB_UNIDAD').AsString) Then
        Begin
          Inc(intErros);
          Break;
        End;
      End;
      qryCans.Next;
    End;
  End
  Else
    Inc(intErros);

  Result := intErros = 0;
  qryCans.Close;

  FreeAndNil(qryCans);
  FreeAndNil(conCans);
end;

function TAbstractGravandoExecucaoAdvance.GetDbfAdvance(DataBase:String): TUniConnection;
begin
  Result := TUniConnection.Create(Nil);
  Result.ProviderName := 'DBF';
  Result.LoginPrompt  := False;
  Result.Database := DataBase;
end;

function TAbstractGravandoExecucaoAdvance.GetPath: String;
begin
  Result := conf.fGet('PATADV');
end;


function TAbstractGravandoExecucaoAdvance.GetSQLAdvance(
  strSQL: String; Conexao:TUniConnection): TUniQuery;
begin
  Result := TUniQuery.Create(Nil);
  Result.Connection := Conexao;
  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Add(strSQL);
  Result.Open;
  Result.First;
end;

procedure TAbstractGravandoExecucaoAdvance.pApagandoTemporarias;
begin
  TAutcomTintaFactory.Get.DropTable('TMP_GERFRM');
end;

procedure TAbstractGravandoExecucaoAdvance.pAtualizaTabelas;
begin
  qryADV_CADBAS.Close;
  qryADV_CADCOL.Close;
  qryADV_CADEMB.Close;
  qryADV_CADNFM.Close;
  qryADV_CADADV.Close;

  qryADV_CADBAS.Open;
  qryADV_CADCOL.Open;
  qryADV_CADEMB.Open;
  qryADV_CADNFM.Open;
  qryADV_CADADV.Open;
end;

procedure TAbstractGravandoExecucaoAdvance.pCarregarBases(Gravando: IGravando);
begin
  conBases := GetDbfAdvance(GetPath);
  conCnts  := GetDbfAdvance(GetPath);

  If Not conBases.Connected Then
    conBases.Connected := True;

  If Not conCnts.Connected Then
    conCnts.Connected := True;

  qryBases := GetSQLAdvance('   SELECT * FROM \BASES.DBF   ', conBases);
  qryCnts  := GetSQLAdvance('   SELECT * FROM \CNTS.DBF    ', conCnts);


end;

procedure TAbstractGravandoExecucaoAdvance.pCarregarFrm(strPatPro,
  strPatSub: String; Gravando: IGravando);
Var
  strPath:String;
begin
  If FileExists(strPatSub + '\FRM.DBF') Then
    strPath := strPatSub
  Else If FileExists(strPatPro + '\FRM.DBF') Then
    strPath := strPatPro
  Else
    strPath := GetPath;
  Try
    ExcelFrm := CreateOleObject('Excel.Application');
    ExcelFrm.Visible := False;
    ExcelFrm.WorkBooks.Add(strPath + '\FRM.DBF');

    intMaxLinhaFrm := fMaxLinha(ExcelFrm);
    intLinhaAtualFrm := 2;

    Gravando.Texto := 'Carregando SubProduto. Aguarde...';
    pPreencheTemporariaFRM(Gravando);

    qryADV_GERFRM := TAutcomTintaFactory.Get.fGetDataSet;
    qryADV_GERFRM.Close;
    qryADV_GERFRM.SQL.Empty;
    qryADV_GERFRM.SQL := '    SELECT * FROM TMP_GERFRM    ';
    qryADV_GERFRM.Open;

  Finally
    //ExcelFrm.WorkBooks.Close;
    ExcelFrm.Quit;
    ExcelFrm := Unassigned;
  End;
end;

procedure TAbstractGravandoExecucaoAdvance.pCarregarMask(strPatSub: String;
  Gravando: IGravando);
begin

  If Assigned(qryMask) Then
  Begin
    FreeAndNil(qryMask);
    FreeAndNil(conMask);
  End;

  conMask := GetDbfAdvance(strPatSub);

  If Not conMask.Connected Then
    conMask.Connected := True;

  qryMask := GetSQLAdvance('    SELECT * FROM \MASK.DBF    ', conMask);
end;

procedure TAbstractGravandoExecucaoAdvance.pCarregarProduts(
  Gravando: IGravando);
begin

  conProduts := GetDbfAdvance(GetPath);

  If Not conProduts.Connected Then
    conProduts.Connected := True;

  qryProduts := GetSQLAdvance('   SELECT * FROM \PRODUCTS.DBF    ', conProduts);

end;

procedure TAbstractGravandoExecucaoAdvance.pCarregarSubProduts(
  strPatPro: String; Gravando: IGravando);
begin

  If Assigned(qrySubProduts) Then
  Begin
    FreeAndNil(qrySubProduts);
    FreeAndNil(conSubProduts);
  End;

  conSubProduts := GetDbfAdvance(strPatPro);

  If Not conSubProduts.Connected Then
    conSubProduts.Connected := True;

  qrySubProduts := GetSQLAdvance('    SELECT * FROM \SUBPRODS.DBF    ', conSubProduts);
end;

procedure TAbstractGravandoExecucaoAdvance.pPreencheTemporariaFRM(Gravando: IGravando);
Var
  qryFrm :IDataSet;
  intTemporaria :Integer;
begin
  qryFrm := TAutcomTintaFactory.Get.fGetDataSet;

  TAutcomTintaFactory.Get.DropTable('TMP_GERFRM');

  qryFrm.SQL := '   CREATE TABLE TMP_GERFRM     ( ' +
                '     BASE_ID CHAR(02),           ' +
                '     CAN_ID  CHAR(02),           ' +
                '     FORMULA  VARCHAR(100),      ' +
                '     KEY1    VARCHAR(100),       ' +
                '     KEY2    VARCHAR(100),       ' +
                '     COMMENT  VARCHAR(255)     );  ';

  qryFrm.ExecSQL;

  qryFrm.SQL.Empty;

  qryFrm.SQL := '   SELECT * FROM TMP_GERFRM    ';
  qryFrm.Open;

  For intTemporaria := 1 To intMaxLinhaFrm  Do
  Begin

    If TStrUtils.fEmptyStr(ExcelFrm.Cells.Item[intLinhaAtualFrm, 8].Text) Then
      Break;

    qryFrm.Insert;
    qryFrm.FieldByName('BASE_ID').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm, 8].Text;
    qryFrm.FieldByName('CAN_ID').AsString  := ExcelFrm.Cells.Item[intLinhaAtualFrm, 9].Text;
    qryFrm.FieldByName('FORMULA').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm, 11].Text;
    qryFrm.FieldByName('KEY1').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm, 3].Text;
    qryFrm.FieldByName('KEY2').AsString    := ExcelFrm.Cells.Item[intLinhaAtualFrm, 4].Text;
    qryFrm.FieldByName('COMMENT').AsString := ExcelFrm.Cells.Item[intLinhaAtualFrm, 27].Text;
    qryFrm.Post;

    intLinhaAtualFrm := intLinhaAtualFrm + 1;
    Gravando.RegistrarProgresso(0, intLinhaAtualFrm, intMaxLinhaFrm);
  End;


end;

end.
