unit untLiberacaoCNPJ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni, untGravando, untObservacao;

type
  TfrmLiberacaoCNPJ = class(TfrmPaiSimples)
    pnlPrincipal: TPanel;
    btnLibCNPJ: TBitBtnLocked;
    cxgrdLibCNPJ: TcxGridDBTableViewCitel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitel1: TcxGridCitel;
    cdsLibCNPJ: TUniClientDataSet;
    dtsLibCNPJ: TDataSource;
    cdsLibCNPJDATAHORA: TStringField;
    cdsLibCNPJCODCLI: TStringField;
    cdsLibCNPJC_G_C_: TStringField;
    cdsLibCNPJNOMCLI: TStringField;
    cdsLibCNPJFANSOB: TStringField;
    cdsLibCNPJNOMCID: TStringField;
    cdsLibCNPJESTADO: TStringField;
    cdsLibCNPJDESSIT: TStringField;
    cdsLibCNPJOBSERV: TStringField;
    cxgrdLibCNPJ_DATAHORA: TcxGridDBColumn;
    cxgrdLibCNPJ_CODCLI: TcxGridDBColumn;
    cxgrdLibCNPJ_C_G_C_: TcxGridDBColumn;
    cxgrdLibCNPJ_NOMCLI: TcxGridDBColumn;
    cxgrdLibCNPJ_FANSOB: TcxGridDBColumn;
    cxgrdLibCNPJ_NOMCID: TcxGridDBColumn;
    cxgrdLibCNPJ_ESTADO: TcxGridDBColumn;
    cxgrdLibCNPJ_DESSIT: TcxGridDBColumn;
    cxgrdLibCNPJ_OBSERV: TcxGridDBColumn;
    cdsLibCNPJAUTINC: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLibCNPJClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure pCarregaRegistros;
    procedure pLiberarCNPJ;
    function fLiberaCNPJ(const ASituacao, AObservacao, AAutInc: String): Boolean;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmLiberacaoCNPJ.btnLibCNPJClick(Sender: TObject);
begin
  inherited;
  pLiberarCNPJ;
end;

function TfrmLiberacaoCNPJ.fLiberaCNPJ(const ASituacao, AObservacao,
  AAutInc: String): Boolean;
var
  LQryLibera: TUniQuery;
begin
  LQryLibera := fCriaQuery;

  try
    Result := False;

    LQryLibera.Close;
    LQryLibera.SQL.Clear;
    LQryLibera.SQL.Add('UPDATE BLODEN');
    LQryLibera.SQL.Add('SET DEN_DESSIT = :DESSIT,');
    LQryLibera.SQL.Add('DEN_OBSERV = :OBSERV');
    LQryLibera.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    LQryLibera.ParamByName('DESSIT').AsString := ASituacao;
    LQryLibera.ParamByName('OBSERV').AsString := AObservacao;
    LQryLibera.ParamByName('AUTINC').AsString := AAutInc;

    LQryLibera.ExecSQL;

    Result := True;
  finally
    FreeAndNil(LQryLibera);
  end;
end;

procedure TfrmLiberacaoCNPJ.FormCreate(Sender: TObject);
begin
  inherited;

  cdsLibCNPJ.CreateDataSet;
end;

procedure TfrmLiberacaoCNPJ.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if Key = VK_F10 then
    btnLibCNPJ.Click;

  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmLiberacaoCNPJ.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModalA(pCarregaRegistros, 'Aguarde... Carregando informações.', '' );
end;

procedure TfrmLiberacaoCNPJ.pCarregaRegistros;
var
  LQryRegistros: TUniQuery;
