unit untTOrdProAtualizaPrecos;

interface

uses System.SysUtils, System.StrUtils, Rest.Json, cxProgressBar, untZClient, Uni, Vcl.Forms,
  Data.DB, untPreAlt_Trigger;

type
  TTipoAtualizacao = (opAtualizarPrecoVenda, opAtualizarMargem);
  TTipoMarcar = (opcAlterado, opcMenor, opcMaior, opcDesmarcar, opcInverter);

type
  TArrayOfString = TArray<String>;
  TPArrayOfString = ^TArrayOfString;

  TEstruturaFiltros = class
  private
    FProdutos: TArrayOfString;
    FLinhaGrupos: TArrayOfString;
    FUnidades: TArrayOfString;
    FFornecedores: TArrayOfString;
    FMarcas: TArrayOfString;
  public
    property LinhaGrupos: TArrayOfString read FLinhaGrupos write FLinhaGrupos;
    property Produtos: TArrayOfString read FProdutos write FProdutos;
    property Fornecedores: TArrayOfString read FFornecedores write FFornecedores;
    property Marcas: TArrayOfString read FMarcas write FMarcas;
    property Unidades: TArrayOfString read FUnidades write FUnidades;
  end;

  TSubItensFiltros = class
  private
    FProdutos: TArrayOfString;
    FLinhaGrupos: TArrayOfString;
    FUnidades: TArrayOfString;
    FFornecedores: TArrayOfString;
    FMarcas: TArrayOfString;
  public
    property LinhaGrupos: TArrayOfString read FLinhaGrupos write FLinhaGrupos;
    property Produtos: TArrayOfString read FProdutos write FProdutos;
    property Fornecedores: TArrayOfString read FFornecedores write FFornecedores;
    property Marcas: TArrayOfString read FMarcas write FMarcas;
    property Unidades: TArrayOfString read FUnidades write FUnidades;
  end;

  TOrdProAtualizaPrecosParams = class
  private
    FTipoAtualizacao: TTipoAtualizacao;
    FFiltroSubItens: TSubItensFiltros;
    FFiltroEstrutura: TEstruturaFiltros;
    FSomenteExibir: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function ToJsonString(): String;
    class function FromJsonString(AJson: String): TObject;
  public
    property TipoAtualizacao: TTipoAtualizacao read FTipoAtualizacao write FTipoAtualizacao;
    property FiltroEstrutura: TEstruturaFiltros read FFiltroEstrutura write FFiltroEstrutura;
    property FiltroSubItens: TSubItensFiltros read FFiltroSubItens write FFiltroSubItens;
    property SomenteExibir: Boolean read FSomenteExibir write FSomenteExibir;
  end;

  TOrdProAtualizaPrecos = class
  private
    FParams: TOrdProAtualizaPrecosParams;
    FGerMat: TZClient;
    FDetMat: TZClient;
  private
    function fGetSqlGerMat: String;
    function fGetSqlDetMat: String;
    function fSQLFiltroSubProduto: String;
    function fTemFiltroSubProduto: Boolean;
    function GetTabelasPreco: String;
    function fGetSqlLocate(ACodigos: TArray<String>; AField, AParam: String): String;
    function fGetSqlLinhaGrupo(ACodigos: TArray<String>; AField: String): String;
    procedure pSetQueryParam(ACodigos: TArray<String>; AParam: String; AQuery: TUniQuery);
    procedure pFormataNumericos;
    procedure pCalculaCusto(strCodIte: String);
    function fRetPrecoCustoInclusao: Double;

    function GetPrecoCusto: String;
    function GetTipoAtualizacaoPreco: TTipoAtualizacao;
  public
    constructor Create(AParams: TOrdProAtualizaPrecosParams);
    destructor Destroy; override;
  public
    function fCarregarRegistros(cxProgress: TcxProgressBar): Boolean;
    function fRecalcularCustos(cxProgress: TcxProgressBar): Boolean;
    function fGravarAlteracoes(cxProgress: TcxProgressBar): Boolean;
    procedure pMarcar(opcao: TTipoMarcar);
    procedure pConfirmaTransacao(blnCommit: Boolean);

  public
    property cdsGerMat: TZClient read FGerMat write FGerMat;
    property cdsDetMat: TZClient read FDetMat write FDetMat;
    property strTabelasPreco: String read GetTabelasPreco;
    property strPrecoCusto: String read GetPrecoCusto;
    property TipoAtualizacao: TTipoAtualizacao read GetTipoAtualizacaoPreco;
  end;

implementation

uses
  untFuncoesSimples, untPreAlt, untParCalculaPrecoCusto, untTConfiguracao;

{ TOrdProAtualizaPrecosParams }

constructor TOrdProAtualizaPrecosParams.Create;
begin
  FiltroSubItens := TSubItensFiltros.Create;
  FiltroEstrutura := TEstruturaFiltros.Create;
  FTipoAtualizacao := opAtualizarPrecoVenda;
end;

destructor TOrdProAtualizaPrecosParams.Destroy;
begin
  FreeAndNil(FFiltroSubItens);
  FreeAndNil(FFiltroEstrutura);
  inherited;
