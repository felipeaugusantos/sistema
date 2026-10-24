unit untCfgTel;

interface

uses Vcl.DBGrids, System.Classes, Datasnap.DBClient, untcxGridDBColumnHelper,
  UniClientDataSet, cxGridCitel, cxGrid, DBGridCitel, Vcl.Controls,
  cxGridDBTableView, cxCheckListBox, EditFocus, Vcl.StdCtrls, Vcl.ExtCtrls, ComboBoxFocus,
  cxImageComboBox, cxEdit, cxCheckBox, Vcl.Graphics, untCorGrid, cxGraphics, Data.DB;

type

  TRecColGrid = record
    strFormName: String;
    strCodEmp: String;
    strFieldName: String;
    strCaption: String;
    intWidth: Integer;
    blnVisible: Boolean;
    Alignment: TAlignment;
    intIndex: Integer;
    blnCheckbox: Boolean;
    blnInterno: Boolean;
  End;

  TArrayOfCol = Array Of TRecColGrid;

  ICfgTela = Interface
    ['{DE4EA001-2340-4D57-B006-B75CF7B51DBE}']
    function GetArrColsOri: TArrayOfCol;
    procedure SetArrColsOri(AValue: TArrayOfCol);
    function GetIntUtiWidthGrid: Integer;
    procedure SetIntUtiWidthGrid(AValue: Integer);
    function GetNomeFormulario: String;
    function GetCodEmp: String;
    function GetTamanhoFontePadrao: Integer;
    procedure SetNomeFormulario(const AValue: string);
    function fConverteGridArrayCol(Const dbgDados: TcxGridDBTableViewCitel): TArrayOfCol;
    procedure pSetarEstado(Const dbgDados: TcxGridDBTableViewCitel);
    procedure pSetarEstadoPadrao(Const dbgDados: TcxGridDBTableViewCitel);
    procedure pAtualizarColunasGrid(Const dbgDados: TcxGridDBTableViewCitel; const arrCol: TArrayOfCol);
    procedure pSetarEstadoDados(Const dbgDados: TcxGridDBTableViewCitel);
    procedure pIniciar(Const dbgDados: TcxGridCitel;  Const dbgDadosView: TcxGridDBTableViewCitel;
      strDescri: String = ''; strNomObj: String = '');
    procedure pConfigurarGrid(Const dbgDadosView: TcxGridDBTableViewCitel);
    procedure pGravarDadosNoBanco(Const dbgDados: TcxGridDBTableViewCitel; Const cdsOrd: TUniClientDataSet);
    procedure pSetarUltimosDadosCarregados(Const dbgDados: TcxGridDBTableViewCitel);
    procedure pSetarPadrao(Const dbgDados: TcxGridDBTableViewCitel);
    procedure pDefinirOrdenacao(Const DataSet: TDataSet);
    procedure pCarregaOrd(Const cdsColOrd: TUniClientDataSet; Const strNomeGrid: String);
    procedure pOrdenaColunas(Const DataSet: TDataSet; Const cdsColOrd: TUniClientDataSet);
    function GetBlnUsu: Boolean;
    function GetStrDecri: String;
    procedure SetStrDescri(const AValue: String);
    function GetStrNomObj: String;
    procedure SetNomObj(const AValue: String);
    procedure pRestaurarPadrao(Const dbgDados: TcxGridDBTableViewCitel);
    procedure SetBlnUsu(const Value: Boolean);

    property arrColsOri: TArrayOfCol read GetArrColsOri write SetArrColsOri;
    property intUtiWidthGrid: Integer read GetIntUtiWidthGrid
      write SetIntUtiWidthGrid;
    property NomeFormulario: String read GetNomeFormulario write SetNomeFormulario;
    property Empresa: String read GetCodEmp;
    property TamanhoFontePadrao: Integer read GetTamanhoFontePadrao;
    property CfgPorUsuario: Boolean read GetBlnUsu write SetBlnUsu;
    property strDescricao: String read GetStrDecri write SetStrDescri;
    property NomeObjeto: String read GetStrNomObj write SetNomObj;
  End;

  TCfgTela = Class(TInterfacedObject, ICfgTela)
  private
    FNomeFormulario: String;
    FCodEmp: String;
    FarrColsDad: TArrayOfCol;
    FintUtiWidthGrid: Integer;
    FarrColsOri: TArrayOfCol;
    FarrCols: TArrayOfCol;
    FTamanhoFontePadrao: Integer;
    FBlnCfgUsu: Boolean;
    FstrDescri: String;
    FNomeObjeto: String;

    function GetArrColsOri: TArrayOfCol; virtual;
    procedure SetArrColsOri(AValue: TArrayOfCol); virtual;
    function GetIntUtiWidthGrid: Integer; virtual;
    procedure SetIntUtiWidthGrid(AValue: Integer); virtual;
    function GetNomeFormulario: String; virtual;
    function GetCodEmp: String; virtual;
    procedure SetNomeFormulario(const AValue: string); virtual;

    function fConverteGridArrayCol(Const dbgDados: TcxGridDBTableViewCitel): TArrayOfCol; virtual;
    procedure pSetarEstado(Const dbgDados: TcxGridDBTableViewCitel); virtual;
    procedure pSetarEstadoPadrao(Const dbgDados: TcxGridDBTableViewCitel); virtual;
    procedure pSetarEstadoDados(Const dbgDados: TcxGridDBTableViewCitel); virtual;
    function GetTamanhoFontePadrao: Integer;
    procedure pDefinirOrdenacao(Const DataSet: TDataSet); overload; virtual;
    procedure pDefinirOrdenacao(Const DataSet: TDataSet; Const strNomeGrid: String); overload; virtual;
    function GetBlnUsu: Boolean;
    function GetStrDecri: String;
    procedure SetStrDescri(const AValue: String);
    function GetStrNomObj: String;
    procedure SetNomObj(const AValue: String);
    procedure pExcluirDadosColCnf;
    procedure pInserirDadosColCnf;
    procedure pExcluirDadosOrdCol;
    procedure pInserirDadosOrdCol(cdsOrd: TUniClientDataSet);
    procedure SetBlnUsu(const Value: Boolean);
    function fRetornaVisibilidadeColuna(const blnVisible: Boolean; strColName: String; blnCampoInterno: Boolean): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure pIniciar(Const dbgDados: TcxGridCitel;  Const dbgDadosView: TcxGridDBTableViewCitel;
      strDescri: String = ''; strNomObj: String = ''); virtual;
    procedure pConfigurarGrid(Const dbgDadosView: TcxGridDBTableViewCitel); overload; virtual;
    procedure pConfigurarGrid(Const dbgDadosView: TcxGridDBTableViewCitel;
                              Const strDescricao: String;
                              cds: TUniClientDataSet;
                              var intRecNo: Integer;
                              blnAlterarVisibilidade: Boolean = True); overload; virtual;
    procedure pGravarDadosNoBanco(Const dbgDados: TcxGridDBTableViewCitel; Const cdsOrd: TUniClientDataSet); overload; virtual;
    procedure pGravarDadosNoBanco(dbTableView: TcxGridDBTableViewCitel; strDescricao: String; cds: TUniClientDataSet); overload; virtual;
    procedure pSetarUltimosDadosCarregados(Const dbgDados: TcxGridDBTableViewCitel); overload; virtual;
    procedure pSetarPadrao(Const dbgDados: TcxGridDBTableViewCitel);
      overload; virtual;
    procedure pCarregaOrd(Const cdsColOrd: TUniClientDataSet; Const strNomeGrid: String); virtual;
    procedure pAtualizarColunasGrid(Const dbgDados: TcxGridDBTableViewCitel; const arrCol: TArrayOfCol); virtual;
    procedure pOrdenaColunas(DataSet: TDataSet; strNomGrd: String); overload;
    procedure pOrdenaColunas(Const DataSet: TDataSet; Const cdsColOrd: TUniClientDataSet); overload;
    procedure pRestaurarPadrao(Const dbgDados: TcxGridDBTableViewCitel); virtual;

    property arrColsOri: TArrayOfCol read GetArrColsOri write SetArrColsOri;
    property intUtiWidthGrid: Integer read GetIntUtiWidthGrid write SetIntUtiWidthGrid;
    property NomeFormulario: String read GetNomeFormulario write SetNomeFormulario;
    property Empresa: String read GetCodEmp;
    property TamanhoFontePadrao: Integer read GetTamanhoFontePadrao;
    property CfgPorUsuario: Boolean read GetBlnUsu write SetBlnUsu;
    property strDescricao: String read GetStrDecri write SetStrDescri;
    property NomeObjeto: String read GetStrNomObj write SetNomObj;
  End;

  ICfgSug = Interface['{5A32D8D5-B1A8-479E-A2F5-ABC9DC48C88E}']
    function GetCodEmp: String;
    function GetNomeFormulario: String;
    function GetTamanhoFonte: Integer;
    procedure SetNomeFormulario(const Value: String);
    function GetCorFonteLinha: TColor;
    function GetCorFundoLinha: TColor;
    function GetCorFonteLinhaSelecionada: TColor;
    function GetCorFundoLinhaSelecionada: TColor;
    procedure SetCorFonteLinha(const Value: TColor);
    procedure SetCorFundoLinha(const Value: TColor);
    procedure SetCorFonteLinhaSelecionada(const Value: TColor);
    procedure SetCorFundoLinhaSelecionada(const Value: TColor);
    function GetBlnCfgusu: Boolean;
    procedure SetBlnCfgUsu(const Value: Boolean);

    function fCarregarInfObjeto(const strNome: String): string;

    procedure pCarregarCoresGrid(const nomeGrid: string);
    procedure pGravarCoresGrid(const nomeGrid: String);
    procedure pRestaurarCoresPadraoGrid;
    procedure pGravarFonteGrid(const TamFonte: Integer; strDescricao: String = '');
    procedure pGravarSugestoesNoBanco(strNome, strValor: String);
    procedure pCarregarTamanhoFonteObj(const strDescricao: String = '');

    property NomeFormulario: String read GetNomeFormulario write SetNomeFormulario;
    property Empresa: String read GetCodEmp;
    property TamanhoFonte: Integer read GetTamanhoFonte;
    property CorFonteLinha: TColor read GetCorFonteLinha write SetCorFonteLinha;
    property CorFundoLinha: TColor read GetCorFundoLinha write SetCorFundoLinha;
    property CorFonteLinhaSelecionada: TColor read GetCorFonteLinhaSelecionada write SetCorFonteLinhaSelecionada;
    property CorFundoLinhaSelecionada: TColor read GetCorFundoLinhaSelecionada write SetCorFundoLinhaSelecionada;
  End;

  TCfGSug = Class(TInterfacedObject, ICfgSug)
  private
    FNomeFormulario: String;
    FCodEmp: String;
    FTamanhoFonte: Integer;
    FTamanhoFontePadrao: Integer;
    FBlnCfgUsu: Boolean;

    FCorFonteLinha: TColor;
    FCorFundoLinha: TColor;
    FCorFonteLinhaSel: TColor;
    FCorFundoLinhaSel: TColor;
    FCorFonteLinhaPadrao: TColor;
    FCorFundoLinhaPadrao: TColor;
    FCorFonteLinhaSelPadrao: TColor;
    FCorFundoLinhaSelPadrao: TColor;

    FstrSQLCoresPadrao: String;

    function GetCodEmp: String; virtual;
    function GetNomeFormulario: String; virtual;
    function GetTamanhoFonte: Integer; virtual;
    procedure SetNomeFormulario(const Value: String); virtual;
    function GetCorFonteLinha: TColor; virtual;
    function GetCorFundoLinha: TColor; virtual;
    function GetCorFonteLinhaSelecionada: TColor; virtual;
    function GetCorFundoLinhaSelecionada: TColor; virtual;
    procedure SetCorFonteLinha(const Value: TColor); virtual;
    procedure SetCorFundoLinha(const Value: TColor); virtual;
    procedure SetCorFonteLinhaSelecionada(const Value: TColor); virtual;
    procedure SetCorFundoLinhaSelecionada(const Value: TColor); virtual;
    function GetBlnCfgusu: Boolean;
    procedure SetBlnCfgUsu(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    function fCarregarInfObjeto(const strNome: String): string;
    procedure pGravarSugestoesNoBanco(strNome, strValor: String); virtual;
    procedure pCarregarCoresGrid(const nomeGrid: string); virtual;
    procedure pGravarCoresGrid(const nomeGrid: String); virtual;
    procedure pRestaurarCoresPadraoGrid; virtual;
    procedure pGravarFonteGrid(const TamFonte: Integer; strDescricao: String = ''); virtual;
    procedure pCarregarTamanhoFonteObj(const strDescricao: String = '');

    property NomeFormulario: String read GetNomeFormulario write SetNomeFormulario;
    property Empresa: String read GetCodEmp;
    property TamanhoFonte: Integer read GetTamanhoFonte;
    property CorFonteLinha: TColor read GetCorFonteLinha write SetCorFonteLinha;
    property CorFundoLinha: TColor read GetCorFundoLinha write SetCorFundoLinha;
    property CorFonteLinhaSelecionada: TColor read GetCorFonteLinhaSelecionada write SetCorFonteLinhaSelecionada;
    property CorFundoLinhaSelecionada: TColor read GetCorFundoLinhaSelecionada write SetCorFundoLinhaSelecionada;
    property BlnCfgUsu: Boolean read GetBlnCfgusu write SetBlnCfgUsu;
  End;

  TCfGSugImpulsionadorVendasCRM = Class(TCfGSug)
  private
    FCorFonteColunaQtdIte: TColor;
    FCorFundoColunaQtdIte: TColor;
    FCorFonteColunaQtdItePadrao: TColor;
    FCorFundoColunaQtdItePadrao: TColor;
    FCorFonteColunaUniTar: TColor;
    FCorFundoColunaUniTar: TColor;
    FCorFonteColunaUniTarPadrao: TColor;
    FCorFundoColunaUniTarPadrao: TColor;
    FstrSQLCoresPadrao : String;

    function GetCorFonteColunaQtdIte: TColor;
    function GetCorFonteColunaUniTar: TColor;
    function GetCorFundoColunaQtdIte: TColor;
    function GetCorFundoColunaUniTar: TColor;
    procedure SetCorFonteColunaQtdIte(const Value: TColor);
    procedure SetCorFundoColunaQtdIte(const Value: TColor);
    procedure SetCorFundoColunaUniTar(const Value: TColor);
    procedure SetFonteColunaUniTar(const Value: TColor);
  public
    constructor Create;

    procedure pCarregarCoresGrid(const nomeGrid: string); override;
    procedure pRestaurarCoresPadraoGrid; override;
    procedure pGravarCoresGrid(const nomeGrid: String); override;
    property CorFonteColunaQtdIte: TColor read GetCorFonteColunaQtdIte write SetCorFonteColunaQtdIte;
    property CorFundoColunaQtdIte: TColor read GetCorFundoColunaQtdIte write SetCorFundoColunaQtdIte;
    property CorFonteColunaUniTar: TColor read GetCorFonteColunaUniTar write SetFonteColunaUniTar;
    property CorFundoColunaUniTar: TColor read GetCorFundoColunaUniTar write SetCorFundoColunaUniTar;
  End;

  TCfgTelaImpulsionadorVendasCRM = Class(TCfgTela)
  private
    FSugestao: TCfGSugImpulsionadorVendasCRM;

    function GetSugestao: TCfGSugImpulsionadorVendasCRM; virtual;
    procedure SetSugestao(AValue: TCfGSugImpulsionadorVendasCRM); virtual;
    procedure pVerificaNovasColunasAdicionadas(const dbgDadosView: TcxGridDBTableViewCitel);
    procedure pReordenaColunas(const dbgDadosView: TcxGridDBTableViewCitel);
  public
    constructor Create;
    destructor Destroy; override;

    class procedure pFormatarCelula(ACanvas: TcxCanvas;
      ACorFonte, ACorFundo: TColor; ANegrito: Boolean);
    procedure pConfigurarGrid(Const dbgDadosView: TcxGridDBTableViewCitel); override;

    property Sugestao: TCfGSugImpulsionadorVendasCRM read GetSugestao write SetSugestao;
  End;

  TCfgTelaConsultaLeadCRM = Class(TCfgTela)
  private
    function fConverteGridArrayCol(Const dbgDados: TcxGridDBTableViewCitel): TArrayOfCol; override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure pConfigurarGrid(Const dbgDadosView: TcxGridDBTableViewCitel);override;
    procedure pGravarDadosNoBanco(Const dbgDados: TcxGridDBTableViewCitel; Const cdsOrd: TUniClientDataSet); override;
  End;

  TCfgTelaConsultaOcorrenciaCRM = Class(TCfgTela)
  private
    FSugestao : TCfGSug;
    FTip_Fc: String;
    function GetSugestao: TCfGSug;
    procedure SetSugestao(const AValue: TCfGSug);
    function GetTip_FC: String;
    procedure SetTip_FC(const Value: String);
    function GetBlnUsu: Boolean;

    procedure pSetarColunasAgeCalendario(dbgDadosView: TcxGridDBTableViewCitel; strDescri: String);
    procedure pSetarColunasPadraoAgeCalendario(dbgDadosView: TcxGridDBTableViewCitel);
    function fVerificaExisteCfg: Boolean;
    procedure SetBlnUsu(value: Boolean);
    function fConverteGridArrayCol(Const dbgDados: TcxGridDBTableViewCitel): TArrayOfCol; override;
    function fVerificaCampoInterno(const strNomeCampo: String): Boolean;
  public
    constructor Create(strTip_FC: String);
    destructor Destroy; override;

    procedure pConfigurarGrid(Const dbgDadosView: TcxGridDBTableViewCitel;
                              Const strDescricao: String;
                              cds: TUniClientDataSet;
                              var intRecNo: Integer;
                              blnAlterarVisibilidade: Boolean = True); override;
    procedure pIniciar(Const dbgDados: TcxGridCitel;  Const dbgDadosView: TcxGridDBTableViewCitel;
      strDescri: String = ''; strNomObj: String = ''); override;
    procedure pRestaurarPadrao(Const dbgDados: TcxGridDBTableViewCitel); override;

    property Sugestao: TCfGSug read GetSugestao write SetSugestao;
    property strTip_Fc: String read GetTip_FC write SetTip_FC;
    property CfgPorUsuario: Boolean read GetBlnUsu write SetBlnUsu;
  End;

implementation

uses untFuncoesSimples, Uni, SysUtils;

{ TCfgTela }

constructor TCfgTela.Create;
Begin
  inherited;

  FCodEmp := VS_strCodEmp;
  FTamanhoFontePadrao := 8;
  FBlnCfgUsu := True;

End;

destructor TCfgTela.Destroy;
Begin
  inherited;

End;

procedure TCfgTela.pSetarEstado(const dbgDados: TcxGridDBTableViewCitel);
Begin
  SetLength(FarrCols, 0);
  FarrCols := fConverteGridArrayCol(dbgDados);
End;

procedure TCfgTela.pSetarEstadoDados(const dbgDados: TcxGridDBTableViewCitel);
Begin
  SetLength(FarrColsDad, 0);
  FarrColsDad := fConverteGridArrayCol(dbgDados);
End;

procedure TCfgTela.pSetarEstadoPadrao(const dbgDados: TcxGridDBTableViewCitel);
Begin
  SetLength(FarrColsOri, 0);
  FarrColsOri := fConverteGridArrayCol(dbgDados);
End;

function TCfgTela.fConverteGridArrayCol(const dbgDados: TcxGridDBTableViewCitel): TArrayOfCol;
var
  intCnt: Integer;
  arrCols: TArrayOfCol;
Begin
  SetLength(arrCols, 0);
  For intCnt := 0 To dbgDados.ColumnCount - 1 Do
  Begin
    SetLength(arrCols, Length(arrCols) + 1);
    arrCols[Length(arrCols) - 1].strFormName := FNomeFormulario;
    arrCols[Length(arrCols) - 1].strCodEmp := FCodEmp;
    arrCols[Length(arrCols) - 1].intIndex := dbgDados.Columns[intCnt].Index;
    arrCols[Length(arrCols) - 1].strFieldName := dbgDados.Columns[intCnt].DataBinding.FieldName;
    arrCols[Length(arrCols) - 1].strCaption := dbgDados.Columns[intCnt].Caption;
    arrCols[Length(arrCols) - 1].intWidth := dbgDados.Columns[intCnt].Width;
    arrCols[Length(arrCols) - 1].blnVisible := dbgDados.Columns[intCnt].Visible;
    arrCols[Length(arrCols) - 1].blnInterno := False;

    If dbgDados.Columns[intCnt].PropertiesClass = TcxCheckBoxProperties Then
    Begin
      arrCols[Length(arrCols) - 1].blnCheckbox := True;
    End;

  End;

  Result := arrCols;
End;

function TCfgTela.GetArrColsOri: TArrayOfCol;
Begin
  Result := FarrColsOri;
End;

function TCfgTela.GetBlnUsu: Boolean;
begin
  Result := FBlnCfgUsu;
end;

function TCfgTela.GetCodEmp: String;
Begin
  Result := FCodEmp;
End;

function TCfgTela.GetIntUtiWidthGrid: Integer;
Begin
  Result := FintUtiWidthGrid;
End;

function TCfgTela.GetNomeFormulario: String;
Begin
  Result := FNomeFormulario;
End;

function TCfgTela.GetStrDecri: String;
begin
  Result := FstrDescri;
end;

function TCfgTela.GetStrNomObj: String;
begin
  Result := FNomeObjeto;
end;

function TCfgTela.GetTamanhoFontePadrao: Integer;
Begin
  Result := FTamanhoFontePadrao;
End;

procedure TCfgTela.pDefinirOrdenacao(Const DataSet: TDataSet);
var
  qryTmp: TUniQuery;
  cdsOrd: TUniClientDataSet;
  strFields: String;
  strDescFields: String;
  Index: TIndexDef;
Begin
  cdsOrd := TUniClientDataSet( DataSet );
  qryTmp := fCriaQuery;
  Try
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM ORDCOL          ');
    qryTmp.SQL.Add(' WHERE ORD_NOMFOR = :NOMFOR   ');
    qryTmp.SQL.Add('   AND ORD_CODEMP = :CODEMP   ');
    If FBlnCfgUsu Then
      qryTmp.SQL.Add('   AND ORD_CODOPE = :CODOPE   ');
    qryTmp.SQL.Add(' ORDER BY ORD_ORDCAM ');

    qryTmp.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryTmp.ParamByName('CODEMP').AsString := FCodEmp;
    If FBlnCfgUsu Then
      qryTmp.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    qryTmp.Open;

    cdsOrd.IndexDefs.Clear;
    cdsOrd.IndexFieldNames := '';
    cdsOrd.IndexName := '';

    if not qryTmp.isEmpty then
    Begin

      qryTmp.first;
      While not qryTmp.eof do
      Begin
        if qryTmp.FieldByName('ORD_ORDDSC').AsString = 'S' then
        Begin
          if fEmptyStr(strDescFields) then
            strDescFields := qryTmp.FieldByName('ORD_ORDNAM').AsString
          else
            strDescFields := strFields + ';' + qryTmp.FieldByName('ORD_ORDNAM').AsString ;
        End;

        if fEmptyStr(strFields) then
          strFields := qryTmp.FieldByName('ORD_ORDNAM').AsString
        else
          strFields := strFields + ';' + qryTmp.FieldByName('ORD_ORDNAM').AsString ;

        qryTmp.Next;
      End;

      Index := cdsOrd.IndexDefs.AddIndexDef;
      Index.Name   := 'IDX_001';
      Index.Fields := strFields;
      Index.DescFields := strDescFields;

      cdsOrd.IndexName := 'IDX_001';
    End;

  Finally
    FreeAndNil(qryTmp);
  End;
End;

procedure TCfgTela.pDefinirOrdenacao(const DataSet: TDataSet; const strNomeGrid: String);
var
  qryTmp: TUniQuery;
  cdsOrd: TUniClientDataSet;
  strFields: String;
  strDescFields: String;
  Index: TIndexDef;
Begin

  qryTmp := fCriaQuery;

  Try
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM ORDCOL          ');
    qryTmp.SQL.Add(' WHERE ORD_NOMFOR = :NOMFOR   ');
    qryTmp.SQL.Add('   AND ORD_CODEMP = :CODEMP   ');
    If FBlnCfgUsu Then
      qryTmp.SQL.Add('   AND ORD_CODOPE = :CODOPE   ');
    If Not fEmptyStr(strNomeGrid) Then
      qryTmp.SQL.Add('   AND ORD_NOMGRD = :NOMGRD   ');
    qryTmp.SQL.Add(' ORDER BY ORD_ORDCAM ');

    qryTmp.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryTmp.ParamByName('CODEMP').AsString := FCodEmp;
    If FBlnCfgUsu Then
      qryTmp.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    If Not fEmptyStr(strNomeGrid) Then
      qryTmp.ParamByName('NOMGRD').AsString := strNomeGrid;
    qryTmp.Open;

    cdsOrd := TUniClientDataSet( DataSet );
    cdsOrd.IndexDefs.Clear;
    cdsOrd.IndexFieldNames := '';
    cdsOrd.IndexName := '';

    if not qryTmp.isEmpty then
    Begin

      qryTmp.first;
      While not qryTmp.eof do
      Begin
        if qryTmp.FieldByName('ORD_ORDDSC').AsString = 'S' then
        Begin
          if fEmptyStr(strDescFields) then
            strDescFields := qryTmp.FieldByName('ORD_ORDNAM').AsString
          else
            strDescFields := strFields + ';' + qryTmp.FieldByName('ORD_ORDNAM').AsString ;
        End;

        strFields := IIF(fEmptyStr(strFields),
                     qryTmp.FieldByName('ORD_ORDNAM').AsString,
                     strFields + ';' + qryTmp.FieldByName('ORD_ORDNAM').AsString);

        qryTmp.Next;
      End;

      Index :=cdsOrd.IndexDefs.AddIndexDef;
      Index.Name   := 'IDX_001';
      Index.Fields := strFields;
      Index.DescFields := strDescFields;

      cdsOrd.IndexName := 'IDX_001';
    End;

  Finally
    FreeAndNil(qryTmp);
  End;
End;

procedure TCfgTela.pGravarDadosNoBanco(dbTableView: TcxGridDBTableViewCitel;
  strDescricao: String; cds: TUniClientDataSet);
begin
  fGetFuncoesCxGrid.pSalvarView(dbTableView, strDescricao, cds);
end;

procedure TCfgTela.pExcluirDadosColCnf;
Var
  qryCol: TUniQuery;
begin
  qryCol := fCriaQuery;
  Try
    qryCol.DisableControls;
    qryCol.Close;
    qryCol.SQL.Clear;
    qryCol.SQL.Add('DELETE ' +
                   '  FROM COLCNF ' +
                   ' WHERE COL_NOMFOR = :NOMFOR ' +
                   '   AND COL_CODEMP = :CODEMP ');
    If FBlnCfgUsu Then
      qryCol.SQL.Add( '   AND COL_CODOPE = :CODOPE ');
    If Not fEmptyStr(FNomeObjeto) Then
      qryCol.SQL.Add( '   AND COL_NOMGRD = :NOMGRD ');

    qryCol.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryCol.ParamByName('CODEMP').AsString := FCodEmp;
    If FBlnCfgUsu Then
      qryCol.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    If Not fEmptyStr(FNomeObjeto) Then
      qryCol.ParamByName('NOMGRD').AsString := FNomeObjeto;
    qryCol.ExecSQL;
  Finally
    FreeAndNil(qryCol);
  End;
end;

procedure TCfgTela.pInserirDadosColCnf;
Var
  qryCol: TUniQuery;
  intCnt: Integer;
  intIndex: Integer;
  blnVisivel: Boolean;
begin
  qryCol := fCriaQuery;
  Try
    qryCol.Close;
    qryCol.SQL.Clear;
    qryCol.SQL.Add('SELECT * ' +
                   '  FROM COLCNF ' +
                   ' WHERE COL_NOMFOR = :NOMFOR ' +
                   '   AND COL_CODEMP = :CODEMP');
    If FBlnCfgUsu Then
      qryCol.SQL.Add( '   AND COL_CODOPE = :CODOPE ');
    If Not fEmptyStr(FNomeObjeto) Then
      qryCol.SQL.Add( '   AND COL_NOMGRD = :NOMGRD ');

    qryCol.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryCol.ParamByName('CODEMP').AsString := FCodEmp;
    If FBlnCfgUsu Then
      qryCol.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    If Not fEmptyStr(FNomeObjeto) Then
      qryCol.ParamByName('NOMGRD').AsString := FNomeObjeto;
    qryCol.Open;

    intIndex := 0;

    For intCnt := Low(FarrCols) To High(FarrCols) Do
    Begin
      qryCol.Append;
      qryCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COLCNF', FCodEmp);
      qryCol.FieldByName('COL_NOMFOR').AsString := FNomeFormulario;
      qryCol.FieldByName('COL_CODEMP').AsString := FCodEmp;
      qryCol.FieldByName('COL_COLNAM').AsString := FarrCols[intCnt].strFieldName;
      qryCol.FieldByName('COL_COLCAP').AsString := FarrCols[intCnt].strCaption;
      qryCol.FieldByName('COL_COLORD').AsInteger := intIndex;
      qryCol.FieldByName('COL_COLTAM').AsInteger := FarrCols[intCnt].intWidth;
      qryCol.FieldByName('COL_COLTAM').AsInteger := FarrCols[intCnt].intWidth;

      blnVisivel := fRetornaVisibilidadeColuna(FarrCols[intCnt].blnVisible,
                                               FarrCols[intCnt].strFieldName,
                                               FarrCols[intCnt].blnInterno);

      qryCol.FieldByName('COL_COLEXI').AsString := IIF(blnVisivel, 'S', 'N');
      qryCol.FieldByName('COL_CODOPE').AsString := strLoginUsuarioLogado;
      If Not fEmptyStr(FNomeObjeto) Then
        qryCol.FieldByName('COL_NOMGRD').AsString := FNomeObjeto;
      qryCol.FieldByName('COL_CAMINT').AsString := IIF(FarrCols[intCnt].blnInterno, 'S', 'N');
      qryCol.Post;

      Inc(intIndex);
    End;
  Finally
    FreeAndNil(qryCol);
  End;
end;

function TCfgTela.fRetornaVisibilidadeColuna(const blnVisible: Boolean; strColName: String; blnCampoInterno: Boolean): Boolean;
begin
  If fEmptyStr(strColName) Then
    Exit(False);

  If blnCampoInterno Then
    Exit(False);

  Result := blnVisible;
end;

procedure TCfgTela.pExcluirDadosOrdCol;
Var
  qryOrd: TUniQuery;
begin
  qryOrd := fCriaQuery;
  Try
    qryOrd.DisableControls;
    qryOrd.Close;
    qryOrd.SQL.Clear;
    qryOrd.SQL.Add('DELETE                      ' +
                   '  FROM ORDCOL               ' +
                   ' WHERE ORD_NOMFOR = :NOMFOR ' +
                   '   AND ORD_CODEMP = :CODEMP ');
    If FBlnCfgUsu Then
      qryOrd.SQL.Add( '   AND ORD_CODOPE = :CODOPE ');
    If Not fEmptyStr(FNomeObjeto) Then
      qryOrd.SQL.Add( '   AND ORD_NOMGRD = :NOMGRD ');

    qryOrd.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryOrd.ParamByName('CODEMP').AsString := FCodEmp;
    If FBlnCfgUsu Then
      qryOrd.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    If Not fEmptyStr(FNomeObjeto) Then
      qryOrd.ParamByName('NOMGRD').AsString := FNomeObjeto;

    qryOrd.ExecSQL;
  Finally
    FreeAndNil(qryOrd);
  End;
end;

procedure TCfgTela.pInserirDadosOrdCol(cdsOrd: TUniClientDataSet);
Var
  qryOrd: TUniQuery;
begin
  qryOrd := fCriaQuery;
  Try
    qryOrd.Close;
    qryOrd.SQL.Clear;
    qryOrd.SQL.Add('SELECT * FROM ORDCOL ' +
                   ' WHERE ORD_NOMFOR = :NOMFOR ' +
                   '   AND ORD_CODEMP = :CODEMP ');
    If FBlnCfgUsu Then
      qryOrd.SQL.Add( '   AND ORD_CODOPE = :CODOPE ');
    If Not fEmptyStr(FNomeObjeto) Then
      qryOrd.SQL.Add( '   AND ORD_NOMGRD = :NOMGRD ');

    qryOrd.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryOrd.ParamByName('CODEMP').AsString := FCodEmp;
    If FBlnCfgUsu Then
      qryOrd.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    If Not fEmptyStr(FNomeObjeto) Then
      qryOrd.ParamByName('NOMGRD').AsString := FNomeObjeto;
    qryOrd.Open;

    cdsOrd.First;

    While not cdsOrd.Eof do
    Begin
      qryOrd.Append;
      qryOrd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ORDCOL', FCodEmp);
      qryOrd.FieldByName('ORD_NOMFOR').AsString := FNomeFormulario;
      qryOrd.FieldByName('ORD_CODEMP').AsString := FCodEmp;
      qryOrd.FieldByName('ORD_ORDNAM').AsString := cdsOrd.FieldByName('ORDNAM').AsString;
      qryOrd.FieldByName('ORD_ORDCAP').AsString := cdsOrd.FieldByName('ORDCAP').AsString;
      qryOrd.FieldByName('ORD_ORDDSC').AsString := cdsOrd.FieldByName('ORDDSC').AsString;
      qryOrd.FieldByName('ORD_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger;
      qryOrd.FieldByName('ORD_CODOPE').AsString := strLoginUsuarioLogado;
      If Not fEmptyStr(FNomeObjeto) Then
        qryOrd.FieldByName('ORD_NOMGRD').AsString := FNomeObjeto;
      qryOrd.Post;

      cdsOrd.Next;
    End;
  Finally
    FreeAndNil(qryOrd);
  End;
end;

procedure TCfgTela.pConfigurarGrid(const dbgDadosView: TcxGridDBTableViewCitel);
var
  intCnt: Integer;
  qryCol: TUniQuery;
  Coluna: TcxGridDBColumn;
  intIndex: Integer;
  DtaSource: TDataSource;
  SQLSelect: String;
Begin

  pDefinirOrdenacao(dbgDadosView.DataController.DataSource.DataSet);

  SQLSelect := ' SELECT * ' +
               '   FROM COLCNF' +
               '  WHERE COL_NOMFOR = :NOMFOR ' +
               '    AND COL_CODEMP = :CODEMP ';
  If FBlnCfgUsu Then
    SQLSelect := SQLSelect + '  AND COL_CODOPE = :CODOPE ';
  If Not fEmptyStr(FNomeObjeto) Then
    SQLSelect := SQLSelect + '  AND COL_NOMGRD = :NOMGRD ';
  SQLSelect := SQLSelect + '  ORDER BY COL_COLORD ';

  qryCol := fCriaQuery;

  Try
    qryCol.DisableControls;
    qryCol.Close;
    qryCol.SQL.Clear;
    qryCol.SQL.Add(SQLSelect);

    qryCol.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryCol.ParamByName('CODEMP').AsString := FCodEmp;
    If FBlnCfgUsu Then
      qryCol.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    If Not fEmptyStr(FNomeObjeto) Then
      qryCol.ParamByName('NOMGRD').AsString := FNomeObjeto;
    qryCol.Open;

    SetLength(FarrColsDad, 0);

    If Not qryCol.IsEmpty Then
    Begin


      DtaSource := dbgDadosView.DataController.DataSource;
      dbgDadosView.DataController.DataSource := Nil;

      Try
        For intCnt := 0 To dbgDadosView.ColumnCount - 1 Do
          dbgDadosView.Columns[intCnt].Visible := False;

        intIndex := 0;
        intUtiWidthGrid := 0;

        qryCol.First;

        While Not qryCol.Eof Do
        Begin
          Coluna := TcxGridDBColumnHelper.fFindColumnByNameView(dbgDadosView, qryCol.FieldByName('COL_COLNAM').AsString);

          If (Coluna <> Nil) Then
          Begin
            Coluna.Visible := (qryCol.FieldByName('COL_COLEXI').AsString = 'S');
            Coluna.Index := intIndex;

            Coluna.Caption := qryCol.FieldByName('COL_COLCAP').AsString;
            Coluna.Width := qryCol.FieldByName('COL_COLTAM').AsInteger;

            intUtiWidthGrid := intUtiWidthGrid + Coluna.Width;

            SetLength(FarrColsDad, Length(FarrColsDad) + 1);
            FarrColsDad[Length(FarrColsDad) - 1].strFieldName := Coluna.DataBinding.FieldName;
            FarrColsDad[Length(FarrColsDad) - 1].strCaption := Coluna.Caption;
            FarrColsDad[Length(FarrColsDad) - 1].intWidth := Coluna.Width;
            FarrColsDad[Length(FarrColsDad) - 1].blnVisible := Coluna.Visible;
            FarrColsDad[Length(FarrColsDad) - 1].intIndex := Coluna.Index;
            If Coluna.PropertiesClass = TcxCheckBoxProperties Then
              FarrColsDad[Length(FarrColsDad) - 1].blnCheckbox := True;
            FarrColsDad[Length(FarrColsDad) - 1].blnInterno := (qryCol.FieldByName('COL_CAMINT').AsString = 'S');
            intIndex := intIndex + 1;
          End;

          qryCol.Next;
        End;

      Finally
        dbgDadosView.DataController.DataSource := DtaSource;
      End;

    End;

  Finally
    FreeAndNil(qryCol);
  End;
End;

procedure TCfgTela.pGravarDadosNoBanco(Const dbgDados: TcxGridDBTableViewCitel; const cdsOrd: TUniClientDataSet);
Begin
  pSetarEstado(dbgDados);

  fStartTransaction;

  Try
    pExcluirDadosColCnf;
    pInserirDadosColCnf;
    pExcluirDadosOrdCol;
    pInserirDadosOrdCol(cdsOrd);

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TCfgTela.pGravarDadosNoBanco]');
    End;
  End;
End;

procedure TCfgTela.pIniciar(const dbgDados: TcxGridCitel; const dbgDadosView: TcxGridDBTableViewCitel;
  strDescri: String = ''; strNomObj: String = '');
Begin
  FstrDescri := strDescri;
  FNomeObjeto := strNomObj;
  pSetarEstadoPadrao(dbgDadosView);
  pConfigurarGrid(dbgDadosView);
End;

procedure TCfgTela.pOrdenaColunas(DataSet: TDataSet; strNomGrd: String);
const SQLSelect = 'SELECT * FROM ORDCOL      ' +
                  ' WHERE                      ' +
                  '   ORD_CODEMP = :CODEMP     ' +
                  '   AND ORD_NOMFOR = :NOMFOR ' +
                  '   AND ORD_CODOPE = :CODOPE ' +
                  '   AND ORD_NOMGRD = :NOMGRD ' +
                  ' ORDER BY ORD_ORDCAM ';
var
  cdsOrd, cdsBkp: TUniClientDataSet;
  strFields: String;
  strDescFields: String;
  strBookMark : TBookMark;
  Index: TIndexDef;
  intField: Integer;
  qryOrd: TUniQuery;
Begin
  qryOrd := fCriaQuery;
  cdsOrd := TUniClientDataSet( DataSet );
  Try
    Try
      qryOrd.DisableControls;
      qryOrd.Close;
      qryOrd.SQL.Clear;
      qryOrd.SQL.Add(SQLSelect);

      qryOrd.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryOrd.ParamByName('NOMFOR').AsString := FNomeFormulario;
      qryOrd.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryOrd.ParamByName('NOMGRD').AsString := strNomGrd;
      qryOrd.Open;

      If qryOrd.IsEmpty Then
        Exit;

      cdsBkp := TUniClientDataSet.Create(Nil);
      cdsBkp.Data := cdsOrd.data;

      cdsOrd.IndexDefs.Clear;
      cdsOrd.IndexName := '';
      cdsOrd.StoreDefs := False;
      cdsOrd.IndexFieldNames := '';

      strBookMark := qryOrd.GetBookMark;
      qryOrd.DisableControls;
      qryOrd.first;
      While Not qryOrd.eof do
      Begin
        If qryOrd.FieldByName('ORD_ORDDSC').AsString = 'S' Then
        Begin
          If fEmptyStr(strDescFields) Then
            strDescFields := qryOrd.FieldByName('ORD_ORDNAM').AsString
          Else
            strDescFields := strFields + ';' + qryOrd.FieldByName('ORD_ORDNAM').AsString ;
        End;

        If fEmptyStr(strFields) Then
          strFields := qryOrd.FieldByName('ORD_ORDNAM').AsString
        Else
          strFields := strFields + ';' + qryOrd.FieldByName('ORD_ORDNAM').AsString ;

        qryOrd.Next;
      End;
      qryOrd.EnableControls;
      qryOrd.BookMark := strBookMark;

      cdsOrd.Active := false;
      Index:= cdsOrd.IndexDefs.AddIndexDef;
      Index.Name   := 'IDX_001';
      Index.Fields := strFields;
      Index.DescFields := strDescFields;

      cdsOrd.IndexName := 'IDX_001';

      cdsOrd.CreateDataSet;
      cdsOrd.Data := cdsBkp.Data;

      For intField := 0 To cdsOrd.Fields.Count -1 Do
      Begin
        If cdsOrd.Fields[intField].DataType = ftFloat Then
          TFloatField(cdsOrd.Fields[intField]).DisplayFormat := '#,##0.00';
      End;

    Except
      cdsOrd.data := cdsBkp.Data;
      cdsOrd.Active := True;
    End;
  Finally
    FreeAndNil(cdsBkp);
    FreeAndNil(qryOrd);
  End;
End;

procedure TCfgTela.pRestaurarPadrao(const dbgDados: TcxGridDBTableViewCitel);
begin
  pSetarPadrao(dbgDados);
end;

procedure TCfgTela.pAtualizarColunasGrid(const dbgDados: TcxGridDBTableViewCitel; const arrCol: TArrayOfCol);
Var
  intCnt: Integer;
  Column: TcxGridDBColumn;
  DataSource: TDataSource;
Begin
  DataSource := dbgDados.DataController.DataSource;
  dbgDados.DataController.DataSource := Nil;
  Try
    For intCnt := 0 To dbgDados.ColumnCount - 1 Do
      dbgDados.Columns[intCnt].Visible := False;

    For intCnt := Low(arrCol) To High(arrCol) Do
    Begin
      If (arrCol[intCnt].blnVisible) Then
      Begin
        Column := TcxGridDBColumnHelper.fFindColumnByNameView(dbgDados,
          arrCol[intCnt].strFieldName);

        If (Column <> Nil) Then
        Begin
          Column.Index := arrCol[intCnt].intIndex;
          Column.DataBinding.FieldName := arrCol[intCnt].strFieldName;
          Column.Caption := arrCol[intCnt].strCaption;
          Column.Width := arrCol[intCnt].intWidth;
          Column.Visible := arrCol[intCnt].blnVisible;
          If arrCol[intCnt].blnCheckbox Then
          Begin
            dbgDados.Columns[intCnt].PropertiesClass := TcxCheckBoxProperties;
            TcxCheckBoxProperties(dbgDados.Columns[intCnt].Properties).ValueChecked := 1;
            TcxCheckBoxProperties(dbgDados.Columns[intCnt].Properties).ValueUnChecked := 0;
          End;
        End;
      End;
    End;
  Finally
    dbgDados.DataController.DataSource := DataSource;
  End;
End;

procedure TCfgTela.pSetarPadrao(const dbgDados: TcxGridDBTableViewCitel);
Begin
  pAtualizarColunasGrid(dbgDados, FarrColsOri);
End;

procedure TCfgTela.pSetarUltimosDadosCarregados(const dbgDados  : TcxGridDBTableViewCitel);
Begin
  If (Length(FarrColsDad) > 0) Then
    pAtualizarColunasGrid(dbgDados, FarrColsDad);
End;

procedure TCfgTela.SetArrColsOri(AValue: TArrayOfCol);
Begin
  FarrColsOri := AValue;
End;

procedure TCfgTela.SetBlnUsu(const Value: Boolean);
begin
  FBlnCfgUsu := Value;
end;

procedure TCfgTela.SetIntUtiWidthGrid(AValue: Integer);
Begin
  FintUtiWidthGrid := AValue;
End;

procedure TCfgTela.SetNomeFormulario(const AValue: string);
Begin
  FNomeFormulario := AValue;
End;

procedure TCfgTela.SetNomObj(const AValue: String);
begin
  FNomeObjeto := AValue;
end;

procedure TCfgTela.SetStrDescri(const AValue: String);
begin
  FstrDescri := AValue;
end;

{ TCfgTelaImpulsionadorVendasCRM }

constructor TCfgTelaImpulsionadorVendasCRM.Create;
Begin
  inherited;

  FNomeFormulario := 'frmImpulsionadorVendasCRM';
  FSugestao := TCfGSugImpulsionadorVendasCRM.Create;
  FSugestao.nomeFormulario :=  FNomeFormulario;
End;

destructor TCfgTelaImpulsionadorVendasCRM.Destroy;
Begin
  If Assigned(FSugestao) Then
    FreeAndNil(FSugestao);
End;

function TCfgTelaImpulsionadorVendasCRM.GetSugestao: TCfGSugImpulsionadorVendasCRM;
Begin
  Result := FSugestao;
End;

procedure TCfgTelaImpulsionadorVendasCRM.pConfigurarGrid(
  const dbgDadosView: TcxGridDBTableViewCitel);
begin
  inherited;

  pVerificaNovasColunasAdicionadas(dbgDadosView);
end;

class procedure TCfgTelaImpulsionadorVendasCRM.pFormatarCelula(
  ACanvas: TcxCanvas; ACorFonte, ACorFundo: TColor; ANegrito: Boolean);
Begin
  ACanvas.Font.Color := ACorFonte;
  ACanvas.Brush.Color := ACorFundo;

  If ANegrito Then
  Begin
    ACanvas.Font.Style := [fsBold]
  End
  Else
    ACanvas.Font.Style := [];
End;

procedure TCfgTelaImpulsionadorVendasCRM.pReordenaColunas(
  const dbgDadosView: TcxGridDBTableViewCitel);
var
  intCnt,
  intCont: Integer;
  Coluna: TcxGridDBColumn;
  Temp: TRecColGrid;
Begin
  For intCnt := 0 to Length(FarrColsDad)-1  Do
  Begin
    For intCont := 0 to Length(FarrColsDad)-2 Do
    Begin
      If FarrColsDad[intCont].intIndex > FarrColsDad[intCont + 1].intIndex Then
      Begin
        Temp := FarrColsDad[intCont];
        FarrColsDad[intCont] :=  FarrColsDad[intCont + 1];
        FarrColsDad[intCont + 1] := Temp;
      End;
    End;
  End;

  For intCnt := 0 to Length(FarrColsDad)-1 Do
  Begin
    FarrColsDad[Length(FarrColsDad) - 1].intIndex := intCnt;
    Coluna := dbgDadosView.GetColumnByFieldName(FarrColsDad[intCnt].strFieldName);
    Coluna.Index := intCnt;
  End;
End;

procedure TCfgTelaImpulsionadorVendasCRM.pVerificaNovasColunasAdicionadas(
  const dbgDadosView: TcxGridDBTableViewCitel);
var
  intCnt,
  intCont: Integer;
  nomeColuna: String;
  blnEncontrou: Boolean;
  Coluna: TcxGridDBColumn;
  intIndiceUnMed : Integer;
Begin

  intIndiceUnMed := Length(FarrColsDad)-1;
  If Length(FarrColsDad) <> Length(FarrColsOri) Then
  Begin
    For intCnt := 0 to Length(FarrColsOri)-1 Do
    Begin
      nomeColuna := FarrColsOri[intCnt].strFieldName;
      blnEncontrou := False;
      For intCont := 0 to Length(FarrColsDad)-1 Do
      Begin
        If FarrColsDad[intCont].strFieldName = nomeColuna Then
        Begin
          If FarrColsOri[intCont].strFieldName = 'UNIDAD' Then
            intIndiceUnMed := FarrColsDad[intCont].intIndex;
          blnEncontrou := True;
          Break;
        End;
      End;

      If Not blnEncontrou Then
      Begin
        If nomeColuna = 'NVLGIR' Then
        Begin
          SetLength(FarrColsDad, Length(FarrColsDad) +1);
          FarrColsDad[Length(FarrColsDad) - 1].strFieldName := FarrColsOri[intCnt].strFieldName;
          FarrColsDad[Length(FarrColsDad) - 1].strCaption := FarrColsOri[intCnt].strCaption;
          FarrColsDad[Length(FarrColsDad) - 1].intWidth := FarrColsOri[intCnt].intWidth;
          FarrColsDad[Length(FarrColsDad) - 1].blnVisible := FarrColsOri[intCnt].blnVisible;
          FarrColsDad[Length(FarrColsDad) - 1].intIndex := intIndiceUnMed;
          FarrColsDad[Length(FarrColsDad) - 1].blnCheckbox := FarrColsOri[intCnt].blnCheckbox;

          Coluna := TcxGridDBColumnHelper.fFindColumnByNameView(dbgDadosView, FarrColsOri[intCnt].strFieldName);
          If (Coluna <> Nil) Then
          Begin
            Coluna.Visible :=FarrColsOri[intCnt].blnVisible;
            Coluna.Index := FarrColsOri[intCnt].intIndex;
            Coluna.Caption := FarrColsOri[intCnt].strCaption;
            Coluna.Width := FarrColsOri[intCnt].intWidth;
            FintUtiWidthGrid := FintUtiWidthGrid + Coluna.Width;
          End;
          pReordenaColunas(dbgDadosView);
        End;
      End;
    End;
  End;
end;


procedure TCfgTelaImpulsionadorVendasCRM.SetSugestao(
  AValue: TCfGSugImpulsionadorVendasCRM);
Begin
  FSugestao := AValue;
End;

{ TCfGSug }

constructor TCfGSug.Create;
Begin
  FCodEmp := VS_strCodEmp;
  FCorFonteLinhaPadrao := clInfoText;
  FCorFundoLinhaPadrao := clWindow;
  FCorFonteLinhaSelPadrao := clWindow;
  FCorFundoLinhaSelPadrao := clHighlight;
  FTamanhoFontePadrao := 8;
  FstrSQLCoresPadrao := EmptyStr;
End;

procedure TCfGSug.pCarregarTamanhoFonteObj(const strDescricao: String = '');
begin
  FTamanhoFonte := StrToIntDef( fCarregarInfObjeto(IIF(FEmptyStr(strDescricao), 'speTamanhoFonteConfig', strDescricao)), FTamanhoFontePadrao);
end;

function TCfGSug.fCarregarInfObjeto(const strNome: String): string;
var
  qry: TUniQuery;
  SQLSelect: String;
Begin
  SQLSelect := 'SELECT SUG_SUGEST FROM SUGFRM  ' +
               'WHERE SUG_NOMFOR = :NOMFOR AND ' +
               '      SUG_CODEMP = :CODEMP AND ' +
               '      SUG_NAMOBJ = :NAMOBJ     ';

  If FBlnCfgUsu Then
    SQLSelect := SQLSelect+ ' AND SUG_CODOPE = :CODOPE ';

  qry := fCriaQuery;
  try
    qry.DisableControls;
    qry.Close;
    qry.SQL.Add(SQLSelect);
    qry.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qry.ParamByName('CODEMP').AsString := FCodEmp;
    qry.ParamByName('NAMOBJ').AsString := strNome;
    If FBlnCfgUsu Then
       qry.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    qry.Open;

    if Not qry.IsEmpty Then
    Begin
      Result := qry.FieldByName('SUG_SUGEST').AsString;
    End;
  finally
    FreeAndNil(qry);
  End;

End;

destructor TCfGSug.Destroy;
Begin
  inherited;

End;

function TCfGSug.GetBlnCfgusu: Boolean;
begin
  Result := FBlnCfgUsu;
end;

function TCfGSug.GetCodEmp: String;
Begin
  Result := FCodEmp;
End;

function TCfGSug.GetCorFonteLinha: TColor;
Begin
  Result := FCorFonteLinha;
End;

function TCfGSug.GetCorFonteLinhaSelecionada: TColor;
Begin
  Result := FCorFonteLinhaSel;
End;

function TCfGSug.GetCorFundoLinha: TColor;
Begin
  Result := FCorFundoLinha;
End;

function TCfGSug.GetCorFundoLinhaSelecionada: TColor;
Begin
  Result := FCorFundoLinhaSel
End;

function TCfGSug.GetNomeFormulario: String;
Begin
  Result := FNomeFormulario;
End;

function TCfGSug.GetTamanhoFonte: Integer;
Begin
  Result := FTamanhoFonte;
End;

procedure TCfGSug.pGravarFonteGrid(const TamFonte: Integer; strDescricao: String = '');
Begin
  If fEmptyStr(strDescricao) Then
    strDescricao := 'speTamanhoFonteConfig';

  pGravarSugestoesNoBanco(strDescricao, IntToStr(TamFonte));
End;

procedure TCfGSug.pGravarSugestoesNoBanco(strNome, strValor: String);
Var
  qrySug: TUniQuery;
Begin
  qrySug := fCriaQuery;
  fStartTransaction;
  Try
    Try
      qrySug.Close;
      qrySug.SQL.Clear;
      qrySug.SQL.Add('DELETE FROM SUGFRM ');
      qrySug.SQL.Add('  WHERE SUG_NOMFOR = :NOMFOR ');
      qrySug.SQL.Add('    AND SUG_CODEMP = :CODEMP ');
      qrySug.SQL.Add('    AND SUG_NAMOBJ = :NAMOBJ ');
      qrySug.SQL.Add('    AND SUG_CODOPE = :CODOPE ');
      qrySug.ParamByName('NOMFOR').AsString := FNomeFormulario;
      qrySug.ParamByName('CODEMP').AsString := FCodEmp;
      qrySug.ParamByName('NAMOBJ').AsString := strNome;
      qrySug.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qrySug.ExecSQL;

      qrySug.Close;
      qrySug.SQL.Clear;
      qrySug.SQL.Add('SELECT * FROM SUGFRM WHERE FALSE');
      qrySug.Open;

      qrySug.Append;
      qrySug.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SUGFRM', FCodEmp);
      qrySug.FieldByName('SUG_NOMFOR').AsString := FNomeFormulario;
      qrySug.FieldByName('SUG_CODEMP').AsString := FCodEmp;
      qrySug.FieldByName('SUG_NAMOBJ').AsString := strNome;
      qrySug.FieldByName('SUG_SUGEST').AsString := strValor;
      qrySug.FieldByName('SUG_CODOPE').AsString := strLoginUsuarioLogado;
      qrySug.Post;

      fCommit;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgTela.pGravarSugestoesNoBanco]');
      End;
    End;

  Finally
    FreeAndNil(qrySug);
  End;
