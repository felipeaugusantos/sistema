unit untTValidaGravacaoPedidoCompra;

interface

uses Forms, data.db, System.SysUtils, uni, CxProgressBar, Math, Classes, untGravando;

Type

  TTIpoLogValidacaoPedido = (tlvpdcDivengenciaDistribuicao, tlvpdcDivergenciaGeracao);

  TValidadorPcddet = record
    strEmpDes: String;
    fltQtdIte: Double;
    blnGerado: Boolean;
  end;

  TArrValidadorPcddet = array of TValidadorPcddet;


  TValidadorPcmDet = record
    index: integer;
    item: String;
    DescItem:string;
    fltQtdIte: Double;
    fltQtdDistribuida: Double;
    fltQtdGerado: Double;
    ArrPcddet: TArrValidadorPcddet;
    procedure pAddPcdDet(ACodEmp: String; AQtdIte: Double);
  End;

  TArrValidadorPcmdet = array of TValidadorPcmDet;


  TValidadorPedidoCompra = class
  protected
    qryLog: TUniQuery;
    FCdsItensPedidos: TDataSet;
    FCdsMultiLojas: TDataSet;
    ArrValidadorPcmdet: TArrValidadorPcmdet;
    frmGravando: TfrmGravando;

    function fGetIndex(ACodIte: string): integer;
    procedure pCriaEstrutura;
    function fCriaEstrutura(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pAddItem(ACodIte, ADescItem: string; AQtdItem: Double);
    procedure pGravaErro(ATipoLog: TTIpoLogValidacaoPedido);
    function fGetErrosDistribuicao: string;
    function fGetErrosGeracao: string;



  public
    class procedure pInicia(CdsPedidos, cdsMultiloja: TDataSet);
    procedure pGravaLog(ATipoLog: TTIpoLogValidacaoPedido);
    function fValidaQuantidadeDistribuida(ALogErro: TStringList): Boolean;
    function fValidaQuantidadeGerada(ALogErro: TStringList): Boolean;
    procedure pAddGeracaoItemMultiloja(ACodIte, ACodEmp: String; AQtdGer: Double);
    class var ValidadorPedidoCompra: TValidadorPedidoCompra;
    class procedure LimparDaMemoria;

  end;

  implementation



{ TValidadorPedidoCompra }

uses untFuncoesSimples;



procedure TValidadorPedidoCompra.pAddGeracaoItemMultiloja(ACodIte,
  ACodEmp: String; AQtdGer: Double);
  var i, Index : Integer;

begin
  Index := fGetIndex(ACodIte);
  If Index = -1 Then
    Raise Exception.Create('Falha ao encontar item!');
  ArrValidadorPcmdet[Index].fltQtdGerado := ArrValidadorPcmdet[Index].fltQtdGerado + AQtdGer;
  For i := 0 to High(ArrValidadorPcmdet[Index].ArrPcddet) do
  Begin
    If ArrValidadorPcmdet[Index].ArrPcddet[i].strEmpDes =  ACodEmp then
      ArrValidadorPcmdet[Index].ArrPcddet[i].blnGerado := True;
  End
end;

procedure TValidadorPedidoCompra.pAddItem(ACodIte, ADescItem: string; AQtdItem: Double);
begin
  SetLength(ArrValidadorPcmdet, succ(Length(ArrValidadorPcmdet)));
  ArrValidadorPcmdet[High(ArrValidadorPcmdet)].Item := ACodIte;
  ArrValidadorPcmdet[High(ArrValidadorPcmdet)].DescItem := ADescItem;
  ArrValidadorPcmdet[High(ArrValidadorPcmdet)].fltQtdIte := AQtdItem;
  ArrValidadorPcmdet[High(ArrValidadorPcmdet)].fltQtdDistribuida := 0;
  ArrValidadorPcmdet[High(ArrValidadorPcmdet)].fltQtdGerado := 0;
  ArrValidadorPcmdet[High(ArrValidadorPcmdet)].index := High(ArrValidadorPcmdet);
end;

procedure TValidadorPedidoCompra.pCriaEstrutura;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Criando estrutura para validação...';
    frmGravando.fExecutarAcao := fCriaEstrutura;
    frmGravando.ShowModal;
  finally
    FreeAndNil(frmGravando)
  End;
  {}
end;


procedure TValidadorPedidoCompra.pGravaErro(ATipoLog: TTIpoLogValidacaoPedido);
begin
  case ATipoLog of
    tlvpdcDivengenciaDistribuicao:
      Begin
        qryLog.ParamByName('CODERR').AsInteger := 1;
        qryLog.ParamByName('LOGERR').AsString := fGetErrosDistribuicao;

      End;
    tlvpdcDivergenciaGeracao:
      Begin
        qryLog.ParamByName('CODERR').AsInteger := 2;
        qryLog.ParamByName('LOGERR').AsString := fGetErrosGeracao;
      End;
  End;
  qryLog.ExecSQL;
end;


procedure TValidadorPedidoCompra.pGravaLog(ATipoLog: TTIpoLogValidacaoPedido);
begin
  pGravaErro(ATipoLog)
end;

{ TValidadorPedidoCompra }

function TValidadorPedidoCompra.fCriaEstrutura(
  pgbStatus: TcxProgressBar): Boolean;
var intQtdReq: integer;
    indexItem: integer;
begin
  Result := True;
  Try
    intQtdReq := 0;
    pgbStatus.Properties.Max := FCdsItensPedidos.RecordCount + FCdsMultiLojas.RecordCount;
    FCdsItensPedidos.First;
    SetLength(ArrValidadorPcmdet, 0);
    frmGravando.lblGravando.Caption := 'Criando estrutura para validação(produtos totais)';
    while Not FCdsItensPedidos.Eof do
    Begin
      pAddItem(FCdsItensPedidos.FieldByName('ITE_CODITE').AsString,
               FCdsItensPedidos.FieldByName('ITE_DESITE').AsString,
               FCdsItensPedidos.FieldByName('ITE_QTDITE').AsFloat);
      FCdsItensPedidos.Next;
      Inc(intQtdReq);
      pgbStatus.Position := intQtdReq;
      If (intQtdReq mod 10)  = 0 then
        Application.ProcessMessages;
    End;
    FCdsItensPedidos.First;

    FCdsMultiLojas.First;
    frmGravando.lblGravando.Caption := 'Criando estrutura para validação(produtos por loja)';
    while Not FCdsMultiLojas.Eof do
    Begin
      indexItem := fGetIndex(FCdsMultiLojas.FieldByName('ITE_CODITE').AsString);
      If indexItem >= 0 Then
      Begin
        ArrValidadorPcmdet[indexItem].pAddPcdDet(FCdsMultiLojas.FieldByName('ITE_CODEMP').AsString,
                                               FCdsMultiLojas.FieldByName('ITE_QTDITE').AsFloat);
        ArrValidadorPcmdet[indexItem].fltQtdDistribuida :=  ArrValidadorPcmdet[indexItem].fltQtdDistribuida +
                                                            FCdsMultiLojas.FieldByName('ITE_QTDITE').AsFloat;

        Inc(intQtdReq);
        pgbStatus.Position := intQtdReq;
        If (intQtdReq mod 10) = 0 then
          Application.ProcessMessages;
      End;
      FCdsMultiLojas.Next;
    end;
    FCdsMultiLojas.First;
  Except
    On E: Exception do
    begin
      pMensagensErro(e.Message, '[TValidadorPedidoCompra.fCriaEstrutura]');
    end;
  End;
end;

function TValidadorPedidoCompra.fGetErrosDistribuicao: string;
var ValidadorPcmDet: TValidadorPcmDet;
    ValidadorPcddet: TValidadorPcddet;
begin
  Result := '';
  For ValidadorPcmDet in ArrValidadorPcmdet do
  begin
    If ValidadorPcmDet.fltQtdIte <> ValidadorPcmDet.fltQtdDistribuida then
    begin
      Result := Result + #$A +'----------------------------------------------------------------------------------------------------------------------------------' + #$A;
      Result := Result + Copy('Item: '+ ValidadorPcmDet.item + ' - ' + ValidadorPcmDet.DescItem, 1, 131) + #$A;
      Result := Result + '  Qtd. Pedido: ' + FloatToStr(ValidadorPcmDet.fltQtdIte) + ' | Qtd. Distribuida entre lojas: ' + FloatToStr(ValidadorPcmDet.fltQtdDistribuida) + #$A;
      For ValidadorPcddet in  ValidadorPcmDet.ArrPcddet do
        Result := Result + '    Loja: ' + ValidadorPcddet.strEmpDes + ' | Qtd: ' + FloatToStr(ValidadorPcddet.fltQtdIte) + #$A ;
    end;
  End;
  If Result <> '' Then
    Result := '***************************************************************Atenção************************************************************' + #$A +
              'A equipe de desenvolvimento Citel pede desculpas pelo transtorno, precisamos do seu apoio para identificar a causa deste problema.' + #$A +
              'Caso lembre do passo a passo realizado em tela para este erro ocorrer, entre em contato com a Citel!' + #$A +
              '**********************************************************************************************************************************' + #$A#$D +
              'Foram encontradas divergências entre os itens solicitados e a quantidade distribuída entre as lojas.' + #$A +
              'Ajuste os itens abaixo para prosseguir!' + #$A +
              Result;
end;

function TValidadorPedidoCompra.fGetErrosGeracao: string;
var ValidadorPcmDet: TValidadorPcmDet;
    ValidadorPcddet: TValidadorPcddet;
begin
  Result := '';
  For ValidadorPcmDet in ArrValidadorPcmdet do
  begin
    If ValidadorPcmDet.fltQtdIte <> ValidadorPcmDet.fltQtdGerado then
    begin
      Result := Result + #$A +'----------------------------------------------------------------------------------------------------------------------------------' + #$A;
      Result := Result + Copy('Item: '+ ValidadorPcmDet.item + ' - ' + ValidadorPcmDet.DescItem, 1, 131) + #$A;
      Result := Result + '  Qtd. Pedido: ' + FloatToStr(ValidadorPcmDet.fltQtdIte) + ' | Qtd. Gerada entre lojas: ' + FloatToStr(ValidadorPcmDet.fltQtdGerado) + #$A;
      For ValidadorPcddet in  ValidadorPcmDet.ArrPcddet do
        If Not ValidadorPcddet.blnGerado Then
          Result := Result + 'Loja: ' + ValidadorPcddet.strEmpDes + ' | Qtd: ' + FloatToStr(ValidadorPcddet.fltQtdIte) + #$A;
    end;
  End;
  If Result <> '' Then
    Result := '***************************************************************Atenção************************************************************' + #$A +
              'A equipe de desenvolvimento Citel pede desculpas pelo transtorno, precisamos do seu apoio para identificar a causa deste problema.' + #$A +
              'Caso lembre do passo a passo realizado em tela para este erro ocorrer, entre em contato com a Citel!' + #$A +
              '**********************************************************************************************************************************' + #$A#$D +
              'Foram encontradas divergências entre os itens solicitados e a quantidade distribuída entre as lojas.' + #$A +
              'Ajuste os itens abaixo para prosseguir!' + #$A +
              Result;
end;

function TValidadorPedidoCompra.fGetIndex(ACodIte: string): integer;
var  ValidadorPcmDet: TValidadorPcmDet;
begin
  Result := -1;
  for ValidadorPcmDet in ArrValidadorPcmdet do
  begin
    If ValidadorPcmDet.item = ACodIte then
      Exit(ValidadorPcmDet.index);
  End;
end;

class procedure TValidadorPedidoCompra.pInicia(CdsPedidos,
  cdsMultiloja: TDataSet);
begin
  TValidadorPedidoCompra.ValidadorPedidoCompra := TValidadorPedidoCompra.Create;
  TValidadorPedidoCompra.ValidadorPedidoCompra.FCdsItensPedidos := cdsPedidos;
  TValidadorPedidoCompra.ValidadorPedidoCompra.FCdsMultiLojas := cdsMultiloja;
  TValidadorPedidoCompra.ValidadorPedidoCompra.pCriaEstrutura;
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog := fCriaQuery;
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('INSERT INTO LOGPED (');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('  LOG_DTAEVE,');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('  LOG_CODERR,');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('  LOG_LOGERR,');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('  LOG_CON_ID,');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('  LOG_HOREVE');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add(')');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('VALUES');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('  ( CURDATE(),');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('    :CODERR,');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('    :LOGERR,');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('    CONNECTION_ID(),');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('    CURTIME()');
  TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog.SQL.Add('  );');
end;

class procedure TValidadorPedidoCompra.LimparDaMemoria;
begin
  If  Assigned(TValidadorPedidoCompra.ValidadorPedidoCompra) then
  Begin
    FreeAndNil(TValidadorPedidoCompra.ValidadorPedidoCompra.qryLog);
    FreeAndNil(TValidadorPedidoCompra.ValidadorPedidoCompra);
  end;
end;

function TValidadorPedidoCompra.fValidaQuantidadeDistribuida(ALogErro: TStringList): Boolean;
var  ValidadorPcmDet: TValidadorPcmDet;
begin
  ALogErro.Text := '';
  Result := True;
  Try
    for ValidadorPcmDet in ArrValidadorPcmdet do
      If ValidadorPcmDet.fltQtdDistribuida <> ValidadorPcmDet.fltQtdIte Then
        Exit(False);
  Finally
    If Not Result Then
      ALogErro.Text := fGetErrosDistribuicao;
  End

end;

function TValidadorPedidoCompra.fValidaQuantidadeGerada(ALogErro: TStringList): Boolean;
var  ValidadorPcmDet: TValidadorPcmDet;
begin
  ALogErro.Text := '';
  Result := True;
  Try
    for ValidadorPcmDet in ArrValidadorPcmdet do
      If RoundTo(ValidadorPcmDet.fltQtdGerado,-4) <> RoundTo(ValidadorPcmDet.fltQtdIte,-4) Then
        Exit(False);
  Finally
    If Not Result Then
      ALogErro.Text := fGetErrosGeracao;
  End
end;

{ TValidadorPcmDet }
procedure TValidadorPcmDet.pAddPcdDet(ACodEmp: String; AQtdIte: Double);
begin
  SetLength(ArrPcddet, succ(Length(ArrPcddet)));
  ArrPcddet[High(ArrPcddet)].strEmpDes := ACodEmp;
  ArrPcddet[High(ArrPcddet)].fltQtdIte := AQtdIte;
  ArrPcddet[High(ArrPcddet)].blnGerado := False;
end;

end.