end;

class function TOrdProAtualizaPrecosParams.FromJsonString(AJson: String): TObject;
begin
  Result := TJson.JsonToObject<TOrdProAtualizaPrecosParams>(AJson);
end;

function TOrdProAtualizaPrecosParams.ToJsonString: String;
begin
  Result := TJsonUtils.Format(TJson.ObjectToJsonString(Self));
end;

{ TOrdProAtualizaPrecos }

function TOrdProAtualizaPrecos.fCarregarRegistros(cxProgress: TcxProgressBar): Boolean;
begin
  If Assigned(cxProgress) Then
    pInfoStatusGravacao(cxProgress, 'Carregando Registros...');

  cdsGerMat := TZClient.Create(nil, fGetSqlGerMat);
  cdsGerMat.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  pSetQueryParam(FParams.FiltroEstrutura.Produtos, 'CODITE', cdsGerMat.qryQuery);
  pSetQueryParam(FParams.FiltroEstrutura.Fornecedores, 'CODFOR', cdsGerMat.qryQuery);
  pSetQueryParam(FParams.FiltroEstrutura.Marcas, 'CODMAR', cdsGerMat.qryQuery);
  pSetQueryParam(FParams.FiltroEstrutura.Unidades, 'CODUNI', cdsGerMat.qryQuery);

  If fTemFiltroSubProduto Then
  Begin
    pSetQueryParam(FParams.FiltroSubItens.Produtos, 'DET_CODITE', cdsGerMat.qryQuery);
    pSetQueryParam(FParams.FiltroSubItens.Fornecedores, 'DET_CODFOR', cdsGerMat.qryQuery);
    pSetQueryParam(FParams.FiltroSubItens.Marcas, 'DET_CODMAR', cdsGerMat.qryQuery);
    pSetQueryParam(FParams.FiltroSubItens.Unidades, 'DET_CODUNI', cdsGerMat.qryQuery);
  End;

  cdsGerMat.fAbreClient(True, 'TfrmOrdProAtualizaPrecos.FormCreate');

  If Assigned(cxProgress) Then
    cxProgress.Properties.Max := cdsGerMat.RecordCount;

  cdsDetMat := TZClient.Create(nil, fGetSqlDetMat);
  cdsDetMat.IndexFieldNames := 'DMT_SEQGER';
  cdsDetMat.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  If fTemFiltroSubProduto Then
  Begin
    pSetQueryParam(FParams.FiltroSubItens.Produtos, 'DET_CODITE', cdsDetMat.qryQuery);
    pSetQueryParam(FParams.FiltroSubItens.Fornecedores, 'DET_CODFOR', cdsDetMat.qryQuery);
    pSetQueryParam(FParams.FiltroSubItens.Marcas, 'DET_CODMAR', cdsDetMat.qryQuery);
    pSetQueryParam(FParams.FiltroSubItens.Unidades, 'DET_CODUNI', cdsDetMat.qryQuery);
  End;

  cdsDetMat.fAbreClient(True, 'TfrmOrdProAtualizaPrecos.FormCreate');

  pFormataNumericos;

  Result := fRecalcularCustos(cxProgress);
end;

function TOrdProAtualizaPrecos.fRecalcularCustos(cxProgress: TcxProgressBar): Boolean;
Begin
  If Assigned(cxProgress) Then
  Begin
    cxProgress.Position := 0;
    cxProgress.Properties.Max := cdsGerMat.RecordCount;
    pInfoStatusGravacao(cxProgress, 'Calculando custos...');
  End;

  Try
    cdsGerMat.DisableControls;
    cdsGerMat.First;

    While Not cdsGerMat.Eof Do
    Begin
      If Assigned(cxProgress) Then
        cxProgress.Position := cxProgress.Position + 1;

      pCalculaCusto(cdsGerMat.FieldByName('ITE_CODITE').AsString);
      cdsGerMat.Next;

      if (cdsGerMat.RecNo Mod 50) = 0 Then
        Application.ProcessMessages;
    End;
    Result := True;
  Finally
    cdsGerMat.First;
    cdsGerMat.EnableControls;
  End;

End;



function TOrdProAtualizaPrecos.fRetPrecoCustoInclusao: Double;
Var
  cpcParams: TParCalculaPrecoCusto;
