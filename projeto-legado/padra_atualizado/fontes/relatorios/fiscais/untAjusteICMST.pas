unit untAjusteICMST;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, AppEvnts,
  Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, cxEditRepositoryItems,
  Uni, StrUtils, MemDS, DBAccess, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmAjusteICMST = class(TfrmPai)
    dbgICMST: TcxGrid;
    dbgICMSTDBTableView1: TcxGridDBTableView;
    dbgICMSTLevel1: TcxGridLevel;
    dsAux: TDataSource;
    cxRepository: TcxEditRepository;
    dbgCodAju: TcxGridDBColumn;
    dbgDesAju: TcxGridDBColumn;
    dbgValAju: TcxGridDBColumn;
    qryAjuste: TUniQuery;
    qryAjusteAJI_DESAJU: TStringField;
    qryAjusteAJI_VALAJU: TFloatField;
    qryAjusteAJI_CODEMP: TStringField;
    cxFormataFloat: TcxEditRepositoryCurrencyItem;
    cxUpperCase: TcxEditRepositoryTextItem;
    qryAjusteAJI_CODAJU: TStringField;
    dbgMesAno: TcxGridDBColumn;
    qryAjusteAJI_MESANO: TStringField;
    cxMascaraData: TcxEditRepositoryMaskItem;
    qryAjusteAUTOINCREM: TStringField;
    dbgCodRec: TcxGridDBColumn;
    qryAjusteAJI_CODREC: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure qryAjusteAfterPost(DataSet: TDataSet);
    procedure qryAjusteBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure dbgICMSTDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qryAjusteBeforeEdit(DataSet: TDataSet);
  private
    strCodigoChaveSped: String;
    strValorVelho: String;
    
    procedure pCarregaCodigoChaveSped;
    function fValidaCodigoChaveSped: Boolean;

    function fCarregaAjuste: String;

  public
  
  end;

var
  frmAjusteICMST: TfrmAjusteICMST;

implementation

uses untModulo, untFuncoesFactory, untIFuncoes;

{$R *.dfm}

procedure TfrmAjusteICMST.dbgICMSTDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Delete) And
     (Not (qryAjuste.IsEmpty)) Then
  Begin
    If fMensagem('ATENÇÃO', 'Deseja deletar a linha selecionada?',
       ['&Sim', '&Não'], 2) = 1 Then
    Begin
      qryAjuste.Delete;
      qryAjuste.AfterPost(qryAjuste);
    End;
  End;
end;

function TfrmAjusteICMST.fCarregaAjuste: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  AUTOINCREM, ';  
  strSQL := strSQL + '  AJI_CODEMP, ';
  strSQL := strSQL + '  AJI_CODAJU, ';
  strSQL := strSQL + '  AJI_DESAJU, ';
  strSQL := strSQL + '  AJI_MESANO, ';
  strSQL := strSQL + '  AJI_VALAJU, ';
  strSQL := strSQL + '  AJI_CODREC ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  AJICST ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AJI_CODEMP = :CODEMP';

  Result := strSQL;
end;

procedure TfrmAjusteICMST.FormCreate(Sender: TObject);
begin
  inherited;

  qryAjuste.Connection := frmModulo.Database;
end;

procedure TfrmAjusteICMST.FormShow(Sender: TObject);
begin
  inherited;

  qryAjuste.Close;
  qryAjuste.SQL.Clear;
  qryAjuste.SQL.Text := fCarregaAjuste;
  
  qryAjuste.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAjuste.Open;

  fStartTransaction;

  pCarregaCodigoChaveSped;
end;

procedure TfrmAjusteICMST.pCarregaCodigoChaveSped;
begin
  strCodigoChaveSped := '';

  qryAjuste.First;

  While Not (qryAjuste.Eof) Do
  Begin
    strCodigoChaveSped := strCodigoChaveSped + qryAjusteAJI_MESANO.AsString + qryAjusteAJI_CODAJU.AsString + '_';

    qryAjuste.Next;
  End;
end;

function TfrmAjusteICMST.fValidaCodigoChaveSped: Boolean;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin
  Result := False;
  
  qryAux := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  AJICST ';    
    strSQL := strSQL + 'WHERE CONCAT(AJI_MESANO, AJI_CODAJU) = :VALOR_NOVO ';
    strSQL := strSQL + '  AND CONCAT(AJI_MESANO, AJI_CODAJU) <> :VALOR_VELHO ';

    qryAux.SQL.Text := strSQL;

    qryAux.ParamByName('VALOR_NOVO').AsString := qryAjusteAJI_MESANO.AsString + qryAjusteAJI_CODAJU.AsString;
    qryAux.ParamByName('VALOR_VELHO').AsString := strValorVelho;
    qryAux.Open;

    If Not (qryAux.IsEmpty) then
      Result := True;
  Finally
    qryAux.Free;
  End;
