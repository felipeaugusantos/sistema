unit untCancelaOrdemProdIndustrial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, DBCtrls, DBEditFocus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, AppEvnts, Menus, Buttons, BitBtnLockedIncrem, ExtCtrls,
  untOrdProIndustrial, Uni, DB, frxClass, frxExportCSVTestabilidade, untLiberacao;

type
  TfrmCancelaOrdemProdIndustrial = class(TfrmPaiConfirma)
    pnl1: TPanel;
    lbl1: TLabel;
    lbl5: TLabel;
    mskDtaCad: TMaskEditFocus;
    edtNumOrd: TEditFocus;
    dbeCodIte: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    dtsOrdPro: TDataSource;
    procedure edtNumOrdKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
     qryOrdPro: TUniQuery;
     objOrdPro: TOrdProIndustrial;
     objLiberacao : TLiberacao;
    function fValidaBaixaParcial: Boolean;
    procedure pLimpaCampos;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncFat;
{$R *.dfm}

procedure TfrmCancelaOrdemProdIndustrial.btnConfirmaClick(Sender: TObject);
begin

  If Not fVerificaCampos Then
    Exit;

  If ( (not fCfgSis('OIBXPA', varBoolean)) And (qryOrdPro.FieldByName('DTABAI').AsDateTime <> VS_Date)) Or
     ( fCfgSis('OIBXPA', varBoolean) And objOrdPro.fTemBaixaTotal(qryOrdPro.FieldByName('AUTINC').AsString) And (objOrdPro.fGetDataUltimaBaixa(qryOrdPro.FieldByName('AUTINC').AsString) <> VS_Date) ) Then
  Begin
    //Result := False;
    //pMensagemOk('O cancelamento da baixa da ordem de Produção somente pode ser feito no mesmo dia da baixa. ' +
    //            'Essa ordem foi baixada em ' +  FormatDateTime('DD/MM/YYYY', qryOrdPro.FieldByName('DTABAI').AsDateTime) + ' !');

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Cancelar Ordem de Produção ' + edtNumOrd.Text + '-' + mskDtaCad.Text + ' Baixada em : ' + FormatDateTime('DD/MM/YYYY', qryOrdPro.FieldByName('DTABAI').AsDateTime));
    objLiberacao.objMsgLibera.pAddTexto('O custo dos produtos acabados dessa ordem de produção, não vão sofrer alteração no estorno mas será recalculado ao baixar a ordem de produção');
    objLiberacao.objMsgLibera.pAddTexto('novamente!');

    objLiberacao.strDirAce := 'CNCOPI';
    objLiberacao.strMsgSen := 'Senha para liberação de cancelamento de baixa de ordem de produçao industrial baixada em data anterior a atual';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    If Not objLiberacao.fLibera Then
      Exit;
  End;

  If fCfgSis('OIBXPA', varBoolean) Then
  Begin
    If not fValidaBaixaParcial Then
      Exit;
  End
  Else
  Begin
    If not fPergunta('Confirma o cancelamento da Baixa da Ordem de Produção?') Then
      Exit;
  End;



  If objOrdPro.fCancelaBaixa(qryOrdPro.FieldByName('AUTINC').AsString, objOrdPro.fGetDataUltimaBaixa(qryOrdPro.FieldByName('AUTINC').AsString) = VS_Date ) Then
  Begin
    pMensagemOk('Operação realizada com sucesso!');
    pLimpaCampos
  End;

end;

procedure TfrmCancelaOrdemProdIndustrial.pLimpaCampos;
Begin
  edtNumOrd.Clear;
  mskDtaCad.Clear;
  dbeDesIte.Clear;
  dbeCodIte.Clear;

  pSetFocus(edtNumOrd);
End;