begin
  Try
    cpcParams := TParCalculaPrecoCusto.Create(nil, TConfiguracao.fGetConfiguracao);

      cpcParams.curPreCom := cdsGerMat.FieldByName('NEW_PRECUS').AsFloat;
      cpcParams.curDesF01 := cdsGerMat.FieldByName('ITE_DESF01').AsFloat;
      cpcParams.curDesF02 := cdsGerMat.FieldByName('ITE_DESF02').AsFloat;
      cpcParams.curDesF03 := cdsGerMat.FieldByName('ITE_DESF03').AsFloat;
      cpcParams.curDesF04 := cdsGerMat.FieldByName('ITE_DESF04').AsFloat;
      cpcParams.curDesF05 := cdsGerMat.FieldByName('ITE_DESF05').AsFloat;
      cpcParams.curDesF06 := cdsGerMat.FieldByName('ITE_DESF06').AsFloat;
      cpcParams.curICMSEnt := cdsGerMat.FieldByName('ITE_ICMENT').AsFloat;
      cpcParams.curIPIEnt := cdsGerMat.FieldByName('ITE_IPIENT').AsFloat;
      cpcParams.curFrete := cdsGerMat.FieldByName('ITE_FREENT').AsFloat;
      cpcParams.curAcrFin := cdsGerMat.FieldByName('ITE_ACRFIN').AsFloat;
      cpcParams.curSubsti := cdsGerMat.FieldByName('ITE_SUBSTI').AsFloat;
      cpcParams.curValFre := cdsGerMat.FieldByName('ITE_VALFRE').AsFloat;
      cpcParams.curDesAdb := cdsGerMat.FieldByName('ITE_DESADB').AsFloat;
      cpcParams.curSubFed := cdsGerMat.FieldByName('ITE_SUBFED').AsFloat;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        cpcParams.curTCIFCu := cdsGerMat.FieldByName('ITE_TCIFCU').AsFloat;
        cpcParams.curTSCust := cdsGerMat.FieldByName('ITE_TSCUST').AsFloat;
        cpcParams.curDePiCo := cdsGerMat.FieldByName('ITE_DEPICO').AsFloat;
        cpcParams.curDeICMS := cdsGerMat.FieldByName('ITE_DEICMS').AsFloat;
        cpcParams.curFatReg := cdsGerMat.FieldByName('ITE_FATREG').AsFloat;
      end
      else
      begin
        cpcParams.curTCIFCu := 0;
        cpcParams.curTSCust := 0;
        cpcParams.curDePiCo := 0;
        cpcParams.curDeICMS := 0;
        cpcParams.curFatReg := 0;
      end;

    Result := cpcParams.fCalculaPrecoCusto(false);

  Finally
    FreeAndNil(cpcParams);
  End;
End;

procedure TOrdProAtualizaPrecos.pCalculaCusto(strCodIte: String);
Var
  fltPreCus: Double;
  intIndex: Integer;



Begin
  If cdsGerMat.FieldByName('ITE_CODITE').AsString <> strCodIte Then
    If Not cdsGerMat.Locate('ITE_CODITE', strCodIte, []) Then
      Exit;

  cdsDetMat.Filtered := false;
  cdsDetMat.Filter := 'DMT_SEQGER = ' + QuotedStr(cdsGerMat.FieldByName('AUTOINCREM').AsString);
  cdsDetMat.Filtered := True;

  fltPreCus := 0;
  While not cdsDetMat.Eof Do
  Begin
    fltPreCus := fltPreCus + cdsDetMat.FieldByName(strPrecoCusto).AsFloat;
    cdsDetMat.Next;
  End;

  cdsGerMat.Edit;
  cdsGerMat.FieldByName('CALCU').AsInteger := 1;
  cdsGerMat.FieldByName('NEW_PRECUS').AsFloat := fltPreCus;

  cdsGerMat.FieldByName('NEW_CUSLIQ').AsFloat := fRetPrecoCustoInclusao;

  If cdsGerMat.FieldByName('NEW_CUSLIQ').AsFloat <> cdsGerMat.FieldByName('ITE_PRECUS').AsFloat Then
    cdsGerMat.FieldByName('MARCA').AsInteger := 1;

  Case FParams.TipoAtualizacao Of
    opAtualizarPrecoVenda:
      Begin
        For intIndex := 1 To Length(strTabelasPreco) Do
        Begin
          If strTabelasPreco[intIndex] = 'S' Then
          Begin
            cdsGerMat.FieldByName('NEW_PREVE' + IntToStr(intIndex)).AsFloat :=
              fCalculaPrecoVenda(1, cdsGerMat.FieldByName('NEW_CUSLIQ').AsFloat +
              cdsGerMat.FieldByName('ITE_OUTVAL').AsFloat,
              cdsGerMat.FieldByName('ITE_PREVE' + IntToStr(intIndex)).AsFloat,
              cdsGerMat.FieldByName('ITE_MARBR' + IntToStr(intIndex)).AsFloat,
              cdsGerMat.FieldByName('ITE_ICMSAI').AsFloat, cdsGerMat.FieldByName('ITE_IMPFED')
              .AsFloat, cdsGerMat.FieldByName('ITE_DESOPE').AsFloat,
              cdsGerMat.FieldByName('ITE_COMTB' + IntToStr(intIndex)).AsFloat);
          End;
        End;
      End;

    opAtualizarMargem:
      Begin
        For intIndex := 1 To Length(strTabelasPreco) Do
        Begin
          If strTabelasPreco[intIndex] = 'S' Then
          Begin
            cdsGerMat.FieldByName('NEW_MARBR' + IntToStr(intIndex)).AsFloat :=
              fCalculaPrecoVenda(2, cdsGerMat.FieldByName('NEW_CUSLIQ').AsFloat +
              cdsGerMat.FieldByName('ITE_OUTVAL').AsFloat,
              cdsGerMat.FieldByName('ITE_PREVE' + IntToStr(intIndex)).AsFloat,
              cdsGerMat.FieldByName('ITE_MARBR' + IntToStr(intIndex)).AsFloat,
              cdsGerMat.FieldByName('ITE_ICMSAI').AsFloat, cdsGerMat.FieldByName('ITE_IMPFED')
              .AsFloat, cdsGerMat.FieldByName('ITE_DESOPE').AsFloat,
              cdsGerMat.FieldByName('ITE_COMTB' + IntToStr(intIndex)).AsFloat);
          End;
        End;

      End;

  End;

  cdsGerMat.Post;

