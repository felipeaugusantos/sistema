unit untCadGruposAnaliseProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.Mask,
  MaskEditFocus, Vcl.DBCtrls, DBEditFocus, untZClient, EditFocus;

type
  TfrmCadGruposAnaliseProducao = class(TfrmPaiCad)
    cxgGruDetTbv: TcxGridDBTableViewCitel;
    cxgGruDetLvl: TcxGridLevel;
    cxgGruDet: TcxGridCitel;
    dtsGruGer: TDataSource;
    cxgGruDetTbvGRD_CODGRU: TcxGridDBColumn;
    pnlCabecalho: TPanel;
    dbeCodGru: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    pnlLinhaGrupo: TPanel;
    Label3: TLabel;
    mskLinGru: TMaskEditFocus;
    cxgGruDetTbvGRU_DESGRU: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    cdsGruDet : TZClient;
    procedure pCdsGruDetAfterOpen(DataSet: TDataSet);
    procedure pQryTabelaAfterScroll(DataSet: TDataSet);
    procedure pQryTabelaAfterCancel(DataSet: TDataSet);
    procedure pQryTabelaAfterPost(DataSet: TDataSet);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadGruposAnaliseProducao: TfrmCadGruposAnaliseProducao;

implementation

uses
  untFuncoesSimples, untFuncoesConsulta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadGruposAnaliseProducao.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    fRollBack;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGruposAnaliseProducao.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    fRollBack;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGruposAnaliseProducao.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescri);
end;

procedure TfrmCadGruposAnaliseProducao.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
begin
  inherited;

  chrKey := '/';
  if fPesqGruposAnaliseProducao(Self, Nil, Nil, qryTabela, chrKey) then
  begin
    pSetFocus(btnAlterar);
  end;

end;

procedure TfrmCadGruposAnaliseProducao.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'GRUGER';
  strNomeCampo        := 'GRG_CODIGO';
  qryTabela           := fCriaQuery(Self);

  cdsGruDet           := TZClient.Create(Self);
  cdsGruDet.qryQuery.SQL.Add('SELECT                                         ');
  cdsGruDet.qryQuery.SQL.Add('  GRUDET.*,                                    ');
  cdsGruDet.qryQuery.SQL.Add('  GRU_DESGRU                                   ');
  cdsGruDet.qryQuery.SQL.Add('FROM                                           ');
  cdsGruDet.qryQuery.SQL.Add('  GRUDET                                       ');
  cdsGruDet.qryQuery.SQL.Add('  INNER JOIN CADGRU ON GRU_CODGRU = GRD_CODGRU ');
  cdsGruDet.qryQuery.SQL.Add('WHERE                                          ');
  cdsGruDet.qryQuery.SQL.Add('  GRD_SEQGER = :SEQGER                         ');

  cdsGruDet.AfterOpen := pCdsGruDetAfterOpen;
  qryTabela.AfterScroll := pQryTabelaAfterScroll;
  qryTabela.AfterCancel := pQryTabelaAfterCancel;
  qryTabela.AfterPost := pQryTabelaAfterPost;

  dtsGruGer.DataSet   := qryTabela;
  cxgGruDetTbv.DataController.DataSource := cdsGruDet.dtsSource;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodGru;
end;

procedure TfrmCadGruposAnaliseProducao.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GRG_CODIGO');
  stlCampos.Add('GRG_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('GRG_DESCRI');
  stlCamInd.Add('GRG_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

function TfrmCadGruposAnaliseProducao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
    strDescricao : String;
begin
  Result    := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  begin
    if Sender = dbeDescri then
    begin
      if fEmptyStr(dbeDescri.Text) then
      begin
        Result := False;
        pMensagemOk('Informe a descrição!');
      end;
    end

    else If (Sender = mskLinGru) Then
    Begin
      if blnBuscaPorChave and (mskLinGru.Text <> '') then
      begin
        strDescricao := fRetNomeLinhaGrupo(mskLinGru.Text);
        if not fEmptyStr(strDescricao) then
        begin
          if cdsGruDet.Locate('GRD_CODGRU', mskLinGru.Text, []) then
          begin
            Result := False;
            pMensagemOk('Linha / Grupo já cadastrada!');
          end
          else
          begin
            cdsGruDet.Append;
            cdsGruDet.FieldByName('GRD_CODGRU').AsString := mskLinGru.Text;
            cdsGruDet.FieldByName('GRU_DESGRU').AsString := strDescricao;
            cdsGruDet.Post;

            blnMudarFoco := False;
            mskLinGru.Clear;
          end;
        end
        else
        begin
          Result := False;
          mskLinGru.Clear;
          pMensagemOk('Linha / Grupo Inválida!');
        end;

      end;
    End;

  end;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadGruposAnaliseProducao.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
var
 arrSel : TConsultasArray;
begin
   If fPesqGrupo(Self,
                mskLinGru,
                Nil,
                Nil,
                Key,
                arrSel,
                True) Then
  Begin
    fValidaCampos(mskLinGru, True);
  End;
end;

procedure TfrmCadGruposAnaliseProducao.pCdsGruDetAfterOpen(DataSet: TDataSet);
begin
  If DataSet.Active Then
  Begin
    If DataSet.FindField('GRD_CODGRU') <> nil Then
      TStringField(DataSet.FieldByName('GRD_CODGRU')).EditMask := '999.999;0;_';
  End;
end;

procedure TfrmCadGruposAnaliseProducao.pQryTabelaAfterCancel(DataSet: TDataSet);
begin
  If DataSet.Active Then
  Begin
    cdsGruDet.CancelUpdates;
    pQryTabelaAfterScroll(DataSet);
  End;
end;

procedure TfrmCadGruposAnaliseProducao.pQryTabelaAfterScroll(DataSet: TDataSet);
begin
  If DataSet.Active Then
  Begin
    cdsGruDet.Close;
    cdsGruDet.qryQuery.Close;
    cdsGruDet.qryQuery.ParamByName('SEQGER').AsString := DataSet.FieldByName('AUTOINCREM').AsString;
    cdsGruDet.fAbreClient(True);
  End;
end;

procedure TfrmCadGruposAnaliseProducao.pQryTabelaAfterPost(DataSet: TDataSet);
begin
  cdsGruDet.first;
  while not cdsGruDet.eof do
  begin
    if fEmptyStr(cdsGruDet.fieldByName('AUTOINCREM').AsString) then
    begin
      cdsGruDet.Edit;
      cdsGruDet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GRUGER', VS_strCodEmp);
      cdsGruDet.FieldByName('GRD_SEQGER').AsString := DataSet.FieldByName('AUTOINCREM').AsString;
      cdsGruDet.Post;
    end;
    cdsGruDet.Next;
  end;
  cdsGruDet.fSalva
end;

end.