function TfrmCancelaOrdemProdIndustrial.fValidaBaixaParcial : Boolean;
Begin

  If fCfgSis('OIBXPA', varBoolean) Then
  Begin
    If objOrdPro.fTemBaixaTotal(qryOrdPro.FieldByName('AUTINC').AsString) Then
    Begin
      Result := fMensagem('', 'Essa ordem de produção já foi baixada por completo!' + #13 +
                              'Deseja continuar e estornar todas as baixas realizadas?', ['&Sim', '&Não'], 2) = 1;
    End
    Else
      If objOrdPro.fFoiBaixaPrdNaoRealizada(qryOrdPro.FieldByName('AUTINC').AsString) Then
        Result := True
      Else
        Result := objOrdPro.fConfirmaUltimaBaixaRealizada(qryOrdPro.FieldByName('AUTINC').AsString);
  End
  Else
    Result := True;

End;

procedure TfrmCancelaOrdemProdIndustrial.edtNumOrdKeyPress(Sender: TObject; var Key: Char);
  Var
    arrTabela : TConsultasArray;
begin
  inherited;

  If fPesqOrdProIndustrial(Self, edtNumOrd, mskDtaCad, Nil, Key, arrTabela, poiCodigo, False, staBaixadas) Then
  Begin
    If fValidaCampos(edtNumOrd, True) And
       fValidaCampos(mskDtaCad, True) Then
    Begin
      pSetFocus(btnConfirma);
    End;
  End;
end;

procedure TfrmCancelaOrdemProdIndustrial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (not fEmptyStr(edtNumOrd.Text)) And (not fEmptyDate(mskDtaCad.Text)) Then
  Begin
    Action := caNone;
    if fMensagem('', 'Deseja cancelar a operação?', ['&Sim', '&Não'], 2) = 2 Then
    Begin
      Exit;
    End
    Else
    Begin
      pLimpaCampos;
    End;

  end;

  inherited;

end;

procedure TfrmCancelaOrdemProdIndustrial.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
  objOrdPro := TOrdProIndustrial.Create(Self, Nil, Nil, False, True);
  qryOrdPro := fCriaQuery(Self);
  dtsOrdPro.DataSet := qryOrdPro;
end;

procedure TfrmCancelaOrdemProdIndustrial.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objOrdPro);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;
end;

function TfrmCancelaOrdemProdIndustrial.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumOrd) Then
    Begin

      If fEmptyStrEspeciais(edtNumOrd.Text) Then
      Begin
        pMensagemOk('Informe o Número da Ordem de Produção!');
        Result := False;
      End

    End

    Else If (Sender = mskDtaCad) Then
    Begin

      If fEmptyDate(mskDtaCad.Text) Then
      Begin
        pMensagemOk('Informe a Data de Cadastro da Ordem de Produção!');
        Result := False;
      End

      Else If Not objOrdPro.fExisteLoteOP(qryOrdPro, edtNumOrd.Text, StrToDateDef(mskDtaCad.Text, 0)) Then
      Begin
        Result := False;
        pMensagemOk('Ordem de Produção não encontrada!');
      End

      Else If (qryOrdPro.FieldByName('DTABAI').IsNull) And (objOrdPro.fGetDataUltimaBaixa(qryOrdPro.FieldByName('AUTINC').AsString) = 0) Then
      Begin
        Result := False;
        pMensagemOk('Essa ordem de Produção ainda não foi baixada!');
      End

      Else If (not fCfgSis('OIBXPA', varBoolean)) And
              (Not objOrdPro.fTemDadosBaixaSalvos(qryOrdPro.FieldByName('AUTINC').AsString)) And
              (qryOrdPro.FieldByName('BAINPD').AsString = 'N') Then
      Begin
        Result := False;
        pMensagemOk('Essa Ordem de Produção não pode ser cancelada porque seus dados de baixa não foram salvos!');
      End

      Else If Not(objOrdPro.fOrdemDeProducaoIndustrialJaEnderecada(qryOrdPro.FieldByName('AUTINC').AsString)) Then
      Begin
        Result := False;
        pMensagemOk('Essa Ordem de Produção não pode ser cancelada, pois, a mesma já se encontra endereçada!');
      End


      Else
      Begin
        mskDtaCad.Text := FormatDateTime('DD/MM/YYYY', StrToDateDef(mskDtaCad.Text, 0));
      End

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