End;

constructor TOrdProAtualizaPrecos.Create(AParams: TOrdProAtualizaPrecosParams);
begin
  FParams := AParams;
end;

destructor TOrdProAtualizaPrecos.Destroy;
begin
  If Assigned(FParams) Then
    FreeAndNil(FParams);
  If Assigned(FGerMat) Then
    FreeAndNil(FGerMat);
  If Assigned(FDetMat) Then
    FreeAndNil(FDetMat);
  inherited;
end;

function TOrdProAtualizaPrecos.fGetSqlDetMat: String;
Var
  blnCusRea: Boolean;

begin
  blnCusRea:= fCfgSis('PBCUES', varString) = 'REA';

  Result := '';
  Result := Result + ' SELECT DMT_SEQGER,                                   ';
  Result := Result + '        DMT_ITESUB,                                   ';
  Result := Result + '        CT.ITE_CODFAB,                                ';
  Result := Result + '        ITE_DESITE,                                   ';
  Result := Result + '        ITE_REFERE,                                   ';
  Result := Result + '        GMT_TIPQTD,                                   ';
  Result := Result + '        (SELECT COUNT(0)                              ';
  Result := Result + '         FROM GERMAT                                  ';
  Result := Result + '         WHERE GMT_CODITE = DMT_ITESUB) AS ESTRUTURA, ';

  If fCfgSis('PBCUES', varString) = 'REA' Then
  Begin
    Result := Result + '@IMPFED := IF(PDISIF.SIS_VALCFG = "S" AND ICMDEB.SIS_VALCFG = "S", ';
    Result := Result + ' (ITE_IMPFED * (1 - (ITE_ICMSAI/100))), ITE_IMPFED) AS IMPFED, ';
    Result := Result + '@VAL1:= (1-(ITE_ICMSAI + @IMPFED  + ITE_DESOPE) /100) AS TEMP_1, ';
    Result := Result + '@VAL2:= (ITE_PRECUS + ITE_OUTVAL) AS TEMP_2, ';
    Result := Result + '@CUSREA:= ROUND(CAST((@VAL2/@VAL1) AS DECIMAL(12,4)), 3) AS ITE_CUSREA_TEMP, ';
  End;

  If fCfgSis('DENMAS', varBoolean) Then
    Result := Result +
      ' (IF(IFNULL(ITE_DENSID, 1) <= 0, 1, IFNULL(ITE_DENSID, 1)) * IF(GMT_TIPQTD = "P", DMT_QTDITE/100, DMT_QTDITE)) * IFNULL('
      + IIF(blnCusRea, '@CUSREA', strPrecoCusto) + ',0) AS ' + IIF(blnCusRea, 'ITE_CUSREA', strPrecoCusto)
  Else
    Result := Result + ' IF(GMT_TIPQTD = "P", DMT_QTDITE/100, DMT_QTDITE) * IFNULL(' + IIF(blnCusRea, '@CUSREA', strPrecoCusto)
      + ',0) AS '+ IIF(blnCusRea, 'ITE_CUSREA', strPrecoCusto);

  Result := Result + ' FROM DETMAT DM                                       ';
  Result := Result + '   INNER JOIN GERMAT GM ON GM.AUTOINCREM = DMT_SEQGER ';
  Result := Result + '   INNER JOIN CADITE CT ON CT.ITE_CODITE = DMT_ITESUB ';
  Result := Result + '   INNER JOIN ITEGER IG                               ';
  Result := Result + '       ON IG.ITE_CODITE = DMT_ITESUB                  ';
  Result := Result + '      AND IG.ITE_CODEMP = :CODEMP                     ';
  Result := Result + '  INNER JOIN CFGSIS PDISIF ON PDISIF.SIS_CODCFG = "CFG_PDISIF" AND PDISIF.SIS_CODEMP = IG.ITE_CODEMP ';
  Result := Result + '  INNER JOIN CFGSIS ICMDEB ON ICMDEB.SIS_CODCFG = "CFG_ICMDEB" AND ICMDEB.SIS_CODEMP = IG.ITE_CODEMP ';

  Result := Result + '      WHERE TRUE ';
  Result := Result + fSQLFiltroSubProduto;

end;

function TOrdProAtualizaPrecos.fGetSqlGerMat: String;
Var
  intIndex: Integer;
