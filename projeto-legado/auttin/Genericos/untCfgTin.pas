{************************************************************************************}
{* Tela responsável pelas configurações de uma dll de tinta e como será exibida sua *}
{* tela de consulta                                                                 *}
{*********************************************************************************PH*}
unit untCfgTin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, AppEvnts, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, untIConfTinta, untFuncTinta, Uni, untFuncoesSimples, cxEditRepositoryItems, FileCtrl, Menus,
  untIConfiguradorTinta, untGerenciadorPropriedadesCx, DBClient, Provider, ActnList, cxDBExtLookupComboBox, ComCtrls,
  untConfConsulta, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, System.Actions, UniClientDataSet,
  frxClass, frxExportCSVTestabilidade, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCfgTin = class(TfrmPai)
    btnGravarConf: TBitBtnLocked;
    cerCfgTin: TcxEditRepository;
    erbiDiretorio: TcxEditRepositoryButtonItem;
    rdgSimNao: TcxEditRepositoryRadioGroupItem;
    rdgTravaPreco: TcxEditRepositoryRadioGroupItem;
    ertiSenha: TcxEditRepositoryTextItem;
    ertiNormal: TcxEditRepositoryTextItem;
    ersiNumero: TcxEditRepositorySpinItem;
    erciNumeroDecimal: TcxEditRepositoryCurrencyItem;
    actlstGeral: TActionList;
    actClose: TAction;
    erdiData: TcxEditRepositoryDateItem;
    pgcGeral: TPageControl;
    tsConf: TTabSheet;
    dbgDados: TcxGrid;
    dbgvDados: TcxGridDBTableView;
    dbcCodEmp: TcxGridDBColumn;
    dbcCodCfg: TcxGridDBColumn;
    dbcCodGru: TcxGridDBColumn;
    dbcDescri: TcxGridDBColumn;
    dbcValCfg: TcxGridDBColumn;
    dbglDados: TcxGridLevel;
    tsConsulta: TTabSheet;
    btnRestaurar: TBitBtnLocked;
    ersiNumero5: TcxEditRepositorySpinItem;
    erbiBotao: TcxEditRepositoryButtonItem;
    rdgTravaPrecoCon: TcxEditRepositoryRadioGroupItem;
    rdgTravaPrecoDil: TcxEditRepositoryRadioGroupItem;
    rdgAcuAbs: TcxEditRepositoryRadioGroupItem;
    erbiBotaoVenda: TcxEditRepositoryButtonItem;
    rdgEmbalagemShe: TcxEditRepositoryRadioGroupItem;
    rdgUniImpOP: TcxEditRepositoryRadioGroupItem;
    erbiBotaoBase: TcxEditRepositoryButtonItem;
    erbiBotaoLinha: TcxEditRepositoryButtonItem;
    erbiBotaoLinhasUtil: TcxEditRepositoryButtonItem;
    rdgTipoGeracao: TcxEditRepositoryRadioGroupItem;
    rdgCalcFormulacao: TcxEditRepositoryRadioGroupItem;
    rdgTpDosadora: TcxEditRepositoryRadioGroupItem;
    rdgQtdArquivo: TcxEditRepositoryRadioGroupItem;
    rdgArqDox: TcxEditRepositoryRadioGroupItem;
    rdgCalForSal: TcxEditRepositoryRadioGroupItem;
    rdgModoVendaConDil: TcxEditRepositoryRadioGroupItem;
    erciVolumeEmbalagem: TcxEditRepositorySpinItem;
    rdgDiluicao: TcxEditRepositoryRadioGroupItem;
    rdgAcrMob: TcxEditRepositoryRadioGroupItem;
    rdgMovEstMlGr: TcxEditRepositoryRadioGroupItem;
    erbiDiretorioNovo: TcxEditRepositoryButtonItem;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure erbiDiretorioPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure dbcValCfgGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure actCloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pgcGeralChange(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure dbgDadosExit(Sender: TObject);
    procedure erbiBotaoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure erbiBotaoPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure ersiNumeroPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure erbiBotaoVendaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure erbiBotaoVendaPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure erbiBotaoBasePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure erbiBotaoBasePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure erbiBotaoLinhaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure erbiBotaoLinhaPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure erbiBotaoLinhasUtilPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure rdgMovEstMlGrPropertiesEditValueChanged(Sender: TObject);
    procedure erbiDiretorioNovoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    conf: IConfTinta;
    qryConfiguracoes: TUniQuery;
    dtsConfiguracoes: TDataSource;
    cdsConfiguracoes: TUniClientDataSet;
    configuradorTinta: IConfiguradorTinta;
    gerenciadorPropriedadesCx: TGerenciadorPropriedadesCx;
    frmConsulta: TfrmConfConsulta;
    procedure CarregarConfiguracoes;
    procedure ConfigurarGerenciador;
    function IsAlterado(): Boolean;
    procedure SalvarConfs;
    function fSalvaLogTin(strCodEmp, strCodCfg, strValAnt, strValAtu: String): Boolean;
    procedure pAjustaGruposConfiguracoes;
    procedure pAjustaRelacaoCfgSisCfgTin;
  public
    constructor Create(AOwner: TComponent; const configuradorTinta: IConfiguradorTinta); reintroduce;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmCfgTin: TfrmCfgTin;

implementation

{$R *.dfm}

{ TfrmCfgTin }

procedure TfrmCfgTin.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmCfgTin.btnGravarConfClick(Sender: TObject);
begin
  frmConsulta.pSalvarConfs;
  SalvarConfs;
  fMensagem('', 'As configurações foram salvas com sucesso!', ['&OK']);
  Close;
end;

procedure TfrmCfgTin.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConsulta.pRestaurarPadrao;
end;

procedure TfrmCfgTin.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCfgTin.CarregarConfiguracoes;
begin
  qryConfiguracoes := fCriaQuery(Self);
  qryConfiguracoes.SQL.Text :=
    ' SELECT                               ' +
    '   C.*                                ' +
    ' FROM                                 ' +
    '   CFGTIN C                           ' +
    ' WHERE C.CFG_CODEMP = :CODEMP         ' +
    '   AND C.CFG_IDEPRO = :IDEPRO         ' +
    '   AND C.CFG_GRUCFG = "CONFIGURACOES" ';

  qryConfiguracoes.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryConfiguracoes.ParamByName('IDEPRO').AsString := configuradorTinta.IdePro;
  qryConfiguracoes.Open;

  cdsConfiguracoes := TUniClientDataSet.Create(Self);
  cdsConfiguracoes.FieldDefs.Add('CFG_CODEMP', ftString, 3);
  cdsConfiguracoes.FieldDefs.Add('CFG_IDEPRO', ftString, 3);
  cdsConfiguracoes.FieldDefs.Add('CFG_CODCFG', ftString, 20);
  cdsConfiguracoes.FieldDefs.Add('CFG_VALCFG', ftString, 255);
  cdsConfiguracoes.FieldDefs.Add('CFG_DESCRI', ftString, 255);
  cdsConfiguracoes.FieldDefs.Add('CFG_GRUCFG', ftString, 50);
  cdsConfiguracoes.CreateDataSet;

  while not qryConfiguracoes.Eof do
  begin
    if configuradorTinta.IsConfiguracaoExistente(qryConfiguracoes.FieldByName('CFG_CODCFG').AsString) then
    begin
      If ((qryConfiguracoes.FieldByName('CFG_CODCFG').AsString = 'USAFOR') And (fCfgSis('MODFOR') = '1')) Then
      Begin
        qryConfiguracoes.Next;
        Continue;
      End;

      cdsConfiguracoes.AppendRecord([
        qryConfiguracoes.FieldByName('CFG_CODEMP').AsString,
        qryConfiguracoes.FieldByName('CFG_IDEPRO').AsString,
        qryConfiguracoes.FieldByName('CFG_CODCFG').AsString,
        qryConfiguracoes.FieldByName('CFG_VALCFG').AsString,
        qryConfiguracoes.FieldByName('CFG_DESCRI').AsString,
        qryConfiguracoes.FieldByName('CFG_GRUCFG').AsString
      ]);
    end;
    qryConfiguracoes.Next;
  end;

  pAjustaGruposConfiguracoes;
  pAjustaRelacaoCfgSisCfgTin;

  dtsConfiguracoes := fCriaDataSource(cdsConfiguracoes);
  dbgvDados.DataController.DataSource := dtsConfiguracoes;
end;

procedure TfrmCfgTin.ConfigurarGerenciador;
begin
  gerenciadorPropriedadesCx := TGerenciadorPropriedadesCx.Create;

  gerenciadorPropriedadesCx[tpNormal] := ertiNormal;
  gerenciadorPropriedadesCx[tpDiretorio] := erbiDiretorio;
  gerenciadorPropriedadesCx[tpSimNao] := rdgSimNao;
  gerenciadorPropriedadesCx[tpTravaPreco] := rdgTravaPreco;
  gerenciadorPropriedadesCx[tpSenha] := ertiSenha;
  gerenciadorPropriedadesCx[tpNumero] := ersiNumero;
  gerenciadorPropriedadesCx[tpNumeroDecimal] := erciNumeroDecimal;
  gerenciadorPropriedadesCx[tpVolumeEmb] := erciVolumeEmbalagem;
  gerenciadorPropriedadesCx[tpData] := erdiData;
  gerenciadorPropriedadesCx[tpNumero_5] := ersiNumero5;
  gerenciadorPropriedadesCx[tpBotao] := erbiBotao;

  gerenciadorPropriedadesCx[tpTravaPrecoCon] := rdgTravaPrecoCon;
  gerenciadorPropriedadesCx[tpTravaPrecoDil] := rdgTravaPrecoDil;
  gerenciadorPropriedadesCx[tpAcuAbs]     := rdgAcuAbs;
  gerenciadorPropriedadesCx[tpBotaoVenda]    := erbiBotaoVenda;

  gerenciadorPropriedadesCx[tpEmbalagemShe]  := rdgEmbalagemShe;
  gerenciadorPropriedadesCx[tpUniImpOp]      := rdgUniImpOp;
  gerenciadorPropriedadesCx[tpTipoGeracao]   := rdgTipoGeracao;

  gerenciadorPropriedadesCx[tpBotaoBase]       := erbiBotaoBase;
  gerenciadorPropriedadesCx[tpBotaoLinha]      := erbiBotaoLinha;
  gerenciadorPropriedadesCx[tpBotaoLinhasUtil] := erbiBotaoLinhasUtil;
  gerenciadorPropriedadesCx[tpBotaoCalcFormulacao] := rdgCalcFormulacao;

  gerenciadorPropriedadesCx[TpDosadora] := rdgTpDosadora;
  gerenciadorPropriedadesCx[tpQtdArquivo] := rdgQtdArquivo;
  gerenciadorPropriedadesCx[tpArqDox] := rdgArqDox;
  gerenciadorPropriedadesCx[tpCalForSal] := rdgCalForSal;
  gerenciadorPropriedadesCx[tpModoVenda] := rdgModoVendaConDil;
  gerenciadorPropriedadesCx[tpDiluicao] := rdgDiluicao;
  gerenciadorPropriedadesCx[tpAcrMob] := rdgAcrMob;
  gerenciadorPropriedadesCx[tpMovEst] := rdgMovEstMlGr;
  gerenciadorPropriedadesCx[tpDiretorioNv] := erbiDiretorioNovo;
end;

constructor TfrmCfgTin.Create(AOwner: TComponent; const configuradorTinta: IConfiguradorTinta);
begin
  inherited Create(AOwner);
  Self.configuradorTinta := configuradorTinta;
  Self.conf := fGetConfTinta(configuradorTinta.IdePro);
  ConfigurarGerenciador;
  CarregarConfiguracoes;

  frmConsulta := TfrmConfConsulta.Create(Self,
    tsConsulta,
    Canvas,
    fGetConsultaTinta(configuradorTinta.IdePro));
end;

procedure TfrmCfgTin.dbcValCfgGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
var
  intIndex: Integer;
  intPropriedade: Integer;
begin
  intIndex := dbcCodCfg.Index;
  if Assigned(ARecord) and (ARecord.Values[intIndex] <> Null) then
  begin
    intPropriedade := configuradorTinta.GetPropriedade(ARecord.Values[intIndex]);
    if intPropriedade > 0 then
      AProperties := gerenciadorPropriedadesCx[intPropriedade].Properties;    
  end;
end;

procedure TfrmCfgTin.dbgDadosExit(Sender: TObject);
begin
  if cdsConfiguracoes.State in [dsEdit] then
    cdsConfiguracoes.Post;
end;

destructor TfrmCfgTin.Destroy;
begin
  if Assigned(qryConfiguracoes) then FreeAndNil(qryConfiguracoes);
  if Assigned(gerenciadorPropriedadesCx) then FreeAndNil(gerenciadorPropriedadesCx);
  if Assigned(cdsConfiguracoes) then FreeAndNil(cdsConfiguracoes);
  inherited;
end;

procedure TfrmCfgTin.erbiBotaoBasePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  dbcValCfg.EditValue := configuradorTinta.BotaoBaseClick(dbcCodCfg.DataBinding.Field.AsString,
                          dbcValCfg.DataBinding.Field.AsString);

end;

procedure TfrmCfgTin.erbiBotaoBasePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  configuradorTinta.BotaoBaseValidar(DisplayValue, ErrorText, Error);

end;

procedure TfrmCfgTin.erbiBotaoLinhaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  dbcValCfg.EditValue := configuradorTinta.BotaoLinhaClick(dbcCodCfg.DataBinding.Field.AsString,
                          dbcValCfg.DataBinding.Field.AsString);

end;

procedure TfrmCfgTin.erbiBotaoLinhaPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  configuradorTinta.BotaoLinhaValidar(DisplayValue, ErrorText, Error);

end;

procedure TfrmCfgTin.erbiBotaoLinhasUtilPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  dbcValCfg.EditValue := configuradorTinta.BotalLinhasUtilClick(dbcCodCfg.DataBinding.Field.AsString,
                          dbcValCfg.DataBinding.Field.AsString);

end;

procedure TfrmCfgTin.erbiBotaoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  dbcValCfg.EditValue := configuradorTinta.ConfigurarClick(dbcCodCfg.DataBinding.Field.AsString,
                          dbcValCfg.DataBinding.Field.AsString);
end;

procedure TfrmCfgTin.erbiBotaoPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  configuradorTinta.ConfigurarValidar(DisplayValue, ErrorText, Error);
end;

procedure TfrmCfgTin.erbiBotaoVendaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  dbcValCfg.EditValue := configuradorTinta.BotaoVendaClick(dbcCodCfg.DataBinding.Field.AsString,
                          dbcValCfg.DataBinding.Field.AsString);
end;

procedure TfrmCfgTin.erbiBotaoVendaPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  configuradorTinta.BotaoVendaValidar(DisplayValue, ErrorText, Error);
end;

procedure TfrmCfgTin.erbiDiretorioNovoPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  dbcValCfg.EditValue := ConfiguradorTinta.DiretorioValidarNv(dbcValCfg.EditValue, dbcCodCfg.DataBinding.Field.AsString);
end;

procedure TfrmCfgTin.erbiDiretorioPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
//var
//  strDir: string;
begin
//  If DirectoryExists(dbcValCfg.EditValue) Then
//    strDir := dbcValCfg.EditValue
//  Else
//    strDir := 'C:\';

//  If SelectDirectory('Selecione um diretório', strDir, strDir, [sdNewUI], Self) Then
//    dbcValCfg.EditValue := strDir;

  dbcValCfg.EditValue := configuradorTinta.DiretorioValidar(dbcValCfg.EditValue);
end;

procedure TfrmCfgTin.ersiNumeroPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  configuradorTinta.NumeroValidar(DisplayValue, ErrorText, Error, dbcCodCfg.DataBinding.Field.AsString);
end;

procedure TfrmCfgTin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pSetFocus(btnSair);
  if IsAlterado then
  begin
    if (fMensagem('ATENÇÃO', 'Existem configurações que foram alteradas, deseja salva-las?', ['&Sim', '&Não']) = 1) then
      SalvarConfs
    else
      cdsConfiguracoes.CancelUpdates;
  end;

  frmConsulta.Free;
  inherited;
end;

procedure TfrmCfgTin.FormShow(Sender: TObject);
begin
  inherited;
  pgcGeral.ActivePage := tsConf;
  pSetFocus(dbgDados);
  dbgvDados.NavigatorButtons.First.Click;
  dbgvDados.ViewData.Collapse(True);
end;

function TfrmCfgTin.IsAlterado: Boolean;
begin
  Result := False;
  Try
    Try
      qryConfiguracoes.Open;
      cdsConfiguracoes.Open;
      cdsConfiguracoes.DisableConstraints;
      cdsConfiguracoes.DisableControls;
      cdsConfiguracoes.First;

      while not cdsConfiguracoes.Eof do
      begin
        if not qryConfiguracoes.Locate('CFG_CODCFG', cdsConfiguracoes.FieldByName('CFG_CODCFG').AsString, []) then
        begin
          Result := True;
          Exit;
        end;

        if cdsConfiguracoes.FieldByName('CFG_VALCFG').AsString <> qryConfiguracoes.FieldByName('CFG_VALCFG').AsString then
        begin
          Result := True;
          Exit;
        end;

        cdsConfiguracoes.Next;
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    cdsConfiguracoes.EnableConstraints;
    cdsConfiguracoes.EnableControls;
  End;
end;

procedure TfrmCfgTin.pAjustaGruposConfiguracoes;
begin
  cdsConfiguracoes.First;
  while not cdsConfiguracoes.Eof do
  begin
    if configuradorTinta.IsGrupoExistente(cdsConfiguracoes.FieldByName('CFG_CODCFG').AsString) then
    Begin
      cdsConfiguracoes.Edit;
      cdsConfiguracoes.FieldByName('CFG_GRUCFG').AsString := configuradorTinta.GetGrupo(cdsConfiguracoes.FieldByName('CFG_CODCFG').AsString);
      cdsConfiguracoes.Post;
    End;

    cdsConfiguracoes.Next;
  end;
end;

procedure TfrmCfgTin.pAjustaRelacaoCfgSisCfgTin;
var
  qryCfgSis: TUniQuery;
begin
  cdsConfiguracoes.First;
  while not cdsConfiguracoes.Eof do
  begin
    if (configuradorTinta.IsCfgSisTintaExistente(cdsConfiguracoes.FieldByName('CFG_CODCFG').AsString)) And
       (fEmptyStr(cdsConfiguracoes.FieldByName('CFG_VALCFG').AsString)) then
    Begin
      Try
        qryCfgSis := fCriaQuery;
        With qryCfgSis Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(' SELECT SIS_VALCFG            ');
          SQL.Add('   FROM CFGSIS                ');
          SQL.Add('  WHERE SIS_CODEMP = :CODEMP  ');
          SQL.Add('    AND SIS_CODCFG = :CODCFG  ');
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('CODCFG').AsString := configuradorTinta.GetCfgSisTinta(cdsConfiguracoes.FieldByName('CFG_CODCFG').AsString);
          Open;

          If (Not fEmptyStr(FieldByName('SIS_VALCFG').AsString)) Then
          Begin
            cdsConfiguracoes.Edit;
            cdsConfiguracoes.FieldByName('CFG_VALCFG').AsString := FieldByName('SIS_VALCFG').AsString;
            cdsConfiguracoes.Post;

            If qryConfiguracoes.Locate('CFG_CODCFG', cdsConfiguracoes.FieldByName('CFG_CODCFG').AsString, []) Then
            Begin
              qryConfiguracoes.Edit;
              qryConfiguracoes.FieldByName('CFG_VALCFG').AsString := cdsConfiguracoes.FieldByName('CFG_VALCFG').AsString;
              qryConfiguracoes.Post;
            End;
          End;
        End;
      Finally
        FreeAndNil(qryCfgSis);
      End;
    End;

    cdsConfiguracoes.Next;
  end;
end;

procedure TfrmCfgTin.pgcGeralChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcGeral.ActivePage = tsConsulta);
end;

