unit untCfgCondicaoPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, untTypesSistema,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, cxCheckBox, MemDS, DBAccess, Uni;

type
  TfrmCfgCondicaoPagamento = class(TfrmPaiSimples)
    Panel1: TPanel;
    pnlAtividade: TPanel;
    edtDesAti: TEditFocus;
    edtCodAti: TEditFocus;
    lblAtividade: TLabel;
    btnAtividade: TBitBtnLocked;
    grdAtividadeDBTableView: TcxGridDBTableView;
    grdAtividadeLevel: TcxGridLevel;
    grdAtividade: TcxGrid;
    pnlPagamento: TPanel;
    lblPagamento: TLabel;
    edtCodPag: TEditFocus;
    edtDesPag: TEditFocus;
    btnPagamento: TBitBtnLocked;
    grdPagamentoDBTableView: TcxGridDBTableView;
    grdPagamentoLevel: TcxGridLevel;
    grdPagamento: TcxGrid;
    cdsAtividade: TUniClientDataSet;
    cdsPagamento: TUniClientDataSet;
    dtsAtividade: TDataSource;
    dtsPagamento: TDataSource;
    cdsAtividadeCODATI: TStringField;
    cdsAtividadeDESATI: TStringField;
    grdAtividadeCODATI: TcxGridDBColumn;
    grdAtividadeDESATI: TcxGridDBColumn;
    cdsPagamentoCODPAG: TStringField;
    cdsPagamentoDESPAG: TStringField;
    grdPagamentoCODPAG: TcxGridDBColumn;
    grdPagamentoDESPAG: TcxGridDBColumn;
    grdPagamentoSEGPAG: TcxGridDBColumn;
    cdsPagamentoSEGPAG: TBooleanField;
    Panel3: TPanel;
    btnGravar: TBitBtnLocked;
    grdPagamentoCODATI: TcxGridDBColumn;
    cdsPagamentoCODATI: TStringField;
    UniQuery1: TUniQuery;
    procedure FormShow(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPagKeyPress(Sender: TObject; var Key: Char);
    procedure btnAtividadeClick(Sender: TObject);
    procedure btnPagamentoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsPagamentoAfterPost(DataSet: TDataSet);
    procedure grdPagamentoSEGPAGPropertiesChange(Sender: TObject);
    procedure cdsAtividadeAfterScroll(DataSet: TDataSet);
    procedure grdPagamentoDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    blnCarregando: Boolean;
    function fPermiteGravarCondição: Boolean;
    procedure pExcluiCondicaoPagamento;
    function fSalvarPagamento: Boolean;
    function fValidaCondicoes: Boolean;
    function fCarregaPagamento: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untConsultas, untFuncoesSimples;

{$R *.dfm}

{ TfrmCfgCondicaoPagamento }

procedure TfrmCfgCondicaoPagamento.btnAtividadeClick(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtCodAti.Text) then
  begin
    fMensagem('ATENÇÃO!','Informe a atividade!',['&Ok']);
  end
  else if cdsAtividade.Locate('CODATI', edtCodAti.Text,[]) then
  begin
    fMensagem('ATENÇÃO!','Essa atividade já está incluída!',['&Ok']);
  end
  else
  begin
    if fValidaCampos(edtCodAti, True) then
    begin
      cdsAtividade.Append;
      cdsAtividadeCODATI.AsString := edtCodAti.Text;
      cdsAtividadeDESATI.AsString := edtDesAti.Text;
      cdsAtividade.Post;

    end;
  end;
  edtCodAti.Clear;
  edtDesAti.Clear;
  pSetFocus(edtCodAti);
end;

procedure TfrmCfgCondicaoPagamento.btnGravarClick(Sender: TObject);
begin
  inherited;

  if not fValidaCondicoes then
    Exit;

  if fSalvarPagamento then
    fMensagem('ATENÇÃO!','informações salvas com sucesso!',['&Ok']);  
end;

procedure TfrmCfgCondicaoPagamento.btnPagamentoClick(Sender: TObject);
begin
  inherited;
  if not fPermiteGravarCondição then
  begin
    fMensagem('ATENÇÃO!','Selecione a atividade para incluir a condição de pagamento!',['&Ok']);
    Exit;
  end;

  if fEmptyStr(edtCodPag.Text) then
  begin
    fMensagem('ATENÇÃO!','Informe a condição de pagamento!',['&Ok']);
  end 
  else if cdsPagamento.Locate('CODATI;CODPAG', VarArrayOf([cdsAtividadeCODATI.AsString,edtCodPag.Text]),[]) then
  begin
    fMensagem('ATENÇÃO!','Essa condição de pagamento já está incluída para esta atividade!',['&Ok']);
  end  
  else
  begin
    if fValidaCampos(edtCodPag, True) then
    begin
      cdsPagamento.DisableControls;
      try
        cdsPagamento.Append;
        cdsPagamentoCODATI.AsString := IIF(cdsAtividade.RecordCount > 0, cdsAtividadeCODATI.AsString, '000');
        cdsPagamentoCODPAG.AsString := edtCodPag.Text;
        cdsPagamentoDESPAG.AsString := edtDesPag.Text;

        if cdsPagamento.RecordCount = 0 then
          cdsPagamentoSEGPAG.AsBoolean := True
        else
          cdsPagamentoSEGPAG.AsBoolean := False;

        cdsPagamento.Post;
      finally
        cdsPagamento.EnableControls;
      end;
    end;
  end;

  edtCodPag.Clear;
  edtDesPag.Clear;
  pSetFocus(edtCodPag);
end;

procedure TfrmCfgCondicaoPagamento.cdsAtividadeAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if cdsAtividade.RecNo < 1 then
    Exit;

  cdsPagamento.Filtered := False;
  cdsPagamento.Filter := 'CODATI = ' + cdsAtividadeCODATI.AsString;
  cdsPagamento.Filtered := true;
end;

procedure TfrmCfgCondicaoPagamento.cdsPagamentoAfterPost(DataSet: TDataSet);
var
  LRecNo: integer;
begin
  inherited;
  if blnCarregando then
    Exit;
    
  if cdsPagamentoSEGPAG.AsBoolean = True then
  begin
    cdsPagamento.DisableControls;
    LRecNo := cdsPagamento.RecNo;

    try
      cdsPagamento.First;

      while not cdsPagamento.Eof do
      begin
        if LRecNo <> cdsPagamento.RecNo then
        begin
          if cdsPagamentoSEGPAG.AsBoolean = True then
          begin
            cdsPagamento.Edit;
            cdsPagamentoSEGPAG.AsBoolean := False;
            cdsPagamento.Post;
          end;
        end;
        cdsPagamento.Next;
      end;
    finally
      cdsPagamento.RecNo := LRecNo;
      cdsPagamento.EnableControls;
    end;
  end;
end;

procedure TfrmCfgCondicaoPagamento.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
var
  arrAtiv: TConsultasArray;
begin
  inherited;
  if Key = #13 then
  begin
    edtCodAti.Text := fStrZero(edtCodAti.Text, 3);
    fValidaCampos(edtCodAti, True);
  end
  else
  begin
    If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtiv) Then
    Begin
      if fValidaCampos(edtCodAti, True) then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmCfgCondicaoPagamento.edtCodPagKeyPress(Sender: TObject;
  var Key: Char);
