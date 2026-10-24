unit untCadCliClassificacaoIPINCM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, EditFocus, Uni, UniClientDataSet;

type
  TfrmCadCliClassificacaoIPINCM = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    lblMargem: TLabel;
    edtNCMIPI: TEditFocus;
    pnlButtons: TPanel;
    btnFechar: TBitBtnLocked;
    pnlMsgDel: TPanel;
    dbgGridOrdSer: TDBGridCitel;
    FlwPnlButtons: TFlowPanel;
    btnGravar: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    dtsRECAP: TDataSource;
    procedure edtNCMIPIKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbgGridOrdSerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    qryCadNcm: TUniQuery;

    procedure pExcluirNCM;
    function fConsultaNCM: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    cdsRECAP: TUniClientDataSet;
  end;

implementation

uses untConsultas, untFuncoesSimples, untTypesSistema, untConstantes;

{$R *.dfm}

procedure TfrmCadCliClassificacaoIPINCM.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  if (not fValidaCampos(edtNCMIPI, False)) then
    Exit;

  if cdsRECAP.Locate('CODNCM', edtNCMIPI.Text, []) then
  begin
    btnCancela.Click;
    Exit;
  end;

  cdsRECAP.Insert;
  cdsRECAP.FieldByName('CODNCM').AsString := qryCadNcm.FieldByName('CODNCM').AsString;
  cdsRECAP.FieldByName('DESCRI').AsString := qryCadNcm.FieldByName('DESCRI').AsString;
  cdsRECAP.FieldByName('DESCOM').AsString := fRetDescricaoNcm(qryCadNcm.FieldByName('CODNCM').AsString, qryCadNcm.FieldByName('CODEXC').AsString);
  cdsRECAP.FieldByName('OPERAC').AsString := 'I';
  cdsRECAP.Post;

  btnCancela.Click;
end;

procedure TfrmCadCliClassificacaoIPINCM.btnCancelaClick(Sender: TObject);
begin
  inherited;
  edtNCMIPI.Clear;
end;

procedure TfrmCadCliClassificacaoIPINCM.btnGravarClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmCadCliClassificacaoIPINCM.dbgGridOrdSerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_DELETE then
    pExcluirNCM;
end;

procedure TfrmCadCliClassificacaoIPINCM.edtNCMIPIKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  if fPesqNCM(Self.Name, qryCadNcm, Key, arrSel) Then
  begin
    edtNCMIPI.Text := qryCadNcm.FieldByName('NCM_CODNCM').AsString;

    if fValidaCampos(edtNCMIPI) then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmCadCliClassificacaoIPINCM.fConsultaNCM: Boolean;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT NCM_CODNCM CODNCM, NCM_DESCRI DESCRI, NCM_CODEXC CODEXC ';
  strSQL := strSQL + ' FROM CADNCM ';
  strSQL := strSQL + ' WHERE NCM_CODNCM = :CODNCM ';

  qryCadNcm.Close;
  qryCadNcm.SQL.Text := strSQL;
  qryCadNcm.ParamByName('CODNCM').AsString := edtNCMIPI.Text;
  qryCadNcm.Open;

  Result := not qryCadNcm.IsEmpty;
end;

procedure TfrmCadCliClassificacaoIPINCM.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  qryCadNcm   := fCriaQuery(Self);
  cdsRECAP    := TUniClientDataSet.Create(Self);
end;

procedure TfrmCadCliClassificacaoIPINCM.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryCadNcm);
  FreeAndNil(cdsRECAP);
end;

procedure TfrmCadCliClassificacaoIPINCM.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
    btnGravar.Click;
end;

procedure TfrmCadCliClassificacaoIPINCM.FormShow(Sender: TObject);
begin
  inherited;

  cdsRECAP.Filtered := False;
  cdsRECAP.Filter   := 'OPERAC<>''D''';
  cdsRECAP.Filtered := True;

  dtsRECAP.DataSet  := cdsRECAP;
end;

function TfrmCadCliClassificacaoIPINCM.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtNCMIPI) then
  begin
    if not fEmptyStr(edtNCMIPI.Text) then
    begin
      if (Length(edtNCMIPI.Text) <> MAX_CLAIPI) then
      begin
        fMensagem('ATENÇÃO!', 'A Classificação de IPI deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&Ok']);
        Result := False;
      end
      else if (not fConsultaNCM) then
      begin
        fMensagem('ATENÇÃO!', 'NCM não encontrado!', ['&Ok']);
        edtNCMIPI.Clear;
        Result := False;
      end;
    end
    else if fEmptyStr(edtNCMIPI.Text) and (not blnBuscaPorChave) then
    begin
      fMensagem('ATENÇÃO!', 'Informe um Código NCM!', ['&Ok']);
      Result := False;
    end;
  end;
end;

procedure TfrmCadCliClassificacaoIPINCM.pExcluirNCM;
begin
  if (cdsRECAP.IsEmpty) then
    Exit;

  if not (fMensagem('AVISO', 'Confirma a exclusão do defeito relacionado?', ['&Sim', '&Não']) = 1) then
    Exit;

  if (cdsRECAP.FieldByName('OPERAC').AsString = 'I') and (fEmptyStr(cdsRECAP.FieldByName('AUTINC').AsString)) then
    cdsRECAP.Delete
  else
  begin
    cdsRECAP.Edit;
    cdsRECAP.FieldByName('OPERAC').AsString := 'D';
    cdsRECAP.Post;
  end;

  btnCancela.Click;
end;

end.