Begin

  Result := '';
  Result := Result + ' SELECT 0 AS MARCA   ,                                 ';
  Result := Result + '        0 AS CALCU   ,                                 ';
  Result := Result + '        GM.AUTOINCREM,                                 ';
  Result := Result + '        IG.ITE_CODITE,                                 ';
  Result := Result + '        CT.ITE_DESITE,                                 ';
  Result := Result + '        CT.ITE_CODFAB,                                 ';

  Result := Result + '        IG.ITE_DESF01,                                 ';
  Result := Result + '        IG.ITE_DESF02,                                 ';
  Result := Result + '        IG.ITE_DESF03,                                 ';
  Result := Result + '        IG.ITE_DESF04,                                 ';
  Result := Result + '        IG.ITE_DESF05,                                 ';
  Result := Result + '        IG.ITE_DESF06,                                 ';
  Result := Result + '        IG.ITE_ICMENT,                                 ';
  Result := Result + '        IG.ITE_SUBFED,                                 ';
  Result := Result + '        IG.ITE_IPIENT,                                 ';
  Result := Result + '        IG.ITE_FREENT,                                 ';
  Result := Result + '        IG.ITE_VALFRE,                                 ';
  Result := Result + '        IG.ITE_ACRFIN,                                 ';
  Result := Result + '        IG.ITE_SUBSTI,                                 ';
  Result := Result + '        IG.ITE_DESADB,                                 ';

  Result := Result + '        IG.ITE_OUTVAL,                                 ';
  Result := Result + '        IG.ITE_ICMSAI,                                 ';
  Result := Result + '        IG.ITE_IMPFED,                                 ';
  Result := Result + '        IG.ITE_DESOPE,                                 ';
  Result := Result + '        IG.ITE_PRECUS,                                 ';
  Result := Result + '        IG.ITE_PRECOM,                                 ';
  Result := Result + '        CT.ITE_REFERE,                                 ';
  Result := Result + '   0.00 AS NEW_PRECUS,                                 ';
  Result := Result + '   0.00 AS NEW_CUSLIQ,                                  ';
  Result := Result + '        IG.ITE_TCIFCU,                                 ';
  Result := Result + '        IG.ITE_TSCUST,                                 ';
  Result := Result + '        IG.ITE_DEPICO,                                 ';
  Result := Result + '        IG.ITE_DEICMS,                                 ';
  Result := Result + '        IG.ITE_FATREG,                                 ';
  Result := Result + '        IG.ITE_ICMSAI ';

  For intIndex := 1 To Length(strTabelasPreco) Do
  Begin
    Result := Result + ',';

    Result := Result + '        IG.ITE_PREVE' + IntToStr(intIndex) + ', ';
    Result := Result + '        IG.ITE_MARBR' + IntToStr(intIndex) + ', ';
    Result := Result + '        IG.ITE_PREVE' + IntToStr(intIndex) + ' AS NEW_PREVE' +
      IntToStr(intIndex) + ', ';
    Result := Result + '        IG.ITE_MARBR' + IntToStr(intIndex) + ' AS NEW_MARBR' +
      IntToStr(intIndex) + ', ';
    Result := Result + '        IG.ITE_COMTB' + IntToStr(intIndex);
  End;

  Result := Result + ' FROM GERMAT GM                                        ';
  Result := Result + '   INNER JOIN CADITE CT ON CT.ITE_CODITE = GMT_CODITE  ';
  Result := Result + '   INNER JOIN ITEGER IG ON IG.ITE_CODITE = GMT_CODITE  ';
  Result := Result + '                       AND IG.ITE_CODEMP = :CODEMP     ';
  Result := Result + ' WHERE TRUE ';

  Result := Result + fGetSqlLocate(FParams.FiltroEstrutura.Fornecedores, 'CT.ITE_CODFOR', 'CODFOR');
  Result := Result + fGetSqlLocate(FParams.FiltroEstrutura.Marcas, 'CT.ITE_CODMAR', 'CODMAR');
  Result := Result + fGetSqlLocate(FParams.FiltroEstrutura.Unidades, 'CT.ITE_CODUNI', 'CODUNI');
  Result := Result + fGetSqlLocate(FParams.FiltroEstrutura.Produtos, 'CT.ITE_CODITE', 'CODITE');

  Result := Result + fGetSqlLinhaGrupo(FParams.FiltroEstrutura.LinhaGrupos, 'CT.ITE_CODGRU');

  Result := Result + fSQLFiltroSubProduto;
end;