procedure TfrmCfgTin.rdgMovEstMlGrPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  configuradorTinta.MovEstValidar(Sender, dbcCodCfg.DataBinding.Field.AsString);
end;

function TfrmCfgTin.fSalvaLogTin(strCodEmp, strCodCfg, strValAnt, strValAtu: String): Boolean;
var
  qryLogTin: TUniQuery;
begin
  Result := True;
  Try
    Try
      qryLogTin := fCriaQuery(Nil);
      With qryLogTin Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM LOGTIN WHERE FALSE');
        Open;

        qryLogTin.Insert;
        qryLogTin.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGTIN', VS_strCodEmp);
        qryLogTin.FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
        qryLogTin.FieldByName('LOG_HORALT').AsDateTime := fTime();
        qryLogTin.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
        qryLogTin.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
        qryLogTin.FieldByName('LOG_EMPCFG').AsString   := strCodEmp;
        qryLogTin.FieldByName('LOG_CODCFG').AsString   := strCodCfg;
        qryLogTin.FieldByName('LOG_VALANT').AsString   := strValAnt;
        qryLogTin.FieldByName('LOG_IDEPRO').AsString   := configuradorTinta.IdePro;
        qryLogTin.FieldByName('LOG_VALATU').AsString   := strValAtu;
        qryLogTin.Post;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro('Erro ao gravar LOGTIN', '[fSalvaLogTin]');
      End;
    End;
  Finally
    FreeAndNil(qryLogTin);
  End;