var
  arrPagCnd: TConsultasArray;
begin
  inherited;
  if Key = #13 then
  begin
    edtCodPag.Text := fStrZero(edtCodPag.Text, 3);
    fValidaCampos(edtCodPag, True);
  end
  else
  begin
    If fPesqCondicoesPgto(Self, edtCodPag, edtDesPag, Nil, Key, arrPagCnd) Then
    Begin
      if fValidaCampos(edtCodPag, True) then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

function TfrmCfgCondicaoPagamento.fCarregaPagamento: Boolean;
var
  LQryCarregar: TUniQuery;
begin
  blnCarregando := True;
  LQryCarregar := fCriaQuery;
  cdsAtividade.DisableControls;
  cdsPagamento.DisableControls;
  cdsAtividade.EmptyDataSet;
  cdsPagamento.EmptyDataSet;
                                           
  try
    Result := False;
    LQryCarregar.Close;
    LQryCarregar.SQL.Clear;
    LQryCarregar.SQL.Add('SELECT * FROM ATICFG WHERE CFG_CODEMP = :CODEMP');
    LQryCarregar.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryCarregar.ExecSQL;

    if LQryCarregar.IsEmpty then
    begin
      cdsAtividade.Append;
      cdsAtividadeCODATI.AsString := '000';
      cdsAtividadeDESATI.AsString := 'TODAS';
      cdsAtividade.Post;

      Result := True;
      Exit;    
    end;

    while not LQryCarregar.Eof do
    begin
      cdsAtividade.Append;
      cdsAtividadeCODATI.AsString := LQryCarregar.FieldByName('CFG_CODATI').AsString;
      cdsAtividadeDESATI.AsString := LQryCarregar.FieldByName('CFG_DESATI').AsString;
      cdsAtividade.Post;
      LQryCarregar.Next;
    end;

    LQryCarregar.Close;
    LQryCarregar.SQL.Clear;
    LQryCarregar.SQL.Add('SELECT * FROM CNDCFG WHERE CFG_CODEMP = :CODEMP');
    LQryCarregar.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryCarregar.ExecSQL;

    while not LQryCarregar.Eof do
    begin
      cdsPagamento.Append;
      cdsPagamentoCODATI.AsString  := LQryCarregar.FieldByName('CFG_CODATI').AsString;
      cdsPagamentoCODPAG.AsString  := LQryCarregar.FieldByName('CFG_CODCND').AsString;
      cdsPagamentoDESPAG.AsString  := LQryCarregar.FieldByName('CFG_DESCND').AsString;
      cdsPagamentoSEGPAG.AsBoolean := LQryCarregar.FieldByName('CFG_SUGEST').AsBoolean;
      cdsPagamento.Post;
      LQryCarregar.Next;
    end;    
                                      
    Result := True;
  finally
    FreeAndNil(LQryCarregar);
    cdsAtividade.EnableControls;
    cdsPagamento.EnableControls;
    cdsAtividade.First;
    cdsPagamento.First;
    blnCarregando := False;
  end;