function TOrdProAtualizaPrecos.fSQLFiltroSubProduto: String;
begin
  Result := '';
  If fTemFiltroSubProduto Then
  Begin
    Result := Result + ' AND (SELECT COUNT(1) ';
    Result := Result + '        FROM DETMAT DM2  ';
    Result := Result + '       INNER JOIN GERMAT GM2 ON GM2.AUTOINCREM = DM2.DMT_SEQGER   ';
    Result := Result + '       INNER JOIN CADITE CT2 ON CT2.ITE_CODITE = DM2.DMT_ITESUB  ';
    Result := Result + '       INNER JOIN ITEGER IG2                                 ';
    Result := Result + '          ON IG2.ITE_CODITE = DM2.DMT_ITESUB                     ';
    Result := Result + '         AND IG2.ITE_CODEMP = :CODEMP                     ';
    Result := Result + ' WHERE TRUE ';

    Result := Result + fGetSqlLocate(FParams.FiltroSubItens.Fornecedores, 'CT2.ITE_CODFOR',
      'DET_CODFOR');
    Result := Result + fGetSqlLocate(FParams.FiltroSubItens.Marcas, 'CT2.ITE_CODMAR', 'DET_CODMAR');
    Result := Result + fGetSqlLocate(FParams.FiltroSubItens.Unidades, 'CT2.ITE_CODUNI',
      'DET_CODUNI');
    Result := Result + fGetSqlLocate(FParams.FiltroSubItens.Produtos, 'CT2.ITE_CODITE',
      'DET_CODITE');

    Result := Result + fGetSqlLinhaGrupo(FParams.FiltroSubItens.LinhaGrupos, 'CT2.ITE_CODGRU');

    Result := Result + ' AND DM2.DMT_SEQGER = GM.AUTOINCREM) > 0 ';
  End;
end;

function TOrdProAtualizaPrecos.fTemFiltroSubProduto: Boolean;
begin
  If Length(FParams.FiltroSubItens.LinhaGrupos) > 0 Then
    Exit(True);

  If Length(FParams.FiltroSubItens.Produtos) > 0 Then
    Exit(True);

  If Length(FParams.FiltroSubItens.Fornecedores) > 0 Then
    Exit(True);

  If Length(FParams.FiltroSubItens.Marcas) > 0 Then
    Exit(True);

  If Length(FParams.FiltroSubItens.Unidades) > 0 Then
    Exit(True);

  Result := false;
end;

function TOrdProAtualizaPrecos.GetPrecoCusto: String;
begin
  Result := fCfgSis('PBCUES', varString);
  If Result = 'IMP' Then
    Result := 'ITE_IMPULT'
  Else
  If Result = 'SIC' Then
    Result := 'ITE_MEDSIC'
  Else
  If Result = 'REA' Then
    Result := 'ITE_CUSREA'
  Else
    Result := 'ITE_PRE' + Result;
end;

function TOrdProAtualizaPrecos.GetTabelasPreco: String;
begin
  Result := fCfgSis('TABPRC', varString);
end;

function TOrdProAtualizaPrecos.GetTipoAtualizacaoPreco: TTipoAtualizacao;
begin
  Result := FParams.TipoAtualizacao;
end;

procedure TOrdProAtualizaPrecos.pSetQueryParam(ACodigos: TArray<String>; AParam: String;
  AQuery: TUniQuery);
Var
  LIndex: Integer;
  LCodigos: String;
Begin
  If Length(ACodigos) = 0 Then
    Exit;

  If AQuery.Params.FindParam(AParam) = Nil Then
    Exit;

  LCodigos := '';

  If Length(ACodigos) = 1 Then
    LCodigos := ACodigos[0]
  Else
    For LIndex := 0 To Length(ACodigos) - 1 Do
      LCodigos := LCodigos + ACodigos[LIndex] + '_';

  AQuery.ParamByName(AParam).AsString := LCodigos;
end;

function TOrdProAtualizaPrecos.fGetSqlLocate(ACodigos: TArray<String>;
  AField, AParam: String): String;
begin
  If Length(ACodigos) = 0 Then
    Result := ''
  Else If Length(ACodigos) = 1 Then
    Result := ' AND ' + AField + ' = :' + AParam + ' '
  Else
    Result := ' AND LOCATE(' + AField + ',:' + AParam + ') > 0  AND COALESCE(' + AField +
      ', "") <> "" ';
end;

function TOrdProAtualizaPrecos.fGetSqlLinhaGrupo(ACodigos: TArray<String>; AField: String): String;
Var
  LIndex: Integer;
Begin
  Result := '';

  If Length(ACodigos) = 0 Then
    Exit;

  Result := '(';

  For LIndex := Low(ACodigos) To High(ACodigos) Do
  Begin
    If RightStr(ACodigos[LIndex], 3) = '000' Then
      Result := Result + ' (LEFT(' + AField + ', 3) = ' +
        QuotedStr(LeftStr(ACodigos[LIndex], 3)) + ') '
    Else
      Result := Result + ' (' + AField + ' = ' + QuotedStr(ACodigos[LIndex]) + ') ';

    If LIndex <> High(ACodigos) Then
      Result := Result + ' OR ';
  End;

  Result := Result + ' ) ';

  If (Not fEmptyStr(Result)) Then
    Result := '  AND ' + Result;
end;

procedure TOrdProAtualizaPrecos.pFormataNumericos;
Var
  intIndex: Integer;
Begin
  For intIndex := 0 To cdsGerMat.Fields.Count - 1 Do
  Begin
    If cdsGerMat.Fields[intIndex] Is TFloatField Then
      TFloatField(cdsGerMat.Fields[intIndex]).DisplayFormat := '#,##0.00';
  End;
  For intIndex := 0 To cdsDetMat.Fields.Count - 1 Do
  Begin
    If cdsDetMat.Fields[intIndex] Is TFloatField Then
      TFloatField(cdsDetMat.Fields[intIndex]).DisplayFormat := '#,##0.00';
  End;
