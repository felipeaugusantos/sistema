unit untImendesProcessos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,  Uni,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxButtonEdit, cxLabel, cxGridCitel,
  cxContainer, cxProgressBar, cxTextEdit, untImendesOpcoesRecriacaoConsulta,untGravando;

type




  TfrmImendesProcessos = class(TfrmPai)
    cxvDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxgDados: TcxGridCitel;
    dtsDados: TDataSource;
    cxvData: TcxGridDBColumn;
    cxvSituacao: TcxGridDBColumn;
    cxvQtdErro: TcxGridDBColumn;
    cxvProgresso: TcxGridDBColumn;
    cxvExcluir: TcxGridDBColumn;
    cxvCarregar: TcxGridDBColumn;
    cxvFinalizar: TcxGridDBColumn;
    cxvDescricao: TcxGridDBColumn;
    cxvEmpresa: TcxGridDBColumn;
    btnAtualiza: TBitBtnLocked;
    btnGerarNovaConsulta: TBitBtnLocked;
    procedure FormActivate(Sender: TObject);
    procedure cxvExcluirPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxvFinalizarPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxvCarregarPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btnAtualizaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGerarNovaConsultaClick(Sender: TObject);
  protected
    Function  fGeraConsulta(pgbProgresso: TcxProgressBar): Boolean;
    function fTemImendes_AbfIcm_para_deletar(strSQLBase: String): Boolean;

  private
    FQryComand: TUniQuery;
    FTipoGeracao: TTipoGeracao;
    frmGravando : TfrmGravando;
    procedure pGeraAgendamento(TipoGeracao: TTipoGeracao);

    { Private declarations }
  public
     strAutIncSel: String;
    { Public declarations }
  end;

var
  frmImendesProcessos: TfrmImendesProcessos;

implementation

uses
  untFuncoesSimples, iMendes.Functions, iMendes.Types, untInputDialog;

{$R *.dfm}


procedure TfrmImendesProcessos.pGeraAgendamento(TipoGeracao: TTipoGeracao);
var qryItens: TUniQuery;
Begin
  qryItens := fCriaQuery;
  Try

    qryItens.SQL.Add('SELECT COUNT(1) AS QTD ');
    qryItens.SQL.Add('  FROM IMENDES_ITENS I');
    qryItens.SQl.Add(' WHERE I.IME_SEQCON = "' + dtsDados.DataSet.FieldByName('AUTOINCREM').AsString + '"');

    case TipoGeracao of
      ttgItensComRetParcial   : qryItens.SQl.Add(' AND I.IME_RETPAR = 1');
      ttgItensComDivergencia  : qryItens.SQl.Add(' AND I.IME_DIFICM = 1 AND I.IME_SEMEAN = 0');
      ttgNaoEncontradoImendes : qryItens.SQl.Add(' AND I.IME_SEMIME = 1 AND I.IME_SEMEAN = 0');
      ttgCodBarrasInvalido    : qryItens.SQl.Add(' AND I.IME_SEMEAN = 1');
    End;


    qryItens.Open;

    If qryItens.FieldByName('QTD').AsInteger = 0 Then
    Begin
      pMensagemOk('Não existe itens na situação selecionada!');
      Exit;
    End;
  Finally
    FreeAndNil(qryItens);
  End;
  FTipoGeracao := TipoGeracao;
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Preparando reprocessamento';
    frmGravando.fExecutarAcao := fGeraConsulta;
    frmGravando.ShowModal;
    If frmGravando.blnConfirma Then
    Begin
      pMensagemOk('Consulta marcada pra reprocessamento com sucesso!');
      btnAtualiza.Click;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
End;