end;

procedure TfrmCfgCondicaoPagamento.FormCreate(Sender: TObject);
begin
  inherited;
  cdsAtividade.CreateDataSet;
  cdsPagamento.CreateDataSet;
  blnCarregando := False;
end;

procedure TfrmCfgCondicaoPagamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F10: btnGravar.Click;  
  end;
end;

procedure TfrmCfgCondicaoPagamento.FormShow(Sender: TObject);
begin
  inherited;
  if not fCarregaPagamento then
    fMensagem('ATENÇÃO!','Ocorreu um erro ao carregar as informações!',['&Ok']);
    
  pSetFocus(edtCodAti);
end;

function TfrmCfgCondicaoPagamento.fPermiteGravarCondição: Boolean;
begin
  if cdsAtividade.RecordCount <= 1 then
    Exit(True);

  if cdsAtividade.RecNo > 0 then
    Exit(True);

  Result := False;
end;

function TfrmCfgCondicaoPagamento.fSalvarPagamento: Boolean;
var
  LQrySalvar: TUniQuery;
begin
  LQrySalvar := fCriaQuery;
  cdsAtividade.DisableControls;
  cdsPagamento.DisableControls;

  try
    try
      Result := False;
      
      cdsAtividade.First;

      fStartTransaction;
    
      LQrySalvar.Close;
      LQrySalvar.SQL.Clear;
      LQrySalvar.SQL.Add('DELETE FROM CNDCFG WHERE CFG_CODEMP = :CODEMP');
      LQrySalvar.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQrySalvar.ExecSQL;

      LQrySalvar.Close;
      LQrySalvar.SQL.Clear;
      LQrySalvar.SQL.Add('DELETE FROM ATICFG WHERE CFG_CODEMP = :CODEMP');
      LQrySalvar.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQrySalvar.ExecSQL;

      LQrySalvar.Close;
      LQrySalvar.SQL.Clear;
      LQrySalvar.SQL.Add('INSERT INTO ATICFG(AUTOINCREM, CFG_CODEMP, CFG_CODATI, CFG_DESATI)');
      LQrySalvar.SQL.Add('VALUES(:AUTINC, :CODEMP, :CODATI, :DESATI)');

      while not cdsAtividade.Eof do
      begin
        LQrySalvar.ParamByName('AUTINC').AsString := fRetAutoIncrem('ATICFG',VS_strCodEmp);
        LQrySalvar.ParamByName('CODEMP').AsString := VS_strCodEmp;
        LQrySalvar.ParamByName('CODATI').AsString := cdsAtividadeCODATI.AsString;
        LQrySalvar.ParamByName('DESATI').AsString := cdsAtividadeDESATI.AsString;
        LQrySalvar.ExecSQL;
        cdsAtividade.Next;
      end;

      cdsPagamento.Filtered := False;
      cdsPagamento.Filter := EmptyStr;
      cdsPagamento.Filtered := True;
      cdsPagamento.First;
      

      LQrySalvar.Close;
      LQrySalvar.SQL.Clear;
      LQrySalvar.SQL.Add('INSERT INTO CNDCFG(AUTOINCREM, CFG_CODATI, CFG_CODEMP, CFG_CODCND, CFG_DESCND, CFG_SUGEST)');
      LQrySalvar.SQL.Add('VALUES(:AUTINC, :CODATI, :CODEMP, :CODCND, :DESCND, :SUGEST)');
        
      while not cdsPagamento.Eof do
      begin
        LQrySalvar.ParamByName('AUTINC').AsString  := fRetAutoIncrem('CNDCFG',VS_strCodEmp);
        LQrySalvar.ParamByName('CODATI').AsString  := cdsPagamentoCODATI.AsString;
        LQrySalvar.ParamByName('CODEMP').AsString  := VS_strCodEmp;
        LQrySalvar.ParamByName('CODCND').AsString  := cdsPagamentoCODPAG.AsString;
        LQrySalvar.ParamByName('DESCND').AsString  := cdsPagamentoDESPAG.AsString;
        LQrySalvar.ParamByName('SUGEST').AsBoolean := cdsPagamentoSEGPAG.AsBoolean;
        LQrySalvar.ExecSQL;
        cdsPagamento.Next;
      end;    

      Result := fCommit;                                  
    except
      fMensagem('ATENÇÃO!','Ocorreu um erro na gravação!',['&Ok']);
      fRollBack;
      Result := False;
    end;
  finally
    cdsAtividade.First;
    cdsPagamento.First;  
    cdsAtividade.EnableControls;
    cdsPagamento.EnableControls;
    FreeAndNil(LQrySalvar);
  end;