end;

procedure TfrmCfgTin.SalvarConfs;
begin
  Try
    Try
      cdsConfiguracoes.DisableConstraints;
      cdsConfiguracoes.DisableControls;
      cdsConfiguracoes.First;

      while not cdsConfiguracoes.Eof do
      begin
        if qryConfiguracoes.Locate('CFG_CODCFG', cdsConfiguracoes.FieldByName('CFG_CODCFG').AsString, []) then
        begin
          if qryConfiguracoes.FieldByName('CFG_VALCFG').AsString <> cdsConfiguracoes.FieldByName('CFG_VALCFG').AsString then
          begin
            if fSalvaLogTin(qryConfiguracoes.FieldByName('CFG_CODEMP').AsString, qryConfiguracoes.FieldByName('CFG_CODCFG').AsString,
                            qryConfiguracoes.FieldByName('CFG_VALCFG').AsString, cdsConfiguracoes.FieldByName('CFG_VALCFG').AsString) Then
            begin
              qryConfiguracoes.Edit;
              qryConfiguracoes.FieldByName('CFG_VALCFG').AsString := cdsConfiguracoes.FieldByName('CFG_VALCFG').AsString;
              qryConfiguracoes.Post;
            end;
          end;
        end;

        cdsConfiguracoes.Next;
      end;
    Except
      on E: Exception do
      begin
        pMensagensErro('Erro ao gravar as configurações da tinta', '[SalvarConfs]');
      end;
    End;
  Finally
    cdsConfiguracoes.EnableConstraints;
    cdsConfiguracoes.EnableControls;
  End;
end;

end.
