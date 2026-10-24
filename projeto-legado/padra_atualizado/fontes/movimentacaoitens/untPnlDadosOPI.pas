unit untPnlDadosOPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UniClientDataSet, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, untFuncoesSimples, Uni;

type
  TfrmPnlDadosOPI = class(TForm)
    btnBaixarOpi: TBitBtnLocked;
    procedure btnBaixarOpiClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    strCodOco,
    strMotivo: String;
    procedure pBaixarOpiNaoProduzida;
    function tmrAtualizarDados: TNewTimer;
    procedure tmrAtualizarDadosTimer(Sender: TObject);
    procedure pAtualizaDados;
    function fInformarOcorrencia: Boolean;
    function fLiberarBaixa: Boolean;
  public
    cdsConsulta: TUniClientDataSet;
    procedure pParouNavegacaoGridConsulta;
  end;

  TfrmPnlDadosOPIClass = Class Of TfrmPnlDadosOPI;

var
  frmPnlDadosOPI: TfrmPnlDadosOPI;

implementation

uses
  untDigOcorrencia, untLiberacao, untOrdProIndustrial;

{$R *.dfm}

{ TfrmPnlDadosOPI }


procedure TfrmPnlDadosOPI.btnBaixarOpiClick(Sender: TObject);
begin
  pBaixarOpiNaoProduzida;
end;

procedure TfrmPnlDadosOPI.FormDestroy(Sender: TObject);
begin
  TNewTimer.Del(Self.Name + '.tmrAtualizarDados');
end;

procedure TfrmPnlDadosOPI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F4: If btnBaixarOpi.Enabled Then
           Begin
             btnBaixarOpi.Click;
             Key := 0;
           End;
  End;
end;

procedure TfrmPnlDadosOPI.pAtualizaDados;
begin
  btnBaixarOpi.Enabled := cdsConsulta.FieldByName('ORD_BAIXAD').AsString = 'NÃO';
end;

procedure TfrmPnlDadosOPI.pBaixarOpiNaoProduzida;
var
  qryUpd: TUniQuery;
  objOrdInd: TOrdProIndustrial;
begin
  If Not fInformarOcorrencia Then
    Exit;
  If Not fLiberarBaixa Then
    Exit;

  qryUpd := fCriaQuery;
  objOrdInd := TOrdProIndustrial.Create(Nil);
  Try
    fStartTransaction;
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('UPDATE ORDGER SET ORD_DTABAI = CURDATE(), ORD_CODOCO = :CODOCO, ORD_BAINPD = "S", ORD_OPEBAI = :OPEBAI WHERE AUTOINCREM = :AUTINC');
    qryUpd.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    qryUpd.ParamByName('CODOCO').AsString := strCodOco;
    qryUpd.ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;
    qryUpd.ExecSQL;

    qryUpd.SQL.Clear;
    qryUpd.SQL.ADD('REPLACE INTO ORDHIS(AUTOINCREM, ORD_SEQGER, ORD_HISTOR) VALUES(:AUTINC, :SEQGER, :HISTOR)');
    qryUpd.ParamByName('AUTINC').AsString := fRetAutoIncrem('ORDHIS', VS_strCodEmp);
    qryUpd.ParamByName('SEQGER').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    qryUpd.ParamByName('HISTOR').AsString := 'Produção não realizada. Ocorrência: ' + strCodOco + '-' + strMotivo ;
    qryUpd.ExecSQL;

    objOrdInd.pApagaReservaOP(cdsConsulta.FieldByName('AUTOINCREM').AsString);

    Try
      fCommit;
      pMensagemOk('Baixa realizada com sucesso!');
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmPnlDadosOPI.pBaixarOpiNaoProduzida]');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
    FreeAndNil(objOrdInd);
    cdsConsulta.Refresh;
  End;
end;

function TfrmPnlDadosOPI.fLiberarBaixa: Boolean;
var
  objLiberacao: TLiberacao;
begin
  Try
    objLiberacao := TLiberacao.Create;
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(113);
    objLiberacao.objMsgLibera.pAddTexto('BAIXA DE ORDEM DE PRODUÇÃO SEM REALIZAR FABRICAÇÃO');
    objLiberacao.objMsgLibera.pAddSeparador(113);
    objLiberacao.objMsgLibera.pAddTexto('ORDEM DE PRODUÇÃO: ' + cdsConsulta.FieldByName('ORD_CODORD').AsString + '     DATA DE CADASTRO: ' + cdsConsulta.FieldByName('ORD_DTACAD').AsString);
    objLiberacao.objMsgLibera.pAddSeparador(113);
    objLiberacao.objMsgLibera.pAddTexto('PRODUTO: ' + cdsConsulta.FieldByName('ORD_CODITE').AsString + '-' + cdsConsulta.FieldByName('ITE_DESITE').AsString);
    objLiberacao.objMsgLibera.pAddTexto('QUANTIDADE: ' + FloatToStr(fFormataFloat(cdsConsulta.FieldByName('ORD_TOTPRO').AsFloat, 4)) + '     DATA DE PREV. PRODUÇÃO: ' + cdsConsulta.FieldByName('ORD_DTAPRE').AsString);
    objLiberacao.objMsgLibera.pAddTexto('PEDIDO: ' + cdsConsulta.FieldByName('ORD_PEDIDO').AsString);
    objLiberacao.objMsgLibera.pAddTexto('OBSERVAÇÃO: ' + cdsConsulta.FieldByName('ORD_OBSEXT').AsString);

    objLiberacao.strDirAce := 'BAIXAOPISEMPRODUCAO';
    objLiberacao.strMsgSen := 'Permitir baixa de OPI sem produção';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;

  Finally
    FreeAndNil(objLiberacao);
  End;
End;

procedure TfrmPnlDadosOPI.pParouNavegacaoGridConsulta;
begin
  If (Not Self.Showing) Then
    Exit;

  Try
    tmrAtualizarDados.Enabled := False;
    tmrAtualizarDados.Enabled := True;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + ': ' + SysErrorMessage(GetLastError));
  End;
end;

function TfrmPnlDadosOPI.tmrAtualizarDados: TNewTimer;
begin
  if not TNewTimer.Has(Self.Name + '.tmrAtualizarDados') then
  begin
    Result := TNewTimer.Get(Self.Name + '.tmrAtualizarDados');
    Result.Timeout  := 2000;
    Result.Interval := 300;
    Result.Enabled  := False;
    Result.OnTimer  := tmrAtualizarDadosTimer;
  end
  else
    Result := TNewTimer.Get(Self.Name + '.tmrAtualizarDados');
end;

procedure TfrmPnlDadosOPI.tmrAtualizarDadosTimer(Sender: TObject);
begin
  tmrAtualizarDados.Enabled := False;
  pAtualizaDados;
end;

function TfrmPnlDadosOPI.fInformarOcorrencia: Boolean;
begin
  try
    Try
      pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);
      frmDigOcorrencia.blnInformarHisCom := False;
      If (frmDigOcorrencia.ShowModal = mrOk) Then
      Begin
        strCodOco := frmDigOcorrencia.strCodOco;
        strMotivo := frmDigOcorrencia.strDesOco;
        Result := True;
      End
      Else
        Result := False;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;
  finally
    pFreeAndNil(frmDigOcorrencia);
  end;
end;

end.