End;

procedure TCfGSug.pRestaurarCoresPadraoGrid;
begin
  If fEmptyStr(FstrSQLCoresPadrao) Then
    Exit;

  fExecutaSQL(FstrSQLCoresPadrao);
end;

procedure TCfGSug.SetBlnCfgUsu(const Value: Boolean);
begin
  FBlnCfgUsu := Value;
end;

procedure TCfGSug.SetCorFonteLinha(const Value: TColor);
Begin
  FCorFonteLinha := Value;
End;

procedure TCfGSug.SetCorFonteLinhaSelecionada(const Value: TColor);
Begin
  FCorFonteLinhaSel:= Value;
End;

procedure TCfGSug.SetCorFundoLinha(const Value: TColor);
Begin
  FCorFundoLinha:= Value;
End;

procedure TCfGSug.SetCorFundoLinhaSelecionada(const Value: TColor);
Begin
  FCorFundoLinhaSel := Value;
End;

procedure TCfGSug.SetNomeFormulario(const Value: String);
Begin
  FNomeFormulario := Value;
End;

procedure TCfGSug.pGravarCoresGrid(const nomeGrid: String);
var
  aCorGrid: TCorGrid;
Begin
  aCorGrid := TCorGrid.Create(FNomeFormulario, nomeGrid);
  Try
    aCorGrid.AlterarCor('FontePadrao', FCorFonteLinha);
    aCorGrid.AlterarCor('FonteLinhaSel', FCorFonteLinhaSel);
    aCorGrid.AlterarCor('FundoPadrao', FCorFundoLinha);
    aCorGrid.AlterarCor('FundoLinhaSel', FCorFundoLinhaSel);
  Finally
    FreeAndNil(aCorGrid);
  End;
