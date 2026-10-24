unit untNotificaAtivacaoTabPreFor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Grids, DBGrids, Uni, DB, frxClass, frxExportCSVTestabilidade,
  DBGridCitel;

Type
    opcSinal = (opcMenor, opcMaior);
Type
  TfrmNotificaAtivacaoTabPreFor = class(TfrmPai)
    lblMensagemTopo: TLabel;
    lblMensagemButtom: TLabel;
    dbgDados: TDBGridCitel;
    btnConfirma: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    function fGetSql(Sinal : opcSinal; strCodFor : String = '') : String;
    function fGetSqlIteGer : String;
  public
    class procedure pVerificaEfetivacao;
    class function fEscolheTabelaAUtilizar(strCodFor : String; var strCodTabEscolha : String ) : Boolean;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmNotificaAtivacaoTabPreFor }
function TfrmNotificaAtivacaoTabPreFor.fGetSql(Sinal : opcSinal; strCodFor : String = ''): String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                          ';
  Result := Result + ' TAB_CODTAB,                                  ';
  Result := Result + ' TAB_NOMTAB,                                  ';
  Result := Result + ' CONCAT(TAB_CODFOR," - ", FOR_NOMFOR) AS FORNEC,';
  Result := Result + ' TAB_DTAEFE                                   ';
  Result := Result + ' FROM TABPRE                                  ';
  Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = TAB_CODFOR ';
  Result := Result + ' WHERE TAB_DTAEFE ' + IIF(Sinal = opcMenor, '<', '>') + '= :DTAEFE ';
  If Not fEmptyStr(strCodFor) Then
    Result := Result + ' AND TAB_CODFOR = :CODFOR ';
    
  Result := Result + ' ORDER BY TAB_DTAEFE                          ';

end;

function TfrmNotificaAtivacaoTabPreFor.fGetSqlIteGer: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                                                ';
  Result := Result + ' "      " AS TAB_CODTAB,                                            ';
  Result := Result + ' "UTILIZAR PREÇOS VIGENTES NO CADASTRO DE PRODUTOS" AS TAB_NOMTAB,  ';
  Result := Result + ' " " AS FORNEC,                                                     ';
  Result := Result + ' NULL AS TAB_DTAEFE                                                 ';
  Result := Result + ' FROM CADEMP                                                        ';
  Result := Result + ' WHERE EMP_CODEMP = ' + QuotedStr(VS_strCodEmp) ;

end;

procedure TfrmNotificaAtivacaoTabPreFor.FormActivate(Sender: TObject);
begin
  inherited;
  if btnConfirma.Visible Then
    pSetFocus(dbgDados)
  Else
    pSetFocus(btnSair);
      
end;

procedure TfrmNotificaAtivacaoTabPreFor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_ESCAPE : Close;
    VK_RETURN : Begin
                  If dbgDados.Focused and btnConfirma.Visible then
                    pSetFocus(btnConfirma);
                End;
  End;
end;

class procedure TfrmNotificaAtivacaoTabPreFor.pVerificaEfetivacao;
  Var
    qryConsulta : TUniQuery;
    dtsConsulta : TDataSource;
    frmNotificaAtivacaoTabPreFor: TfrmNotificaAtivacaoTabPreFor;
begin
  if not fCfgSis('TABPRF', varBoolean) Then
    Exit;

  if not fCfgSis('PRFEFE', varBoolean) Then
    Exit;

  if fCampoTabela('OPE_MSGETF', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]) <> 'S' Then
    Exit;

  frmNotificaAtivacaoTabPreFor := TfrmNotificaAtivacaoTabPreFor.Create(Application);
  qryConsulta := fCriaQuery(frmNotificaAtivacaoTabPreFor);
  dtsConsulta := fCriaDataSource(qryConsulta);
  With frmNotificaAtivacaoTabPreFor, qryConsulta, SQL Do
  Begin
    Clear;
    Add(fGetSql(opcMenor));

    ParamByName('DTAEFE').AsDate := VS_Date;

    Open;

    if not IsEmpty Then
    Begin
      dbgDados.DataSource := dtsConsulta;
      dbgdados.OnKeyDown  := FormKeyDown;
      btnConfirma.Visible := False;
      ShowModal;
    End;

  End;
  FreeAndNil(qryConsulta);
  FreeAndNil(frmNotificaAtivacaoTabPreFor);

end;


procedure TfrmNotificaAtivacaoTabPreFor.dbgDadosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if fEmptyStr(TDBGrid(Sender).DataSource.DataSet. FieldByName('TAB_CODTAB').AsString) Then
  Begin
    TDBGrid(Sender).Canvas.Brush.Color := $00D1F0AE;
    TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

class function TfrmNotificaAtivacaoTabPreFor.fEscolheTabelaAUtilizar(strCodFor : String;
  var strCodTabEscolha: String): Boolean;
  Var
    qryConsulta : TUniQuery;
    dtsConsulta : TDataSource;
    frmNotificaAtivacaoTabPreFor: TfrmNotificaAtivacaoTabPreFor;
    intContador : Integer;
    intWidthFor : Integer;
begin
	Result := False;
	intWidthFor := 0;

  frmNotificaAtivacaoTabPreFor := TfrmNotificaAtivacaoTabPreFor.Create(Application);
  qryConsulta := fCriaQuery(frmNotificaAtivacaoTabPreFor);
  dtsConsulta := fCriaDataSource(qryConsulta);
  With frmNotificaAtivacaoTabPreFor, qryConsulta, SQL Do
  Begin
    Caption := 'Escolha de Tabela de Preços de Fornecedores';

    Clear;
    Add(fGetSqlIteGer);
    Add(' UNION ALL ');
    Add(fGetSql(opcMaior, strCodFor));

    ParamByName('DTAEFE').AsDate   := VS_Date;

    If Params.FindParam('CODFOR') <> Nil Then
      ParamByName('CODFOR').ASString := strCodFor;

    Open;

    if not IsEmpty Then
    Begin
      dbgDados.DataSource := dtsConsulta;
      dbgdados.OnKeyDown  := FormKeyDown;

      lblMensagemTopo.Visible   := False;
      lblMensagemButtom.Visible := False;
      btnConfirma.Visible       := True;
      for intContador := 0 To dbgDados.Columns.Count -1 Do
      Begin
        if dbgDados.Columns[intContador].FieldName = 'FORNEC' Then
        Begin
          intWidthFor := dbgDados.Columns[intContador].Width;
          dbgDados.Columns[intContador].Visible := False;
        End;
      End;

      for intContador := 0 To dbgDados.Columns.Count -1 Do
      Begin
        if dbgDados.Columns[intContador].FieldName = 'TAB_NOMTAB' Then
          dbgDados.Columns[intContador].Width := dbgDados.Columns[intContador].Width + intWidthFor;
      End;

      if RecordCount > 1 Then
        Result := (ShowModal = MrOk)
      Else
      Begin
        Result := True;
        strCodTabEscolha := 'ITEGER';
      End;

      if Result Then
        strCodTabEscolha := FieldByName('TAB_CODTAB').AsString;

      if fEmptyStr(strCodTabEscolha) then
        strCodTabEscolha := 'ITEGER';
      
    End;

  End;
  FreeAndNil(qryConsulta);
  FreeAndNil(frmNotificaAtivacaoTabPreFor);

end;


end.



