unit untPnlDadosCancelamentoDocumentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Uni,
  BitBtnLockedIncrem, Vcl.ExtCtrls, UniClientDataSet, untClassPanelCx;

type
  TfrmPnlDadosCancelamentoDocumentos = class(TForm)
    pnl1: TPanel;
    btnCancelamentoNaoAutorizado: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelamentoNaoAutorizadoClick(Sender: TObject);
  private
    { Private declarations }
  public
    cdsConsulta: TUniClientDataSet;
    objPanel   : TPanelCX;
//    blnConfirma: Boolean;
    constructor Create(AOwner: TComponent); reintroduce; virtual;
    { Public declarations }
  end;

    TfrmPnlDadosCancelamentoDocumentosClass = Class Of TfrmPnlDadosCancelamentoDocumentos;

var
  frmPnlDadosCancelamentoDocumentos: TfrmPnlDadosCancelamentoDocumentos;

implementation

uses untAtualizaOcorrenciasCRM, untFuncoesCRM, untTypesCRM, untFuncoesSimples,
  untObservacaoCRM;

{$R *.dfm}

{ TfrmPnlDadosCancelamentoDocumentos }

procedure TfrmPnlDadosCancelamentoDocumentos.btnCancelamentoNaoAutorizadoClick(
  Sender: TObject);
var
  objOcoCrm:  TAtuOcoCrm;
  qryAux001:  TUniQuery;
  blnResult:  Boolean;
  blnCommit:  Boolean;
  strObsFinaliza: String;


  function fGetObservacao(blnFinaliza : Boolean): String;
  begin
    Try
      pCriarFormularios(TfrmObservacaoCRM, frmObservacaoCRM);
      frmObservacaoCRM.memObs.Lines.Clear;
      frmObservacaoCRM.blnFinaliza := blnFinaliza;
      If frmObservacaoCRM.ShowModal = MrOK Then
        Result := frmObservacaoCRM.memObs.Text
      Else
        Result := '##SAIR##';
    Finally
      pFreeAndNil(frmObservacaoCRM);
    End;
  end;

begin
  if fMensagem('','Baixar o protocolo selecionado?', ['&Sim', '&Não']) = 2 Then
    Exit;

  blnCommit := Not fInTransaction;
  blnResult := true;

  try

    qryAux001 := fCriaQuery;

    fStartTransaction;
    self.tag := 2;

    try

      With qryAux001, SQL Do
      Begin
        Close;
        Clear;
        Add('  UPDATE PROCRM ');
        Add('     SET PRO_OPEBAI = :OPEBAI, ');
        Add('                   PRO_DTABAI = :DTABAI  ');

        Add(' WHERE AUTOINCREM = :AUTINC              ');
        ParamByName('AUTINC').AsString   := cdsConsulta.fieldbyname('AUTOINCREM').asstring;
        ParamByName('OPEBAI').AsString   := strLoginUsuarioLogado;
        ParamByName('DTABAI').AsDateTime := fNow;

        ExecSQL;
        Close;
      End;

      objOcoCrm := fAtualizaInformacoesCRM(cdsConsulta.fieldbyname('PRO_NUMDOC').asstring,
                                           cdsConsulta.fieldbyname('PRO_ESPSEL').asstring,
                                           VS_strCodEmp,
                                           cdsConsulta.fieldbyname('PRO_CLIFOR').asstring,
                                           cdsConsulta.fieldbyname('PRO_ESPSEL').asstring,
                                           cdsConsulta.fieldbyname('PRO_ESPSEL').asstring,
                                           strLoginUsuarioLogado,
                                           afcNenhum);
      objOcoCrm.strCodOco := fCampoTabela('PRO_CODOCO', 'PROCRM', ['AUTOINCREM'], [cdsConsulta.fieldbyname('AUTOINCREM').asstring]);
      objOcoCrm.strNomFrm := Self.Name;

      If not fEmptyStr(objOcoCrm.strCodOco) Then
      Begin
        objOcoCrm.strDtaInc := VS_Date;
        objOcoCrm.strHorInc := fNow;
        objOcoCrm.strDtaAge := objOcoCrm.strDtaInc;
        objOcoCrm.strHorAge := objOcoCrm.strHorInc;
        objOcoCrm.strOpeHis := strLoginUsuarioLogado;
        objOcoCrm.strDtaCon := VS_Date;
        objOcoCrm.strHorCon := fNow;
        If Pos(cdsConsulta.fieldbyname('PRO_ESPSEL').asstring, 'PD') > 0 Then
          objOcoCrm.strCodToc := fCfgSis('PEDCAN', varString)
        Else
          objOcoCrm.strCodToc := fCfgSis('VENCAN', varString);

        strObsFinaliza := fGetObservacao(true);

        If strObsFinaliza = '##SAIR##' Then
        Begin
          blnResult := False;
          exit;
        End;

        objOcoCrm.strDescri := IIF((Not fEmptyStr(strObsFinaliza)), strObsFinaliza + '<<csq>>', '')+
                               'CANCELAMENTO NÃO AUTORIZADO.' + '<<csq>>'+
                               'FINALIZANDO OCORRÊNCIA.' + '<<csq>><<csq>>'+
                               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) +
                               '<<csq>>' +
                                DateToStr(VS_Date) + ' ' + TimeToStr(fNow) + ' - ' + objOcoCrm.strCodOpe + ' - ' + fRetNomeOperador(objOcoCrm.strCodOpe);

        objOcoCrm.pInsereHistoricoOcorrencia;
        objOcoCrm.pAtualizaOcorrencia;
      End
      Else
      Begin
        pMensagemOk('Código da ocorrência não encontrado');
        blnResult := False;
      End;

    except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmPnlDadosCancelamentoDocumentos.btnCancelamentoNaoAutorizadoClick]');
        blnResult := False;
      End;

     end;

  finally
    FreeAndNil(objOcoCrm);
    SetForegroundWindow(application.handle);
    FreeAndNil(qryAux001);
    If blnCommit And blnResult Then
    Begin
      fCommit;
      pMensagemOk('Ocorrência finalizada com sucesso.');
    End
    Else If Not blnResult Then
    Begin
      fRollBack;
    End;
    cdsConsulta.Close;
    cdsConsulta.Open;
  end;
end;

constructor TfrmPnlDadosCancelamentoDocumentos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TfrmPnlDadosCancelamentoDocumentos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_F10: btnCancelamentoNaoAutorizado.Click;
  End;

  Case Key Of
    VK_F10: Key := 0;
  End;

//  If key = VK_RETURN Then
//  Begin
//    If fVariosDocumentosSelecionados Then
//    Begin
//      self.tag := 1;
//      blnconfirma := False;
//      key := 0;
//    End;
//  End;

end;

end.
