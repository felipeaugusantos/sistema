unit untCadFaiHorRegiao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, Mask, MaskEditFocus, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBClient, Provider, Uni,
  untFuncoesSimples, cxLookAndFeels, cxLookAndFeelPainters, UniClientDataSet, cxNavigator, untZClient, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadFaiHorRegiao = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    btnConfirma: TBitBtnLocked;
    pnlDados: TPanel;
    Panel1: TPanel;
    edtHorIni: TMaskEditFocus;
    lbl1: TLabel;
    edtHorFin: TMaskEditFocus;
    Label1: TLabel;
    btnInserir: TBitBtnLocked;
    dbgHorView: TcxGridDBTableView;
    dbgHorLevel1: TcxGridLevel;
    dbgHor: TcxGrid;
    dbgHorViewHORINI: TcxGridDBColumn;
    dbgHorViewHORFIN: TcxGridDBColumn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbgHorViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    cdsHor: TZClient;
    strAutoIn: String;
    procedure pCarregaHorarios;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pAdicinar(blnAdicionar: Boolean);
    procedure pInserir;
    procedure pEditar;

    function fRetSQL: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodReg: String;
  end;


implementation

{$R *.dfm}

uses untConstantes;

procedure TfrmCadFaiHorRegiao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If cdsHor.fSalva Then
    btnSair.Click;
end;

procedure TfrmCadFaiHorRegiao.btnInserirClick(Sender: TObject);
var
  blnAdicionar: Boolean;
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnAdicionar := fEmptyStr(strAutoIn);
    pAdicinar(blnAdicionar);
    edtHorIni.Clear;
    edtHorFin.Clear;
    pSetFocus(edtHorIni);
    btnConfirma.Enabled := Not cdsHor.IsEmpty;
  End;
end;

procedure TfrmCadFaiHorRegiao.btnSairClick(Sender: TObject);
begin
  inherited;

end;

procedure TfrmCadFaiHorRegiao.dbgHorViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN : Begin
                  strAutoIn := cdsHor.FieldByName('AUTOINCREM').AsString;
                  edtHorIni.Text := FormatDateTime('hh:mm', cdsHor.FieldByName('FHO_HORINI').AsDateTime);
                  edtHorFin.Text := FormatDateTime('hh:mm', cdsHor.FieldByName('FHO_HORFIN').AsDateTime);
                  pSetFocus(edtHorIni);
                End;
    VK_DELETE : If fMensagem('QUESTÃO','Deseja realmente excluir esse horário ?',['&Sim','&Não']) = 1 Then
                Begin
                  cdsHor.Delete;
                End;
  End;
end;

procedure TfrmCadFaiHorRegiao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtHorIni);
end;

procedure TfrmCadFaiHorRegiao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10 : Begin
               If btnConfirma.Enabled Then
                 btnConfirma.Click;
               Key := 0;
             End;
  End;
end;

procedure TfrmCadFaiHorRegiao.FormShow(Sender: TObject);
begin
  inherited;
  cdsHor := TZClient.Create(Self);
  dbgHorView.DataController.DataSource := cdsHor.dtsSource;

  pCarregaHorarios;

  cdsHor.AfterOpen := pAfterOpen;
  btnConfirma.Enabled  := (not cdsHor.IsEmpty);
  strAutoIn := '';
end;

function TfrmCadFaiHorRegiao.fRetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT FHO_CODREG, ';
  Result := Result + '        FHO_HORINI, ';
  Result := Result + '        FHO_HORFIN, ';
  Result := Result + '        FHO_CODEMP, ';
  Result := Result + '        AUTOINCREM  ';
  Result := Result + ' FROM REGFHO      ';
  Result := Result + ' WHERE FHO_CODREG = :CODREG ';
end;

function TfrmCadFaiHorRegiao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtHorIni) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(edtHorIni.Text, True, False, False, True)) Then
    Begin
      fMensagem('ATENÇÃO','O horário inicial deve ser preenchido !', ['&Ok']);
      Result := False;
    End
    Else If StrToDateTimeDef(edtHorIni.Text, -1) = -1 Then
    Begin
      fMensagem('ATENÇÃO', '"' + edtHorIni.Text + '" não é uma hora válida!', ['&Ok']);
      Result := False;
    End
  End;

  If (Sender = edtHorFin) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(edtHorFin.Text, True, False, False, True)) Then
    Begin
      fMensagem('ATENÇÃO','O horário final deve ser preenchido !', ['&Ok']);
      Result := False;
    End
    Else If StrToDateTimeDef(edtHorFin.Text, -1) = -1 Then
    Begin
      fMensagem('ATENÇÃO', '"' + edtHorFin.Text + '" não é uma hora válida!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateTime(edtHorFin.Text) < StrToDateTime(edtHorIni.Text) Then
    Begin
      fMensagem('ATENÇÃO','O horário final não pode ser menor que o horário inicial !', ['&Ok']);
      Result := False;
    End
    Else If cdsHor.Locate('FHO_HORINI;FHO_HORFIN', VarArrayOf([StrToDateTime(edtHorIni.Text), StrToDateTime(edtHorFin.Text)]), []) Then
    Begin
      fMensagem('ATENÇÃO','O horário selecionado já existe para essa região !', ['&Ok']);
      Result := False;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadFaiHorRegiao.pAdicinar(blnAdicionar: Boolean);
begin
  If blnAdicionar Then
    pInserir
  Else
    pEditar;

  strAutoIn := '';
end;

procedure TfrmCadFaiHorRegiao.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    TTimeField(DataSet.FieldByName('FHO_HORINI')).DisplayFormat := 'HH:MM';
    TTimeField(DataSet.FieldByName('FHO_HORFIN')).DisplayFormat := 'HH:MM';
  End;
end;

procedure TfrmCadFaiHorRegiao.pCarregaHorarios;
begin
  Try
    With cdsHor.qryQuery, SQL Do
    Begin
      cdsHor.Close;
      Close;
      Clear;
      Add(fRetSQL);
      ParamByName('CODREG').AsString := strCodReg;

      cdsHor.pSetProvider;
      Open;

      pSetaClient(cdsHor.qryQuery);
      cdsHor.Open;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCadFaiHorRegiao.pCarregaHorarios]');
  End;
end;

procedure TfrmCadFaiHorRegiao.pEditar;
begin
  cdsHor.Edit;
  cdsHor.FieldByName('FHO_HORINI').AsDateTime := StrToDateTime(edtHorIni.Text);
  cdsHor.FieldByName('FHO_HORFIN').AsDateTime := StrToDateTime(edtHorFin.Text);
  cdsHor.Post;
end;

procedure TfrmCadFaiHorRegiao.pInserir;
begin
  cdsHor.Append;
  cdsHor.FieldByName('FHO_CODREG').AsString   := strCodReg;
  cdsHor.FieldByName('FHO_HORINI').AsDateTime := StrToDateTime(edtHorIni.Text);
  cdsHor.FieldByName('FHO_HORFIN').AsDateTime := StrToDateTime(edtHorFin.Text);
  cdsHor.FieldByName('FHO_CODEMP').AsString   := VS_strCodEmp;
  cdsHor.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('REGFHO',VS_strCodEmp);
  cdsHor.Post;
end;

end.