End;

procedure TCfGSug.pCarregarCoresGrid(const nomeGrid: string);
var
  aCorGrid: TCorGrid;
Begin
  aCorGrid := TCorGrid.Create(FNomeFormulario, nomeGrid);
  Try

    FCorFonteLinha := aCorGrid.CarregarCor('FontePadrao');
    FCorFonteLinhaSel := aCorGrid.CarregarCor('FonteLinhaSel');
    FCorFundoLinha := aCorGrid.CarregarCor('FundoPadrao');
    FCorFundoLinhaSel := aCorGrid.CarregarCor('FundoLinhaSel');

    If FCorFonteLinha = clNone Then
      FCorFonteLinha := FCorFonteLinhaPadrao;
    If FCorFundoLinha = clNone Then
      FCorFundoLinha := FCorFundoLinhaPadrao;
    If FCorFonteLinhaSel = clNone Then
      FCorFonteLinhaSel := FCorFonteLinhaSelPadrao;
    If FCorFundoLinhaSel = clNone Then
      FCorFundoLinhaSel := FCorFundoLinhaSelPadrao;
  Finally
    FreeAndNil(aCorGrid);
  End;

End;

{ TCfGSugImpulsionadorVendasCRM }

constructor TCfGSugImpulsionadorVendasCRM.Create;
Begin
  inherited;

  FCorFonteColunaQtdItePadrao := clInfoText;
  FCorFundoColunaQtdItePadrao := clYellow;
  FCorFonteColunaUniTarPadrao := clInfoText;
  FCorFundoColunauniTarPadrao := clYellow;