end;

procedure TfrmAjusteICMST.qryAjusteAfterPost(DataSet: TDataSet);
begin
  inherited;

  Try
    fCommit;
  Except
    fRollBack;
    Abort;
  End;

  pCarregaCodigoChaveSped;
end;

procedure TfrmAjusteICMST.qryAjusteBeforeEdit(DataSet: TDataSet);
begin
  inherited;

  strValorVelho := qryAjusteAJI_MESANO.AsString + qryAjusteAJI_CODAJU.AsString;
end;

procedure TfrmAjusteICMST.qryAjusteBeforePost(DataSet: TDataSet);
  Var
    strCodigoAjuste: String;
    blnValida: Boolean;
begin
  inherited;

  blnValida := False;

  strCodigoAjuste := qryAjusteAJI_MESANO.AsString + qryAjusteAJI_CODAJU.AsString;

  Try
    StrToDate('01/' + qryAjusteAJI_MESANO.AsString);
  Except
    fMensagem('', 'Valor inválido para o campo Mês / Ano! Favor inserir os campos novamente.', ['&Ok']);
    qryAjuste.Cancel;
    pSetFocus(dbgICMST);
    Abort;
  End;

  Try
    strToInt(RightStr(qryAjusteAJI_MESANO.AsString, 04));
    strToInt(LeftStr(qryAjusteAJI_MESANO.AsString, 02));
  Except
    fMensagem('', 'Informe o mês com dois dígitos e o ano com quatro dígitos, no formato 99/9999!', ['&Ok']);
    qryAjuste.Cancel;
    pSetFocus(dbgICMST);
    Abort;
  End;

  If Length(qryAjusteAJI_CODAJU.AsString) <> 8 Then
  Begin
    fMensagem('', 'Informe no campo código do ajuste os dois primeiros caracteres com um estado válido e os seis últimos com o código do ajuste!', ['&OK']);
    qryAjuste.Cancel;
    pSetFocus(dbgICMST);
    Abort;
  End;

  Try
    StrToInt(LeftStr(qryAjusteAJI_CODAJU.AsString, 02));
    blnValida := True;
    Abort;
  Except
    If blnValida Then
    Begin
      fMensagem('', 'Informe no campo código do ajuste os dois primeiros caracteres com um estado válido e os seis últimos com o código do ajuste!', ['&OK']);
      qryAjuste.Cancel;
      pSetFocus(dbgICMST);
      Abort;
    End;
  End;

  If (Not fValidaEstado(LeftStr(qryAjusteAJI_CODAJU.AsString, 02))) Then
  Begin
    fMensagem('ATENÇÃO', 'Os dois primeiros caracteres do campo código do ajuste representando o estado não é valido! Favor inserir os campos novamente.', ['&Ok']);
    qryAjuste.Cancel;
    pSetFocus(dbgICMST);
    Abort;
  End;

  If qryAjuste.State in [dsEdit] Then
  Begin
    If fValidaCodigoChaveSped Then
    Begin
      If fEmptyStr(qryAjusteAJI_CODAJU.AsString) Then
        fMensagem('','O campo código do ajuste deve ser preenchido! Favor inserir os campos novamente', ['&OK'] )
      Else
        fMensagem('','Já existe esse código para essa data e estado! Favor inserir os campos novamente', ['&OK'] );

      qryAjuste.Cancel;
      pSetFocus(dbgICMST);
      Abort;
    End;
  End
  Else
  Begin
    If (fEmptyStr(qryAjusteAJI_CODAJU.AsString)) Or
       ((qryAjuste.RecordCount > 0) And
       (Pos(strCodigoAjuste, strCodigoChaveSped) > 0)) Then
    Begin
      If fEmptyStr(qryAjusteAJI_CODAJU.AsString) Then
        fMensagem('','O campo código do ajuste deve ser preenchido! Favor inserir os campos novamente', ['&OK'] )
      Else
        fMensagem('','Já existe esse código para essa data e estado! Favor inserir os campos novamente', ['&OK'] );

      qryAjuste.Cancel;
      pSetFocus(dbgICMST);
      Abort;
    End;
  End;

  qryAjusteAJI_CODEMP.AsString := VS_strCodEmp;

  qryAjusteAUTOINCREM.AsString := fRetAutoIncrem('AJICST', VS_strCodEmp);

  If (qryAjusteAJI_VALAJU.AsFloat <= 0) Then
  Begin
    fMensagem('', 'Valor do ajuste deve ser maior que zero! Favor inserir os campos novamente.', ['&Ok']);
    qryAjuste.Cancel;
    pSetFocus(dbgICMST);
    Abort;
  End;
end;

end.