end;

function TfrmCfgCondicaoPagamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strCampoTabela : String;
begin
  strCampoTabela := '';
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtCodAti) Then
    Begin
      If Not fEmptyStr(edtCodAti.Text) Then
      Begin
        strCampoTabela := fCampoTabela('ATI_DESATI','CADATI',['ATI_CODATI'],[edtCodAti.Text]);
        if fEmptyStr(strCampoTabela) then
          Result := False
        else
          edtDesAti.Text := strCampoTabela;
      End;
    End
    Else If (Sender = edtCodPag) Then
    Begin
      strCampoTabela := fCampoTabela('CND_DESCRI','CADCND',['CND_CODIGO'],[edtCodPag.Text]);
      if fEmptyStr(strCampoTabela) then
        Result := False
      else
        edtDesPag.Text := strCampoTabela;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCfgCondicaoPagamento.fValidaCondicoes: Boolean;
begin
  Result := True;

  cdsAtividade.First;
  cdsPagamento.First;

  while not cdsAtividade.Eof do
  begin    
    cdsPagamento.Filtered := False;
    cdsPagamento.Filter := 'CODATI = ' + cdsAtividadeCODATI.AsString;
    cdsPagamento.Filtered := True;
    cdsPagamento.First;

    if cdsPagamento.RecordCount = 0 then
    begin
      fMensagem('ATENÇÃO!','A atividade: ' + cdsAtividadeCODATI.AsString + ' - ' + cdsAtividadeDESATI.AsString + ' não tem condição de pagamento vinculada.',['&Ok']);
      Result := False;
      Exit;
    end;

    cdsAtividade.Next;
  end;
end;

procedure TfrmCfgCondicaoPagamento.grdPagamentoDBTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if cdsPagamento.RecordCount = 0 then
    Exit;
  
  case key of
    VK_DELETE: if fMensagem('','Deseja excluir a condição de Pagamento?',['&Sim', '&Não'],2) = 1 then
               begin  
                 pExcluiCondicaoPagamento;
               end;
  end;
end;

procedure TfrmCfgCondicaoPagamento.grdPagamentoSEGPAGPropertiesChange(
  Sender: TObject);
begin
  inherited;
  cdsPagamento.Post;
end;

procedure TfrmCfgCondicaoPagamento.pExcluiCondicaoPagamento;
var
  LEhSugestao: Boolean;
begin
  LEhSugestao := cdsPagamentoSEGPAG.AsBoolean;
  cdsPagamento.Delete;

  if LEhSugestao then
  begin  
    if cdsPagamento.RecordCount > 0 then
    begin
      cdsPagamento.DisableControls;
      try
        cdsPagamento.First;
        cdsPagamento.Edit;
        cdsPagamentoSEGPAG.AsBoolean := True;
        cdsPagamento.Post; 
      finally
        cdsPagamento.EnableControls;
      end;
    end;
  end;
end;

end.