End;

function TCfGSugImpulsionadorVendasCRM.GetCorFonteColunaQtdIte: TColor;
begin
  Result := FCorFonteColunaQtdIte;
end;

function TCfGSugImpulsionadorVendasCRM.GetCorFonteColunaUniTar: TColor;
begin
  Result := FCorFonteColunaUniTar;
end;

function TCfGSugImpulsionadorVendasCRM.GetCorFundoColunaQtdIte: TColor;
begin
  Result := FCorFundoColunaQtdIte;
end;

function TCfGSugImpulsionadorVendasCRM.GetCorFundoColunaUniTar: TColor;
begin
  Result := FCorFundoColunaUniTar;
end;

procedure TCfGSugImpulsionadorVendasCRM.pCarregarCoresGrid(const nomeGrid: string);
var
  aCorGrid: TCorGrid;
Begin
  inherited;

  aCorGrid := TCorGrid.Create(FNomeFormulario, nomeGrid);

  Try
    FCorFonteColunaQtdIte := aCorGrid.CarregarCor('FonteColunaQtdIte');
    FCorFonteColunaUniTar := aCorGrid.CarregarCor('FonteColunaUnitar');
    FCorFundoColunaQtdIte := aCorGrid.CarregarCor('FundoColunaQtdIte');
    FCorFundoColunaUniTar := aCorGrid.CarregarCor('FundoColunaUniTar');

    If FCorFonteColunaQtdIte = clNone Then
      FCorFonteColunaQtdIte := FCorFonteColunaQtdItePadrao;
    If FCorFundoColunaQtdIte = clNone Then
      FCorFundoColunaQtdIte := FCorFundoColunaQtdItePadrao;
    If FCorFonteColunaUniTar = clNone Then
      FCorFonteColunaUniTar := FCorFonteColunaUniTarPadrao;
    If FCorFundoColunaUniTar = clNone Then
      FCorFundoColunaUniTar := FCorFundoColunaUniTarPadrao;
  Finally
    FreeAndNil(aCorGrid);
  End;

