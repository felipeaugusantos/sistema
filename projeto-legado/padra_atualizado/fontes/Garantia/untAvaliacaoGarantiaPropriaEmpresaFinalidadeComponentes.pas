unit untAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UniClientDataSet,
  cxDropDownEdit;

type
  TItemRecord = Record
    strITESUB: String;
    fltQtdDis: Double;
    fltQtdApr: Double;
    fltCusIte: Double;
    strOrigem: String;
    strMotivo: String;
    strDestino: String;
  End;
  TComponente = TItemRecord;
  TEnviarItemEstrutura = procedure(aComponente: TComponente) of object;

type
  TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes = class(TfrmPai)
    cdsComponente: TUniClientDataSet;
    dtsComponente: TDataSource;
    cxGridCitel1: TcxGridCitel;
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel1Level1: TcxGridLevel;
    cdsComponenteDESITE: TStringField;
    cdsComponenteITESUB: TStringField;
    cdsComponenteQTDITE: TFloatField;
    cdsComponenteQTDAPR: TFloatField;
    cdsComponenteQTDDISP: TFloatField;
    cdsComponenteCUSITE: TFloatField;
    cxGridCitel1DBTableViewCitel1DESITE: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1ITESUB: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1QTDITE: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1QTDDISP: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1QTDAPR: TcxGridDBColumn;
    btnConfirmar: TBitBtnLocked;
    cdsComponenteCODFAB: TStringField;
    cxGridCitel1DBTableViewCitel1CODFAB: TcxGridDBColumn;
    cdsComponenteORIGEM: TStringField;
    cdsComponenteMOTIVO: TStringField;
    cdsComponenteDESTINO: TStringField;
    cxGridCitel1DBTableViewCitel1ORIGEM: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1MOTIVO: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1DESTINO: TcxGridDBColumn;
    procedure cdsComponenteQTDAPRValidate(Sender: TField);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsComponenteBeforePost(DataSet: TDataSet);
    procedure cdsComponenteBeforeScroll(DataSet: TDataSet);

  private
    FEnviarItem: TEnviarItemEstrutura;
    FstrCodIte: String;
    FfltQtd: Double;
    procedure pConfirmar;
    function fGetSql: String;
    procedure pCriarDataSets;
    procedure pCarregarDados;
    procedure pPopularItensComboBoxPropreties;
    { Private declarations }
  public
    function fPermitirIndicarFinalidade(const strCodIte: String; fltQtd: Double): Boolean;
    procedure pSetEnventoEnviarEnviarItensEstrutura(Evento: TEnviarItemEstrutura);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
  end;

var
  frmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes: TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes;

implementation
uses
  untFuncoesSimples, Uni, strUtils;

{$R *.dfm}

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  pConfirmar;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.cdsComponenteBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  if Not fValidaCampos(Nil)then
    Abort;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.cdsComponenteBeforeScroll(
  DataSet: TDataSet);
begin
  inherited;
  if cdsComponente.State = dsEdit then
  begin
    if not fValidaCampos(Nil) then
      Abort;
  end;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.cdsComponenteQTDAPRValidate(Sender: TField);
begin
  inherited;
  if Sender.AsFloat > cdsComponenteQTDDISP.AsFloat then
  begin
    fMensagem('Atenção','A quantidade que será aproveitada não pode ser maior que o saldo disponível!',['&OK']);
    abort;
  end
  else if Sender.AsFloat < 0 then
  begin
    fMensagem('Atenção','A quantidade aproveitada não pode ser negativa',['&OK']);
    abort;
  end;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := CaFree;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pPopularItensComboBoxPropreties;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.FormDestroy(Sender: TObject);
begin
  inherited;
  FEnviarItem := Nil;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_F10 then
  begin
    btnConfirmar.click;
  end;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.fPermitirIndicarFinalidade(const strCodIte: String; fltQtd: Double): Boolean;
begin
  FstrCodIte := strCodIte;
  FfltQtd := fltQtd;
  pCarregarDados;
  Result := Not cdsComponente.IsEmpty;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if cdsComponenteQTDAPR.AsFloat > 0 then
  begin
    Result := Not fEmptyStr(cdsComponenteORIGEM.AsString);
    Result := Result and (Not fEmptyStr(cdsComponenteMOTIVO.AsString));
    Result := Result and (Not fEmptyStr(cdsComponenteDESTINO.AsString));
  end;

  if Not Result then
  begin
    pMensagemOk('É obrigatório informar origem, motivo e destino!');
  end;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.fGetSql: String;
begin
  Result :=          ' SELECT G.AUTOINCREM, G.GMT_CODITE, D.DMT_ITESUB, D.DMT_QTDITE,  D.DMT_PRESUB, ';
  Result := Result + ' IF(IFNULL(D.DMT_CUSITE,0) <> 0,D.DMT_CUSITE,I2.ITE_PRECUS) AS "CUSITE", ';
  Result := Result + ' IF(IFNULL(D.DMT_DESCRI,"") <> "",D.DMT_DESCRI,I.ITE_DESITE) AS "DESITE", ';
  Result := Result + ' IFNULL(I.ITE_CODFAB, "") AS "CODFAB", ';
  Result := Result + ' cast("" as CHAR(10)) as ORIGEM, ';
  Result := Result + ' cast("" as CHAR(10)) as MOTIVO, ';
  Result := Result + ' cast("" as CHAR(10)) as DESTINO ';
  Result := Result + ' FROM GERMAT G ';
  Result := Result + ' JOIN DETMAT D ON D.DMT_SEQGER = G.AUTOINCREM ';
  Result := Result + ' JOIN CADITE I ON I.ITE_CODITE = D.DMT_ITESUB  ';
  Result := Result + ' JOIN ITEGER I2 ON I2.ITE_CODITE = I.ITE_CODITE AND I2.ITE_CODEMP = G.GMT_CODEMP ';
  Result := Result + ' WHERE G.GMT_CODEMP = :CODEMP ';
  Result := Result + ' AND G.GMT_CODITE = :CODITE ';
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.pCarregarDados;
Var
  Qry: TUniQuery;
  pBeforPost: TDataSetNotifyEvent;