begin
  LQryRegistros := fCriaQuery;

  try
    LQryRegistros.Close;
    LQryRegistros.SQL.Clear;
    LQryRegistros.SQL.Add('SELECT CONCAT(DATE_FORMAT(B.DEN_DTACON,"%d/%m/%Y"), " ",B.DEN_HRACON) AS DATAHORA, B.AUTOINCREM AS AUTINC,');
    LQryRegistros.SQL.Add('       B.DEN_CODCLI AS CODCLI, B.DEN_C_G_C_ AS C_G_C_, CL.CLI_NOMCLI AS NOMCLI, CL.CLI_FANSOB AS FANSOB,');
    LQryRegistros.SQL.Add('       CI.CID_NOMCID AS NOMCID, B.DEN_ESTADO AS ESTADO, B.DEN_DESSIT AS DESSIT, B.DEN_OBSERV AS OBSERV');
    LQryRegistros.SQL.Add('FROM BLODEN B');
    LQryRegistros.SQL.Add('INNER JOIN CADCLI CL');
    LQryRegistros.SQL.Add('ON B.DEN_CODCLI = CL.CLI_CODCLI');
    LQryRegistros.SQL.Add('LEFT JOIN CADCID CI');
    LQryRegistros.SQL.Add('ON CL.CLI_CODCID = CI.CID_CODCID');
    LQryRegistros.SQL.Add('WHERE B.DEN_DESSIT = "Não habilitado"');
    LQryRegistros.SQL.Add('ORDER BY NOMCLI');
    LQryRegistros.Open;

    if LQryRegistros.IsEmpty then
      Exit;

    LQryRegistros.First;
    cdsLibCNPJ.EmptyDataSet;

    cdsLibCNPJ.DisableControls;
    try
      while not LQryRegistros.Eof do
      begin
        cdsLibCNPJ.Append;
        cdsLibCNPJDATAHORA.AsString := LQryRegistros.FieldByName('DATAHORA').AsString;
        cdsLibCNPJCODCLI.AsString := LQryRegistros.FieldByName('CODCLI').AsString;
        cdsLibCNPJC_G_C_.AsString := fFormataCpfCgc(LQryRegistros.FieldByName('C_G_C_').AsString, fSetaPais);
        cdsLibCNPJNOMCLI.AsString := LQryRegistros.FieldByName('NOMCLI').AsString;
        cdsLibCNPJFANSOB.AsString := LQryRegistros.FieldByName('FANSOB').AsString;
        cdsLibCNPJNOMCID.AsString := LQryRegistros.FieldByName('NOMCID').AsString;
        cdsLibCNPJESTADO.AsString := LQryRegistros.FieldByName('ESTADO').AsString;
        cdsLibCNPJDESSIT.AsString := LQryRegistros.FieldByName('DESSIT').AsString;
        cdsLibCNPJOBSERV.AsString := LQryRegistros.FieldByName('OBSERV').AsString;
        cdsLibCNPJAUTINC.AsString := LQryRegistros.FieldByName('AUTINC').AsString;
        cdsLibCNPJ.Post;
        LQryRegistros.Next;
      end;
    finally
      cdsLibCNPJ.EnableControls;
    end;
  finally
    FreeAndNil(LQryRegistros);
  end;
end;

procedure TfrmLiberacaoCNPJ.pLiberarCNPJ;
var
  LMensagemErro: String;
  LSituacao: String;
  LObservacao: String;
  LfrmObservacao: TfrmObservacao;
begin
  if not Assigned(cdsLibCNPJ) then
    Exit;

  if not cdsLibCNPJ.Active then
    Exit;

  if cdsLibCNPJ.RecordCount <= 0 then
    Exit;

  if cdsLibCNPJ.RecNo <= 0 then
    Exit;

  If fMensagem('', 'Deseja liberar o cliente '+cdsLibCNPJNOMCLI.AsString+' para emissão de documento fiscal?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  LMensagemErro := Copy(cdsLibCNPJOBSERV.AsString, Pos('Não habilitado', cdsLibCNPJOBSERV.AsString)+Length('Não habilitado')+3,Length(cdsLibCNPJOBSERV.AsString));
  LSituacao := 'Habilitado';
  LObservacao := 'Habilitado manualmente pelo Autcom - Usuário: '+strLoginUsuarioLogado+' ('+LMensagemErro+')';

  if not fLiberaCNPJ(LSituacao, LObservacao, cdsLibCNPJAUTINC.AsString) then
    Exit;

  pCriarFormularios(TfrmObservacao, LfrmObservacao);

  try
    LfrmObservacao.lblMensagem.Caption := '';
    LfrmObservacao.memObs.Clear;
    LfrmObservacao.memObs.Lines.Add('-----------------------------------------------------');
    LfrmObservacao.memObs.Lines.Add('CNPJ '+fFormataCpfCgc(cdsLibCNPJC_G_C_.AsString, fSetaPais)+'');
    LfrmObservacao.memObs.Lines.Add(''+cdsLibCNPJNOMCLI.AsString+'');
    LfrmObservacao.memObs.Lines.Add('-----------------------------------------------------');
    LfrmObservacao.memObs.Lines.Add('Liberado para emissão de documentos fiscais !');
    LfrmObservacao.memObs.Lines.Add('-----------------------------------------------------');
    LfrmObservacao.memObs.Alignment := taCenter;
    LfrmObservacao.ShowModal;
    TfrmGravando.fExecutarModalA(pCarregaRegistros, 'Aguarde... Carregando informações.', '' );
  finally
    pFreeAndNil(LfrmObservacao);
  end;
end;

end.