End;

function TOrdProAtualizaPrecos.fGravarAlteracoes(cxProgress: TcxProgressBar): Boolean;
Var
  qryUpdate: TUniQuery;
  intIndex: Integer;
  strUpdate: String;
  LAfterScroll: TDataSetNotifyEvent;
  strAgrupadorPreAlt: String;
begin
  pPreAltDefineVariaveisAltPre(fNow, 'TOrdProAtualizaPrecos', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);
  LAfterScroll := cdsGerMat.AfterScroll;
  Result := True;
  Try
    strUpdate := '';
    strUpdate := strUpdate + ' UPDATE ITEGER SET ITE_PREALT = :PREALT, ITE_PRECUS = :PRECUS, ITE_PRECOM = :PRECOM, ';

    For intIndex := 1 To Length(strTabelasPreco) Do
    Begin
      If strTabelasPreco[intIndex] = 'S' Then
      Begin
        strUpdate := strUpdate + ' ITE_PREVE' + IntToStr(intIndex) + ' = :PREVE' +
          IntToStr(intIndex) + ',';
        strUpdate := strUpdate + ' ITE_MARBR' + IntToStr(intIndex) + ' = :MARBR' +
          IntToStr(intIndex) + ',';
      End;
    End;
    strUpdate := Copy(strUpdate, 1, Length(strUpdate) - 1); // Tira a virgula que vai passar;
    strUpdate := strUpdate + ' WHERE ITE_CODITE = :CODITE ';
    strUpdate := strUpdate + '   AND LOCATE(ITE_CODEMP, "' + fRetEmpresasUsamPrecoMatriz + '") > 0 ';

    qryUpdate := fCriaQuery();
    qryUpdate.Close;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(strUpdate);

    cdsGerMat.AfterScroll := Nil;
    cdsGerMat.DisableControls;
    cdsGerMat.Filtered := false;
    cdsGerMat.Filter := 'MARCA = 1';
    cdsGerMat.Filtered := True;
    cdsGerMat.First;

    If Assigned(cxProgress) Then
      cxProgress.Properties.Max := cdsGerMat.RecordCount;

    While Result And (not cdsGerMat.Eof) Do
    Begin
      fStartTransaction;

      qryUpdate.ParamByName('CODITE').AsString := cdsGerMat.FieldByName('ITE_CODITE').AsString;
      qryUpdate.ParamByName('PRECOM').AsFloat := cdsGerMat.FieldByName('NEW_PRECUS').AsFloat;
      qryUpdate.ParamByName('PRECUS').AsFloat := cdsGerMat.FieldByName('NEW_CUSLIQ').AsFloat;

      For intIndex := 1 To Length(strTabelasPreco) Do
      Begin
        If strTabelasPreco[intIndex] = 'S' Then
        Begin
          qryUpdate.ParamByName('PREVE' + IntToStr(intIndex)).AsFloat :=  cdsGerMat.FieldByName('NEW_PREVE' + IntToStr(intIndex)).AsFloat;
          qryUpdate.ParamByName('MARBR' + IntToStr(intIndex)).AsFloat :=  cdsGerMat.FieldByName('NEW_MARBR' + IntToStr(intIndex)).AsFloat;
        End;
      End;

      Try
        qryUpdate.ExecSql;
      Except
        On E: Exception Do
        Begin
          Result := false;
          pMensagensErro(E.Message, 'TfrmOrdProAtualizaPrecos.fGravarAlteracoes');
        End;
      End;

      If Result Then
        If(Not VS_blnPreAltViaTrigger) Then
          Result := fGravaPreAlt(cdsGerMat.FieldByName('ITE_CODITE').AsString,

          cdsGerMat.FieldByName('ITE_PRECUS').AsFloat, cdsGerMat.FieldByName('NEW_CUSLIQ').AsFloat,

          IIF(strTabelasPreco[1] = 'N', 0, cdsGerMat.FieldByName('ITE_PREVE1').AsFloat),
          IIF(strTabelasPreco[1] = 'N', 0, cdsGerMat.FieldByName('NEW_PREVE1').AsFloat),
          IIF(strTabelasPreco[1] = 'N', 0, cdsGerMat.FieldByName('ITE_MARBR1').AsFloat),
          IIF(strTabelasPreco[1] = 'N', 0, cdsGerMat.FieldByName('NEW_MARBR1').AsFloat),

          IIF(strTabelasPreco[2] = 'N', 0, cdsGerMat.FieldByName('ITE_PREVE2').AsFloat),
          IIF(strTabelasPreco[2] = 'N', 0, cdsGerMat.FieldByName('NEW_PREVE2').AsFloat),
          IIF(strTabelasPreco[2] = 'N', 0, cdsGerMat.FieldByName('ITE_MARBR2').AsFloat),
          IIF(strTabelasPreco[2] = 'N', 0, cdsGerMat.FieldByName('NEW_MARBR2').AsFloat),

          IIF(strTabelasPreco[3] = 'N', 0, cdsGerMat.FieldByName('ITE_PREVE3').AsFloat),
          IIF(strTabelasPreco[3] = 'N', 0, cdsGerMat.FieldByName('NEW_PREVE3').AsFloat),
          IIF(strTabelasPreco[3] = 'N', 0, cdsGerMat.FieldByName('ITE_MARBR3').AsFloat),
          IIF(strTabelasPreco[3] = 'N', 0, cdsGerMat.FieldByName('NEW_MARBR3').AsFloat),

          IIF(strTabelasPreco[4] = 'N', 0, cdsGerMat.FieldByName('ITE_PREVE4').AsFloat),
          IIF(strTabelasPreco[4] = 'N', 0, cdsGerMat.FieldByName('NEW_PREVE4').AsFloat),
          IIF(strTabelasPreco[4] = 'N', 0, cdsGerMat.FieldByName('ITE_MARBR4').AsFloat),
          IIF(strTabelasPreco[4] = 'N', 0, cdsGerMat.FieldByName('NEW_MARBR4').AsFloat),

          IIF(strTabelasPreco[5] = 'N', 0, cdsGerMat.FieldByName('ITE_PREVE5').AsFloat),
          IIF(strTabelasPreco[5] = 'N', 0, cdsGerMat.FieldByName('NEW_PREVE5').AsFloat),
          IIF(strTabelasPreco[5] = 'N', 0, cdsGerMat.FieldByName('ITE_MARBR5').AsFloat),
          IIF(strTabelasPreco[5] = 'N', 0, cdsGerMat.FieldByName('NEW_MARBR5').AsFloat),

          IIF(strTabelasPreco[6] = 'N', 0, cdsGerMat.FieldByName('ITE_PREVE6').AsFloat),
          IIF(strTabelasPreco[6] = 'N', 0, cdsGerMat.FieldByName('NEW_PREVE6').AsFloat),
          IIF(strTabelasPreco[6] = 'N', 0, cdsGerMat.FieldByName('ITE_MARBR6').AsFloat),
          IIF(strTabelasPreco[6] = 'N', 0, cdsGerMat.FieldByName('NEW_MARBR6').AsFloat),

          IIF(strTabelasPreco[7] = 'N', 0, cdsGerMat.FieldByName('ITE_PREVE7').AsFloat),
          IIF(strTabelasPreco[7] = 'N', 0, cdsGerMat.FieldByName('NEW_PREVE7').AsFloat),
          IIF(strTabelasPreco[7] = 'N', 0, cdsGerMat.FieldByName('ITE_MARBR7').AsFloat),
          IIF(strTabelasPreco[7] = 'N', 0, cdsGerMat.FieldByName('NEW_MARBR7').AsFloat),

          cdsGerMat.FieldByName('ITE_PRECOM').AsFloat, cdsGerMat.FieldByName('NEW_PRECUS').AsFloat,

          'TOrdProAtualizaPrecos.fGravarAlteracoes',

          Nil,
          '',
          strLoginUsuarioLogado);

      pConfirmaTransacao(Result);
      cdsGerMat.Next;

      If Assigned(cxProgress) Then
        cxProgress.Position := cxProgress.Position + 1;

      If (cdsGerMat.RecNo Mod 50) = 0 Then
        Application.ProcessMessages;

    End;

  Finally
    pConfirmaTransacao(Result);

    FreeAndNil(qryUpdate);

    cdsGerMat.AfterScroll := LAfterScroll;
    cdsGerMat.EnableControls;
    cdsGerMat.Filtered := false;
    cdsGerMat.Filter := '';
    strAgrupadorPreAlt := '';
  End;