End;

procedure TCfGSugImpulsionadorVendasCRM.pGravarCoresGrid(const nomeGrid: string);
var
  aCorGrid: TCorGrid;
Begin
  inherited;

  aCorGrid := TCorGrid.Create(FNomeFormulario, nomeGrid);
  Try
    aCorGrid.AlterarCor('FonteColunaQtdIte', FCorFonteColunaQtdIte);
    aCorGrid.AlterarCor('FundoColunaQtdIte', FCorFundoColunaQtdIte);
    aCorGrid.AlterarCor('FonteColunaUnitar', FCorFonteColunaUniTar);
    aCorGrid.AlterarCor('FundoColunaUniTar', FCorFundoColunaUniTar);
  Finally
    FreeAndNil(aCorGrid);
  End;
End;

procedure TCfGSugImpulsionadorVendasCRM.pRestaurarCoresPadraoGrid;
Begin
  FstrSQLCoresPadrao := ' replace into GRDCOR (GRD_FORMUL, GRD_GRID__, GRD_IDENTI, GRD_COR___) values' +
    ' ("frmImpulsionadorVendasCRM","grdResumoVendas","FontePadrao", "clInfoText"),' +
    ' ("frmImpulsionadorVendasCRM","grdResumoVendas","FundoPadrao", "clWindow"),' +
    ' ("frmImpulsionadorVendasCRM","grdResumoVendas","FonteLinhaSel", "clWindow"),' +
    ' ("frmImpulsionadorVendasCRM","grdResumoVendas","FundoLinhaSel", "clHighlight"),' +
    ' ("frmImpulsionadorVendasCRM","grdResumoVendas","FonteColunaQtdIte", "clInfoText"),' +
    ' ("frmImpulsionadorVendasCRM","grdResumoVendas","FundoColunaQtdIte", "clYellow"),' +
    ' ("frmImpulsionadorVendasCRM","grdResumoVendas","FonteColunaUnitar", "clInfoText"),' +
    ' ("frmImpulsionadorVendasCRM","grdResumoVendas","FundoColunaUniTar", "clYellow")';

  fExecutaSQL(FstrSQLCoresPadrao);