procedure TfrmImendesProcessos.btnGerarNovaConsultaClick(Sender: TObject);
begin
  inherited;

  strAutIncSel := '';
  if IntegerToEstadoProcessamento(dtsDados.DataSet.FieldByName('MAQUINA_ESTADO').AsInteger)  <> epFinalizadoOk Then
  Begin
    pMensagemOk('O Estado atual da consulta não permite ser gerar nova consulta!');
    Exit;
  End;
  FTipoGeracao := TfrmImendesOpcoesRecriacaoConsulta.fRetImendesOpcoesRecriacaoConsulta(dtsDados.DataSet.FieldByName('DESCRICAO').AsString);
  If FTipoGeracao <> ttgIndefinido then
    pGeraAgendamento(FTipoGeracao);
end;

procedure TfrmImendesProcessos.btnAtualizaClick(Sender: TObject);
var recNo: Integer;
begin
  inherited;
  recNo := dtsDados.DataSet.RecNo;
  dtsDados.DataSet.Close;
  dtsDados.DataSet.Open;
  dtsDados.DataSet.RecNo := recNo;

end;

procedure TfrmImendesProcessos.cxvCarregarPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  strAutIncSel := '';
  case IntegerToEstadoProcessamento(dtsDados.DataSet.FieldByName('MAQUINA_ESTADO').AsInteger)  of
    epFinalizadoOk,
    epFinalizadoItemNaoEncontradoNaImendes,
    epFinalizadoPeloAutcom: Begin
                              strAutIncSel := dtsDados.DataSet.FieldByName('AUTOINCREM').AsString;
                              Close;
                            End;
    Else
      pMensagemOk('O Estado atual da consulta não permite ser carregado!');
  End;
end;

procedure TfrmImendesProcessos.cxvExcluirPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  If strAutIncSel = dtsDados.DataSet.FieldByName('AUTOINCREM').AsString then
  Begin
    pMensagemOk('Esta é a consulta carregada em tela, não será possível remover.');
    Exit;
  End;

  case IntegerToEstadoProcessamento(dtsDados.DataSet.FieldByName('MAQUINA_ESTADO').AsInteger) of
    epIniciaprocesso,
    epCriandoEstruturaBanco,
    epProcessando :  Begin
                       pMensagemOk('O Estado atual não permite a exclusão, utilize o botão finalizar primeiro');
                       Exit;
                     End;
  End;

  If fPergunta('Excluir este registro?') then
  Begin
     FQryComand:= fCriaQuery;
     Try
       FQryComand.SQL.Add('DELETE FROM IMENDES_PARAM WHERE AUTOINCREM = "'+dtsDados.DataSet.FieldByName('AUTOINCREM').AsString+'"');
       FQryComand.ExecSQL;
       dtsDados.DataSet.Close;
       dtsDados.DataSet.Open;
     Finally
       FreeAndNil(FQryComand);
     End;
  End
end;

procedure TfrmImendesProcessos.cxvFinalizarPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  If IntegerToEstadoProcessamento(dtsDados.DataSet.FieldByName('MAQUINA_ESTADO').AsInteger) in[ epFinalizadoOk, epFinalizadoSemItem, epFinalizadoComErro, epFinalizadoPeloAutcom, epFalhaAutenticacao, epFinalizadoItemNaoEncontradoNaImendes] then
  Begin
    pMensagemOk('consulta já finalizada!');
    Exit;
  End;

  If fPergunta('Finalizar esta Consulta?') then
  Begin
     FQryComand:= fCriaQuery;
     Try
       FQryComand.SQL.Add('UPDATE IMENDES_PARAM SET MAQUINA_ESTADO = ' + fEstadoProcessamentoToInteger(epFinalizadoPeloAutcom).ToString  + ' WHERE AUTOINCREM = "'+dtsDados.DataSet.FieldByName('AUTOINCREM').AsString+'"');
       FQryComand.ExecSQL;
       dtsDados.DataSet.Close;
       dtsDados.DataSet.Open;
     Finally
       FreeAndNil(FQryComand);
     End;
  End
end;

function TfrmImendesProcessos.fGeraConsulta(
  pgbProgresso: TcxProgressBar): Boolean;

  var
    strSQLBase, strSQLWhere: String;