end;

procedure TOrdProAtualizaPrecos.pConfirmaTransacao(blnCommit: Boolean);
begin
  If blnCommit Then
    fCommit
  Else
    fRollBack;
End;


procedure TOrdProAtualizaPrecos.pMarcar(opcao: TTipoMarcar);
begin
    If cdsGerMat.FieldByName('NEW_CUSLIQ').AsFloat = cdsGerMat.FieldByName('ITE_PRECUS').AsFloat Then
      Exit;

    cdsGerMat.Edit;
    Case opcao Of
      opcMenor:
        cdsGerMat.FieldByName('MARCA').AsInteger :=
          IIF(cdsGerMat.FieldByName('NEW_CUSLIQ').AsFloat > cdsGerMat.FieldByName('ITE_PRECUS').AsFloat, 0, 1);
      opcMaior:
        cdsGerMat.FieldByName('MARCA').AsInteger :=
          IIF(cdsGerMat.FieldByName('NEW_CUSLIQ').AsFloat > cdsGerMat.FieldByName('ITE_PRECUS').AsFloat, 1, 0);
      opcAlterado:
        cdsGerMat.FieldByName('MARCA').AsInteger := 1;
      opcDesmarcar:
        cdsGerMat.FieldByName('MARCA').AsInteger := 0;
      opcInverter:
        cdsGerMat.FieldByName('MARCA').AsInteger := IIF(cdsGerMat.FieldByName('MARCA').AsInteger = 0, 1, 0);
    End;

    cdsGerMat.Post;
end;

end.