End;

procedure TCfGSugImpulsionadorVendasCRM.SetCorFonteColunaQtdIte(
  const Value: TColor);
begin
  FCorFonteColunaQtdIte := Value;
end;

procedure TCfGSugImpulsionadorVendasCRM.SetCorFundoColunaQtdIte(
  const Value: TColor);
begin
  FCorFundoColunaQtdIte := Value;
end;

procedure TCfGSugImpulsionadorVendasCRM.SetCorFundoColunaUniTar(
  const Value: TColor);
begin
  FCorFundoColunaUniTar := Value;
end;

procedure TCfGSugImpulsionadorVendasCRM.SetFonteColunaUniTar(
  const Value: TColor);
begin
  FCorFonteColunaUniTar := Value;
end;

{ TCfgTelaConsultaLeadCRM }

constructor TCfgTelaConsultaLeadCRM.Create;
begin
  FNomeFormulario := 'frmConsultaLeadsCRM';
  FCodEmp := VS_strCodEmp;
end;

destructor TCfgTelaConsultaLeadCRM.Destroy;
begin

  inherited;
end;

function TCfgTelaConsultaLeadCRM.fConverteGridArrayCol(
  const dbgDados: TcxGridDBTableViewCitel): TArrayOfCol;
Var
  intCnt: Integer;
  arrCols: TArrayOfCol;
Begin
  SetLength(arrCols, 0);
  For intCnt := 0 To dbgDados.ColumnCount - 1 Do
  Begin
    SetLength(arrCols, Length(arrCols) + 1);
    arrCols[Length(arrCols) - 1].strFormName := FNomeFormulario;
    arrCols[Length(arrCols) - 1].strCodEmp := FCodEmp;
    arrCols[Length(arrCols) - 1].intIndex := dbgDados.Columns[intCnt].Index;
    arrCols[Length(arrCols) - 1].strFieldName := dbgDados.Columns[intCnt].DataBinding.FieldName;
    arrCols[Length(arrCols) - 1].strCaption := dbgDados.Columns[intCnt].Caption;
    arrCols[Length(arrCols) - 1].intWidth := dbgDados.Columns[intCnt].Width;
    arrCols[Length(arrCols) - 1].blnVisible := dbgDados.Columns[intCnt].Visible;
  End;

  Result := arrCols;
End;