begin
  FQryComand := fCriaQuery;
  Try
    fStartTransaction;
    Try

      strSQLBase := '';
      strSQLWhere := '';

      strSQLBase := strSQLBase + 'SELECT IME_CODITE FROM IMENDES_ITENS I ';
      strSQLWhere := strSQLWhere + ' WHERE IME_SEQCON = "' + dtsDados.DataSet.FieldByName('AUTOINCREM').AsString + '"';
      case FTipoGeracao of
        ttgItensComRetParcial   : strSQLWhere := strSQLWhere + ' AND I.IME_RETPAR = 1';
        ttgItensComDivergencia  : strSQLWhere := strSQLWhere + ' AND I.IME_DIFICM = 1 AND I.IME_SEMEAN = 0';
        ttgNaoEncontradoImendes : strSQLWhere := strSQLWhere + ' AND I.IME_SEMIME = 1 AND I.IME_SEMEAN = 0';
        ttgCodBarrasInvalido    : strSQLWhere := strSQLWhere + ' AND I.IME_SEMEAN = 1';
      End;

      strSQLBase := strSQLBase + strSQLWhere;


      FQryComand.SQL.Clear;
      frmGravando.lblGravando.Caption := 'Atualizando itens da Consulta Original para reprocessamento.';
      Application.ProcessMessages;
      FQryComand.SQL.Add('UPDATE IMENDES_ITENS I SET I.IME_PROCES = 0, I.IME_SEMEAN = 0, I.IME_RETPAR = 0, I.IME_SEMIME = 0, IME_DIFICM = 0,IME_REPROS =1');
      FQryComand.SQL.Add(strSQLWhere);
      FQryComand.ExecSQL;

      pgbProgresso.Position := 3;

      FQryComand.SQL.Clear;
      frmGravando.lblGravando.Caption := 'Atualizando estado da Consulta Original para reprocessamento.';
      Application.ProcessMessages;
      FQryComand.SQL.Add('UPDATE IMENDES_PARAM SET STATUS = "P", MAQUINA_ESTADO = '+fEstadoProcessamentoToInteger(epReprocessaItensParcialmente).ToString+' WHERE AUTOINCREM = "' + dtsDados.DataSet.FieldByName('AUTOINCREM').AsString +'"');
      FQryComand.ExecSQL;
      pgbProgresso.Position := 4;
      Result := True;

      fCommit;
    Except
      on e: exception do
      begin
        Result := False;
        fRollBack;
        pMensagensErro(e.message, '[TfrmImendesProcessos.fGeraConsulta]');
      End;
    End;
  Finally
    FreeAndNil(FQryComand);
  End;
end;

procedure TfrmImendesProcessos.FormActivate(Sender: TObject);
begin
  inherited;
  cxvQtdErro.Width := 64;
  cxvProgresso.Width := 100;
  cxvDescricao.Width := 200;
  cxvData.Width := 105;
  cxvSituacao.Width := 130;
  cxvProgresso.Width := 110;
  cxvExcluir.Width := 55;
  cxvEmpresa.Width := 192;
end;

procedure TfrmImendesProcessos.FormCreate(Sender: TObject);
begin
  inherited;
  strAutIncSel := '';
end;




procedure TfrmImendesProcessos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F5 Then
     btnAtualiza.Click;
  If Key = VK_F6 Then
    btnGerarNovaConsulta.Click;

end;

function TfrmImendesProcessos.fTemImendes_AbfIcm_para_deletar(strSQLBase: String): Boolean;
 var qryItens: TUniQuery;
begin
  Result := False;
  qryItens := fCriaQuery;
  Try
    qryItens.SQL.Add('SELECT IME_SEQCON FROM IMENDES_ABFICM WHERE IME_SEQCON = "' + dtsDados.DataSet.FieldByName('AUTOINCREM').AsString + '" AND IME_CODITE IN ('+strSQLBase+') LIMIT 1');
    qryItens.Open;
    Result := Not qryItens.IsEmpty;
  Except
    FreeAndNil(qryItens);
  End;
end;

end.