begin
  Qry := Nil;
  pBeforPost := cdsComponente.BeforePost;
  Try
    cdsComponente.BeforePost := Nil;
    Qry := fCriaQuery;
    Qry.sql.clear;
    Qry.Sql.Add(fGetSql);
    Qry.ParamByName('CODITE').AsString := Self.FstrCodIte;
    Qry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    Qry.Open;
    if Not Qry.IsEmpty then
    begin
      Qry.First;
      while Not Qry.Eof do
      begin
        cdsComponente.Append;
        cdsComponenteDESITE.AsString := Qry.FieldByName('DESITE').AsString;
        cdsComponenteITESUB.AsString := Qry.FieldByName('DMT_ITESUB').AsString;
        cdsComponenteQTDITE.AsFloat  := Qry.FieldByName('DMT_QTDITE').AsFloat;
        cdsComponenteCUSITE.AsFloat  := Qry.FieldByName('CUSITE').AsFloat;
        cdsComponenteQTDDISP.AsFloat := cdsComponenteQTDITE.AsFloat * FfltQtd;
        cdsComponenteCODFAB.AsString := Qry.FieldByName('CODFAB').AsString;
        cdsComponenteQTDAPR.AsFloat  := 0;
        cdsComponente.Post;
        qry.next;
      end;
    end;
  Finally
    if Assigned(Qry) then
      Qry.Free;

    cdsComponente.BeforePost := pBeforPost;
  End;

end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.pConfirmar;
Var
  Componente: TComponente;
  intCompoentes: Integer;
begin
  if (cdsComponente.state in [dsInsert,dsEdit]) then
    cdsComponente.post;

  if Not Assigned(FEnviarItem) then
    Exit;
  intCompoentes := 0;
  cdscomponente.first;
  while not cdsComponente.EOF do
  begin
    if cdsComponenteQTDAPR.AsFloat > 0 then
    begin
      inc(intCompoentes);
      Componente.strITESUB := cdsComponenteITESUB.AsString;
      Componente.fltQtdDis := cdsComponenteQTDDISP.AsFloat;
      Componente.fltQtdApr := cdsComponenteQTDAPR.AsFloat;
      Componente.fltCusite := cdsComponenteCUSITE.AsFloat;
      Componente.strOrigem := cdsComponenteORIGEM.AsString;
      Componente.strMotivo := cdsComponenteMOTIVO.AsString;
      Componente.strDestino := cdsComponenteDESTINO.AsString;
      Self.FEnviarItem(Componente);
    end;
    cdsComponente.Next;
  end;

  if   (intCompoentes > 0) then
    Self.ModalResult := mrOk
  else
  begin
    fMensagem('Atenção','Não foi indicado aproveitamento de componente, selecione a opção de perda.',['&OK']);
    Self.ModalResult := MrCancel;
  end;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.pCriarDataSets;
begin
  if cdsComponente.Active then
    cdsComponente.Close;
  cdsComponente.CreateDataSet;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.pPopularItensComboBoxPropreties;
  CONST
    ORIGEM: String = '0';
    MOTIVO: String = '1';
    DESTINO: String = '2';
  Var
    Qry: TUniQuery;
    strSQL: String;
    strTipMot: String;
    objFieldTipMot, objFieldDescri: TField;
    objcxComboBoxProperties: TcxComboBoxProperties;
begin
  {$Region 'SQL'}
  strSQL :=          ' SELECT MAI_TIPMOT, MAI_DESCRI ';
  strSQL := strSQL + ' FROM CADMAI ';
  strSQL := strSQL + ' WHERE MAI_CODEMP = :CODEMP ';
  strSQL := strSQL + ' ORDER BY MAI_TIPMOT, MAI_DESCRI ';
  {$EndRegion}
  Qry := Nil;
  objcxComboBoxProperties := nil;
  Try
    {$Region 'Motando Query'}
    Qry := fCriaQuery;
    Qry.Close;
    Qry.SQL.Add(strSQL);
    Qry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    Qry.Open;
    {$Endregion}

    if Qry.IsEmpty then
      Exit;

    objFieldTipMot := Qry.FieldByName('MAI_TIPMOT');
    objFieldDescri := Qry.FieldByName('MAI_DESCRI');

    Qry.First;
    Repeat
      strTipMot := objFieldTipMot.AsString;

      Case IndexStr(strTipMot,[ORIGEM, MOTIVO, DESTINO]) of
        0: objcxComboBoxProperties := TcxComboBoxProperties(cxGridCitel1DBTableViewCitel1ORIGEM.Properties);
        1: objcxComboBoxProperties := TcxComboBoxProperties(cxGridCitel1DBTableViewCitel1MOTIVO.Properties);
        2: objcxComboBoxProperties := TcxComboBoxProperties(cxGridCitel1DBTableViewCitel1DESTINO.Properties);
        else
          continue;
      end;

      objcxComboBoxProperties.Items.Clear;

      Repeat
        objcxComboBoxProperties.Items.Add(objFieldDescri.AsString);
        Qry.Next;
      Until (strTipMot <> objFieldTipMot.AsString) or Qry.Eof ;
    until Qry.Eof ;

  Finally
    if Assigned(Qry) Then
      FreeAndNil(Qry);
  End;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.pSetEnventoEnviarEnviarItensEstrutura(Evento: TEnviarItemEstrutura);
begin
  FEnviarItem := Evento;
end;

end.