procedure TCfgTela.pCarregaOrd(Const cdsColOrd: TUniClientDataSet; Const strNomeGrid: String);
const
  SQLSelect = 'SELECT * FROM ORDCOL  ' +
              ' WHERE  ORD_CODEMP = :CODEMP   ' +
              '   AND ORD_NOMFOR = :NOMFOR ' +
              '   AND ORD_NOMGRD = :NOMGRD ' +
              ' ORDER BY ORD_ORDCAM ';
var
  qryTmp : TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery;
    qryTmp.DisableControls;
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(SQLSelect);
    qryTmp.ParamByName('CODEMP').AsString := FCodEmp;
    qryTmp.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryTmp.ParamByName('NOMGRD').AsString := strNomeGrid;
    qryTmp.Open;

    cdsColOrd.DisableControls;
    try

      While Not qryTmp.eof do
      Begin
        cdsColOrd.Insert;
        cdsColOrd.FieldByName('ORDNAM').AsString  := qryTmp.FieldByName('ORD_ORDNAM').AsString ;
        cdsColOrd.FieldByName('ORDCAP').AsString  := qryTmp.FieldByName('ORD_ORDCAP').AsString ;
        cdsColOrd.FieldByName('ORDCAM').AsInteger := qryTmp.FieldByName('ORD_ORDCAM').AsInteger;
        cdsColOrd.FieldByName('ORDDSC').AsString  := qryTmp.FieldByName('ORD_ORDDSC').AsString ;
        cdsColOrd.Post;

        qryTmp.Next;
      End;

    finally
      cdsColOrd.EnableControls;
    end;

  Finally
    FreeAndNil(qryTmp);
  End;

End;

procedure TCfgTela.pConfigurarGrid(const dbgDadosView: TcxGridDBTableViewCitel;
  const strDescricao: String; cds: TUniClientDataSet; var intRecNo: Integer;
  blnAlterarVisibilidade: Boolean = True);
var
  intCnt: Integer;
  intCont: Integer;
begin
  SetLength(FarrColsOri, 0);
  FarrColsOri := fConverteGridArrayCol(dbgDadosView);

  fGetFuncoesCxGrid.fCarregarView(dbgDadosView, strDescricao, cds, intRecNo);

  If Not blnAlterarVisibilidade Then
    Exit;

  For intCnt := 0 To dbgDadosView.ColumnCount-1 Do
  Begin
    dbgDadosView.Columns[intCnt].Visible := False;
    for intCont := 0 to Length(FarrColsOri)-1 Do
    Begin
      If FarrColsOri[intCont].strFieldName = dbgDadosView.Columns[intCnt].DataBinding.FieldName Then
      Begin
        dbgDadosView.Columns[intCnt].Visible := True;
        Break;
      End;
    End;
  End;
end;

procedure TCfgTela.pOrdenaColunas(Const DataSet: TDataSet; Const cdsColOrd: TUniClientDataSet);
var
  cdsOrd, cdsBkp: TUniClientDataSet;
  strFields: String;
  strDescFields: String;
  strBookMark : TBookMark;
  Index: TIndexDef;
  intField: Integer;
Begin
  cdsOrd := TUniClientDataSet( DataSet );
  Try
    Try
      cdsBkp := TUniClientDataSet.Create(DataSet);
      cdsBkp.Data := cdsOrd.data;

      cdsOrd.IndexDefs.Clear;
      cdsOrd.IndexName := '';
      cdsOrd.StoreDefs := False;
      cdsOrd.IndexFieldNames := '';

      If Not cdsColOrd.isEmpty Then
      Begin
        strBookMark := cdsColOrd.GetBookMark;
        cdsColOrd.DisableControls;
        cdsColOrd.first;
        While Not cdsColOrd.eof do
        Begin
          If cdsColOrd.FieldByName('ORDDSC').AsString = 'S' Then
          Begin
            If fEmptyStr(strDescFields) Then
              strDescFields := cdsColOrd.FieldByName('ORDNAM').AsString
            Else
              strDescFields := strFields + ';' + cdsColOrd.FieldByName('ORDNAM').AsString ;
          End;

          If fEmptyStr(strFields) Then
            strFields := cdsColOrd.FieldByName('ORDNAM').AsString
          Else
            strFields := strFields + ';' + cdsColOrd.FieldByName('ORDNAM').AsString ;

          cdsColOrd.Next;
        End;
        cdsColOrd.EnableControls;
        cdsColOrd.BookMark := strBookMark;

        cdsOrd.Active := false;
        Index:= cdsOrd.IndexDefs.AddIndexDef;
        Index.Name   := 'IDX_001';
        Index.Fields := strFields;
        Index.DescFields := strDescFields;

        cdsOrd.IndexName := 'IDX_001';

        cdsOrd.CreateDataSet;
        cdsOrd.Data := cdsBkp.Data;

        For intField := 0 To cdsOrd.Fields.Count -1 Do
        Begin
          If cdsOrd.Fields[intField].DataType = ftFloat Then
            TFloatField(cdsOrd.Fields[intField]).DisplayFormat := '#,##0.00';
        End;
      End;
    Except
      cdsOrd.data := cdsBkp.Data;
      cdsOrd.Active := True;
    End;
  Finally
    FreeAndNil(cdsBkp);
  End;
End;

procedure TCfgTelaConsultaLeadCRM.pConfigurarGrid(Const dbgDadosView: TcxGridDBTableViewCitel);
const
  SQLSelect = ' SELECT * ' +
              '   FROM COLCNF' +
              '  WHERE COL_NOMFOR = :NOMFOR ' +
              '    AND COL_CODEMP = :CODEMP ' +
              '    AND COL_NOMGRD = :NOMGRD ' +
              '  ORDER BY COL_COLORD ';
var
  intCnt: Integer;
  qryCol: TUniQuery;
  Coluna: TcxGridDBColumn;
  intIndex: Integer;
  DtaSource: TDataSource;
Begin

  pDefinirOrdenacao(dbgDadosView.DataController.DataSource.DataSet, dbgDadosView.Name);

  qryCol := fCriaQuery;

  Try
    qryCol.DisableControls;
    qryCol.Close;
    qryCol.SQL.Clear;
    qryCol.SQL.Add(SQLSelect);
    qryCol.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryCol.ParamByName('CODEMP').AsString := FCodEmp;
    qryCol.ParamByName('NOMGRD').AsString := dbgDadosView.Name;
    qryCol.Open;

    SetLength(FarrColsDad, 0);

    If Not qryCol.IsEmpty Then
    Begin
      DtaSource := dbgDadosView.DataController.DataSource;
      dbgDadosView.DataController.DataSource := Nil;

      Try
        For intCnt := 0 To dbgDadosView.ColumnCount - 1 Do
          dbgDadosView.Columns[intCnt].Visible := False;

        intIndex := 0;
        intUtiWidthGrid := 0;

        qryCol.First;

        While Not qryCol.Eof Do
        Begin
          Coluna := TcxGridDBColumnHelper.fFindColumnByNameView(dbgDadosView, qryCol.FieldByName('COL_COLNAM').AsString);

          If (Coluna <> Nil) Then
          Begin
            Coluna.Visible := True;
            Coluna.Index := intIndex;

            Coluna.Caption := qryCol.FieldByName('COL_COLCAP').AsString;
            Coluna.Width := qryCol.FieldByName('COL_COLTAM').AsInteger;

            intUtiWidthGrid := intUtiWidthGrid + Coluna.Width;

            SetLength(FarrColsDad, Length(FarrColsDad) + 1);
            FarrColsDad[Length(FarrColsDad) - 1].strFieldName := Coluna.DataBinding.FieldName;
            FarrColsDad[Length(FarrColsDad) - 1].strCaption := Coluna.Caption;
            FarrColsDad[Length(FarrColsDad) - 1].intWidth := Coluna.Width;
            FarrColsDad[Length(FarrColsDad) - 1].blnVisible := Coluna.Visible;
            FarrColsDad[Length(FarrColsDad) - 1].intIndex := Coluna.Index;

            intIndex := intIndex + 1;
          End;

          qryCol.Next;
        End;
      Finally
        dbgDadosView.DataController.DataSource := DtaSource;
      End;

    End;

  Finally
    FreeAndNil(qryCol);
  End;
End;

procedure TCfgTelaConsultaLeadCRM.pGravarDadosNoBanco(const dbgDados: TcxGridDBTableViewCitel; const cdsOrd: TUniClientDataSet);
Var
  qryCol: TUniQuery;
  qryOrd: TUniQuery;
  intCnt: Integer;
  intIndex: Integer;
Begin
  pSetarEstado(dbgDados);

  Try
    qryCol := fCriaQuery;
    qryOrd := fCriaQuery;

    fStartTransaction;

    Try
      qryCol.DisableControls;
      qryCol.Close;
      qryCol.SQL.Clear;
      qryCol.SQL.Add('DELETE ' +
                     '  FROM COLCNF ' +
                     ' WHERE COL_NOMFOR = :NOMFOR ' +
                     '   AND COL_CODEMP = :CODEMP ' +
                     '   AND COL_NOMGRD = :NOMGRD');
      qryCol.ParamByName('NOMFOR').AsString := FNomeFormulario;
      qryCol.ParamByName('CODEMP').AsString := FCodEmp;
      qryCol.ParamByName('NOMGRD').AsString := dbgDados.Name;
      qryCol.ExecSQL;

      qryCol.Close;
      qryCol.SQL.Clear;
      qryCol.SQL.Add('SELECT * ' +
                     '  FROM COLCNF ' +
                     ' WHERE COL_NOMFOR = :NOMFOR ' +
                     '   AND COL_CODEMP = :CODEMP ' +
                     '   AND COL_NOMGRD = :NOMGRD');
      qryCol.ParamByName('NOMFOR').AsString := FNomeFormulario;
      qryCol.ParamByName('CODEMP').AsString := FCodEmp;
      qryCol.ParamByName('NOMGRD').AsString := dbgDados.Name;
      qryCol.Open;

      intIndex := 0;

      For intCnt := Low(FarrCols) To High(FarrCols) Do
      Begin
        If (FarrCols[intCnt].blnVisible) Then
        Begin
          qryCol.Append;
          qryCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COLCNF', FCodEmp);
          qryCol.FieldByName('COL_NOMFOR').AsString := FNomeFormulario;
          qryCol.FieldByName('COL_CODEMP').AsString := FCodEmp;
          qryCol.FieldByName('COL_NOMGRD').AsString := dbgDados.Name;
          qryCol.FieldByName('COL_COLNAM').AsString := FarrCols[intCnt].strFieldName;
          qryCol.FieldByName('COL_COLCAP').AsString := FarrCols[intCnt].strCaption;
          qryCol.FieldByName('COL_COLORD').AsInteger := intIndex;
          qryCol.FieldByName('COL_COLTAM').AsInteger := FarrCols[intCnt].intWidth;
          qryCol.FieldByName('COL_COLEXI').AsString := iif(FarrCols[intCnt].blnVisible, 'S', 'N');
          qryCol.Post;

          Inc(intIndex);
        End;
      End;

      qryOrd.DisableControls;
      qryOrd.Close;
      qryOrd.SQL.Clear;
      qryOrd.SQL.Add('DELETE ' +
                     '  FROM ORDCOL ' +
                     ' WHERE ORD_NOMFOR = :NOMFOR ' +
                     '   AND ORD_CODEMP = :CODEMP ' +
                     '   AND ORD_NOMGRD = :NOMGRD ');
      qryOrd.ParamByName('NOMFOR').AsString := FNomeFormulario;
      qryOrd.ParamByName('CODEMP').AsString := FCodEmp;
      qryOrd.ParamByName('NOMGRD').AsString := dbgDados.Name;
      qryOrd.ExecSQL;

      qryOrd.Close;
      qryOrd.SQL.Clear;
      qryOrd.SQL.Add('SELECT * FROM ORDCOL ' +
                     ' WHERE ORD_NOMFOR = :NOMFOR ' +
                     '   AND ORD_CODEMP = :CODEMP ' +
                     '   AND ORD_NOMGRD = :NOMGRD ');
      qryOrd.Open;

      cdsOrd.First;

      While not cdsOrd.Eof do
      Begin
        qryOrd.Append;
        qryOrd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ORDCOL', FCodEmp);
        qryOrd.FieldByName('ORD_NOMFOR').AsString := FNomeFormulario;
        qryOrd.FieldByName('ORD_CODEMP').AsString := FCodEmp;
        qryCol.FieldByName('ORD_NOMGRD').AsString := dbgDados.Name;
        qryOrd.FieldByName('ORD_ORDNAM').AsString := cdsOrd.FieldByName('ORDNAM').AsString;
        qryOrd.FieldByName('ORD_ORDCAP').AsString := cdsOrd.FieldByName('ORDCAP').AsString;
        qryOrd.FieldByName('ORD_ORDDSC').AsString := cdsOrd.FieldByName('ORDDSC').AsString;
        qryOrd.FieldByName('ORD_ORDCAM').AsInteger := cdsOrd.FieldByName('ORDCAM').AsInteger;
        qryOrd.Post;

        cdsOrd.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TCfgTelaConsultaLeadCRM.pGravarDadosNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qryCol);
    FreeAndNil(qryOrd);
  End;
End;

{ TCfgTelaConsultaOcorrenciaCRM }

constructor TCfgTelaConsultaOcorrenciaCRM.Create(strTip_FC: String);
begin
  FTip_FC := strTip_FC;
  FNomeFormulario := 'frmConsultaOcorrenciasCRM.' + FTip_Fc;

  FSugestao := TCfGSug.Create;
  FSugestao.nomeFormulario := FNomeFormulario;
  FSugestao.BlnCfgUsu := True;
  FBlnCfgUsu := True;
  FCodEmp := VS_strCodEmp;
  FTamanhoFontePadrao := 8;
end;

destructor TCfgTelaConsultaOcorrenciaCRM.Destroy;
begin

  inherited;
end;

function TCfgTelaConsultaOcorrenciaCRM.fConverteGridArrayCol(
  const dbgDados: TcxGridDBTableViewCitel): TArrayOfCol;
var
  intCnt: Integer;
  arrCols: TArrayOfCol;
Begin
  SetLength(arrCols, 0);
  For intCnt := 0 To dbgDados.ColumnCount - 1 Do
  Begin
    SetLength(arrCols, Length(arrCols) + 1);
    arrCols[Length(arrCols) - 1].strFormName := FNomeFormulario;
    arrCols[Length(arrCols) - 1].strCodEmp := FCodEmp;
    arrCols[Length(arrCols) - 1].intIndex := dbgDados.Columns[intCnt].Index;
    arrCols[Length(arrCols) - 1].strFieldName := dbgDados.Columns[intCnt].DataBinding.FieldName;
    arrCols[Length(arrCols) - 1].strCaption := dbgDados.Columns[intCnt].Caption;
    arrCols[Length(arrCols) - 1].intWidth := dbgDados.Columns[intCnt].Width;
    arrCols[Length(arrCols) - 1].blnVisible := dbgDados.Columns[intCnt].Visible;
    arrCols[Length(arrCols) - 1].blnInterno := fVerificaCampoInterno(dbgDados.Columns[intCnt].DataBinding.FieldName);

    If dbgDados.Columns[intCnt].PropertiesClass = TcxCheckBoxProperties Then
    Begin
      arrCols[Length(arrCols) - 1].blnCheckbox := True;
    End;

  End;

  Result := arrCols;
End;

function TCfgTelaConsultaOcorrenciaCRM.fVerificaCampoInterno(const strNomeCampo: String): Boolean;
Begin
  Result := (strNomeCampo = 'OCO_CODOCO') or
            (strNomeCampo = 'OCO_CODCLI') or
            (strNomeCampo = 'OCO_CODOPE') or
            (strNomeCampo = 'OCO_CODCOC') ;
End;

function TCfgTelaConsultaOcorrenciaCRM.fVerificaExisteCfg: Boolean;
Var
  qryExi: TUniQuery;
  SQLSelect: String;
begin
  SQLSelect := ' SELECT * ' +
               '   FROM COLCNF' +
               '  WHERE COL_NOMFOR = :NOMFOR ' +
               '    AND COL_CODEMP = :CODEMP ';
  If FBlnCfgUsu Then
    SQLSelect := SQLSelect + '  AND COL_CODOPE = :CODOPE ';
  If Not fEmptyStr(FNomeObjeto) Then
    SQLSelect := SQLSelect + '  AND COL_NOMGRD = :NOMGRD ';
  SQLSelect := SQLSelect + '  ORDER BY COL_COLORD ';

  qryExi := fCriaQuery;
  Try
    qryExi.DisableControls;
    qryExi.Close;
    qryExi.SQL.Clear;
    qryExi.SQL.Add(SQLSelect);

    qryExi.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryExi.ParamByName('CODEMP').AsString := FCodEmp;
    If FBlnCfgUsu Then
      qryExi.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    If Not fEmptyStr(FNomeObjeto) Then
      qryExi.ParamByName('NOMGRD').AsString := FNomeObjeto;
    qryExi.Open;

    Result :=  Not qryExi.IsEmpty;
  Finally
    FreeAndNil(qryExi);
  End;
end;

function TCfgTelaConsultaOcorrenciaCRM.GetBlnUsu: Boolean;
begin
  Result := FBlnCfgUsu;
end;

function TCfgTelaConsultaOcorrenciaCRM.GetSugestao: TCfGSug;
begin
  Result := FSugestao;
end;

function TCfgTelaConsultaOcorrenciaCRM.GetTip_FC: String;
begin
  Result := FTip_Fc;
end;

procedure TCfgTelaConsultaOcorrenciaCRM.pConfigurarGrid(const dbgDadosView: TcxGridDBTableViewCitel;
  const strDescricao: String;
  cds: TUniClientDataSet;
  var intRecNo: Integer;
  blnAlterarVisibilidade: Boolean = True);
begin
  FSugestao.pCarregarTamanhoFonteObj(strDescricao);

  inherited;
end;

procedure TCfgTelaConsultaOcorrenciaCRM.pIniciar(Const dbgDados: TcxGridCitel;
  Const dbgDadosView: TcxGridDBTableViewCitel;  strDescri: String = ''; strNomObj: String = '');
begin
  FNomeObjeto := strDescri;
  FstrDescri  := FNomeFormulario + '.' + FNomeObjeto;
  If pos('Calendario', FNomeObjeto) > 0  Then
  Begin
    pSetarColunasAgeCalendario(dbgDadosView, FNomeObjeto);
    pSetarEstadoPadrao(dbgDadosView);
    pSetarPadrao(dbgDadosView);
  End
  Else
  Begin
    pSetarEstadoPadrao(dbgDadosView);
    pConfigurarGrid(dbgDadosView);
  End;
end;

procedure TCfgTelaConsultaOcorrenciaCRM.pRestaurarPadrao(
  const dbgDados: TcxGridDBTableViewCitel);
begin
  If pos('Calendario', FNomeObjeto) > 0  Then
  Begin
    pSetarColunasAgeCalendario(dbgDados, FNomeObjeto);
    pSetarEstadoPadrao(dbgDados);
    pSetarPadrao(dbgDados);
  End
  Else
    pSetarPadrao(dbgDados);
end;

procedure TCfgTelaConsultaOcorrenciaCRM.pSetarColunasAgeCalendario(
  dbgDadosView: TcxGridDBTableViewCitel; strDescri: String);
begin
  If fVerificaExisteCfg Then
  Begin
    pConfigurarGrid(dbgDadosView);
  End
  Else
  Begin
    pSetarColunasPadraoAgeCalendario(dbgDadosView);
  End;
end;

procedure TCfgTelaConsultaOcorrenciaCRM.pSetarColunasPadraoAgeCalendario(
  dbgDadosView: TcxGridDBTableViewCitel);
var
  intCnt: Integer;
begin
  For intCnt := 0 To dbgDadosView.ColumnCount-1 Do
  Begin
    If (dbgDadosView.Columns[intCnt].DataBinding.FieldName = 'OCO_CODGOC') Then
    Begin
      dbgDadosView.Columns[intCnt].Visible := True;
      dbgDadosView.Columns[intCnt].Index := 0;
    End
    Else If (dbgDadosView.Columns[intCnt].DataBinding.FieldName = 'OCO_CODTOC') Then
    Begin
      dbgDadosView.Columns[intCnt].Visible := True;
      dbgDadosView.Columns[intCnt].Index := 1;
    End
    Else If (dbgDadosView.Columns[intCnt].DataBinding.FieldName = 'SIT_DESSIT') Then
    Begin
      dbgDadosView.Columns[intCnt].Visible := True;
      dbgDadosView.Columns[intCnt].Index := 2;
    End
    Else If (dbgDadosView.Columns[intCnt].DataBinding.FieldName = 'DOCUMENTO') Then
    Begin
      dbgDadosView.Columns[intCnt].Visible := True;
      dbgDadosView.Columns[intCnt].Index := 3;
    End
    Else If (dbgDadosView.Columns[intCnt].DataBinding.FieldName = 'NLEAD') Then
    Begin
      dbgDadosView.Columns[intCnt].Visible := True;
      dbgDadosView.Columns[intCnt].Index := 4;
    End
    Else
      dbgDadosView.Columns[intCnt].Visible := False;
  End;
end;

procedure TCfgTelaConsultaOcorrenciaCRM.SetBlnUsu(value: Boolean);
begin
  FBlnCfgUsu := Value;
end;

procedure TCfgTelaConsultaOcorrenciaCRM.SetSugestao(
  const AValue: TCfGSug);
begin
  FSugestao := AValue;
end;

procedure TCfgTelaConsultaOcorrenciaCRM.SetTip_FC(const Value: String);
begin
  FTip_Fc := Value;
end;

End.
