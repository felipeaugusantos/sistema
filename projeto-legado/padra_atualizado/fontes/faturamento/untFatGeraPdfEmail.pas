unit untFatGeraPdfEmail;

interface

uses Windows, Classes, StrUtils, SysUtils, Controls, Uni, UniClientDataSet, UniDataSetProvider, DB,
     EditFocus, Forms, Variants, StdCtrls, untReimpressao, untFuncoesSimples, untFuncoes;

Type
  TPdfEma = Class(TComponent)

  private
    opcEdtFst   : TOpcEditorFast;
    opcPedVen   : TOpcaoPedido;
    blnVeiF10   : Boolean;
    blnSoCons   : Boolean;
    blnVisual   : Boolean;
    opcEdtFstImp: TOpcEditorFast;
    strNumDoc   : String;
    strEspDoc   : String;
    strCodEmp   : String;
    strDocCan   : String;
    strPasPdf   : String;
    reiReimpr   : TReimpressao;
    procedure setEdtFstImp(const Value: TOpcEditorFast);
  public
    blnQtdOri   : Boolean;
    function  getEdtFst   : TOpcEditorFast;
    procedure setEdtFst(const Value: TOpcEditorFast);
    function  getEdtFstImp: TOpcEditorFast;
    function  getPedVen   : TOpcaoPedido;
    function  getVeiF10   : Boolean;
    function  getSoCons   : Boolean;
    function  getVisual   : Boolean;
    function  getNumDoc   : String;
    function  getEspDoc   : String;
    function  getCodEmp   : String;
    function  getDocCan   : String;
    function  getPasPdf   : String;

    procedure setPedVen(const Value: TOpcaoPedido);
    procedure setVeiF10(const Value: Boolean);
    procedure setSoCons(const Value: Boolean);
    procedure setVisual(const Value: Boolean);
    procedure setNumDoc(const Value: String);
    procedure setEspDoc(const Value: String);
    procedure setCodEmp(const Value: String);
    procedure setReimpr(const Value: TReimpressao);
    procedure setDocCan(const Value: String);
    procedure setPasPdf(const Value: String);

    Function fReimprimeDocumento: Boolean;

    Constructor Create(Owner: TComponent); override;
    Destructor  Destroy; override;
End;

implementation

{ TPdfEma }

constructor TPdfEma.Create(Owner: TComponent);
begin
  inherited create(Owner);

  setVeiF10(False);
  setSoCons(False);
  setVisual(False);
  setNumDoc('');
  setEspDoc('');
  setCodEmp('');
  setDocCan('');
  setPasPdf('Docs_Env_Reimp');
  setPedVen(oppPergunta);
  setReimpr(Nil);

  {Default, sempre = "True", para que em casos de reimpressão de documentos, seja impressa
   a quantidade original. Pois no caso de (Reimpressão de OR "Orçamento") não é questionado
   o tipo de quantidade.}
  blnQtdOri := True;
end;

destructor TPdfEma.Destroy;
begin

  inherited Destroy;
end;

function TPdfEma.fReimprimeDocumento: Boolean;
Var
  blnGerPdf: Boolean;

  blnTemServicos    : Boolean;
  blnSomenteServicos: Boolean;
  strExecutavel     : String;
Begin

  Result := false;

  Try
    opcEdtFstImp := opcEdtFst;

    blnTemServicos := fDocumentoPossuiServicos(getNumDoc, getEspDoc, getCodEmp, blnSomenteServicos);

    If SameText(getEspDoc, 'PD') Then
    Begin
      If (getPedVen = oppPergunta) And (Not (blnTemServicos And blnSomenteServicos)) Then
      Begin
        If fMensagem('', 'Selecione o tipo de quantidade?', ['&Original', '&Pendente'], 2) = 1 Then
        Begin
          blnQtdOri := True;
          setPedVen(oppOriginal);
        End Else
        Begin
          blnQtdOri := False;
          setPedVen(oppPendente);
        End;
      End;
    End;

    {*******************************************}
    {* PEGA O ENDEREÇO CORRENTE DO EXECUTÁVEL  *}
    {****************************************PZ*}
    strExecutavel := ExtractFilePath(Application.ExeName);

    {*******************************************}
    {* SE NÃO EXISTIR O DIRETÓRIO ELE CRIA     *}
    {****************************************PZ*}
    If Not DirectoryExists(strExecutavel+getPasPdf) Then
      CreateDir(strExecutavel+getPasPdf);

    Application.ProcessMessages;

    reiReimpr.blnTelaReimpressao := True;
    reiReimpr.pReimprimeDocumento(False,
                                  blnQtdOri,
                                  (getDocCan = 'C'),
                                  True,
                                  SameText(getEspDoc, 'PD'),
                                  getEdtFstImp,
                                  True,
                                  libAmbos,
                                  True,
                                  False,
                                  getPasPdf,
                                  getVisual);

    Result := (reiReimpr.blnImprimiuEditor) Or (reiReimpr.blnImprimiuAmbien);

    {***************************************************}
    {* SE FOR IMPRESSÃO PELO F10 E NÃO TEM LAYOUT PDF, *}
    {* IRÁ TENTAR IMPRIMIR O LAYOUT ATIVO DO DOCUMENTO *}
    {************************************************PZ*}
    If (Not Result) And (getEdtFst = opcEmail) Then
    Begin
      setEdtFstImp(opcVideo);
      blnGerPdf := (Not getVeiF10);

      reiReimpr.pReimprimeDocumento(False,
                                    blnQtdOri,
                                    (getDocCan = 'C'),
                                    True,
                                    SameText(getEspDoc, 'PD'),
                                    getEdtFstImp,
                                    True,
                                    libAmbos,
                                    True,
                                    blnGerPdf,
                                    getPasPdf,
                                    getVisual);

      Result := reiReimpr.blnImprimiuEditor;

      If (Not reiReimpr.blnTemLay) Then
      Begin
        fMensagem('ATENÇÃO', 'Não há Layout Disponível para Impressão!', ['&O k']);
      End Else If (Not reiReimpr.blnImprimiuEditor) Then
      Begin
        pMensagemOK('Não há itens pendentes para impressão!');
      End;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fReimprimeDocumento]');
    End;
  End;

  //pnlInfo.Caption := '';
end;

function TPdfEma.getDocCan: String;
begin
  Result := strDocCan;
end;

function TPdfEma.getPasPdf: String;
begin
  Result := strPasPdf;
end;

function TPdfEma.getEdtFst: TOpcEditorFast;
begin
  Result := opcEdtFst;
end;

function TPdfEma.getEdtFstImp: TOpcEditorFast;
begin
  Result := opcEdtFstImp;
end;

function TPdfEma.getNumDoc: String;
begin
  Result := strNumDoc;
end;

function TPdfEma.getEspDoc: String;
begin
  Result := strEspDoc;
end;

function TPdfEma.getCodEmp: String;
begin
  Result := strCodEmp;
end;

function TPdfEma.getPedVen: TOpcaoPedido;
begin
  Result := opcPedVen;
end;

function TPdfEma.getVeiF10: Boolean;
begin
  Result := blnVeiF10;
end;

function TPdfEma.getSoCons: Boolean;
begin
  Result := blnSoCons;
end;

function TPdfEma.getVisual: Boolean;
begin
  Result := blnVisual;
end;

procedure TPdfEma.setDocCan(const Value: String);
begin
  strDocCan := Value;
end;

procedure TPdfEma.setPasPdf(const Value: String);
begin
  strPasPdf := Value;
end;

procedure TPdfEma.setEdtFst(const Value: TOpcEditorFast);
begin
  opcEdtFst := Value;
end;

procedure TPdfEma.setEdtFstImp(const Value: TOpcEditorFast);
begin
  opcEdtFstImp := Value;
end;

procedure TPdfEma.setNumDoc(const Value: String);
begin
  strNumDoc := Value;
end;

procedure TPdfEma.setEspDoc(const Value: String);
begin
  strEspDoc := Value;
end;

procedure TPdfEma.setCodEmp(const Value: String);
begin
  strCodEmp := Value;
end;

procedure TPdfEma.setPedVen(const Value: TOpcaoPedido);
begin
  opcPedVen := Value;
end;

procedure TPdfEma.setReimpr(const Value: TReimpressao);
begin
  reiReimpr := Value;
end;

procedure TPdfEma.setVeiF10(const Value: Boolean);
begin
  blnVeiF10 := Value;
end;

procedure TPdfEma.setSoCons(const Value: Boolean);
begin
  blnSoCons := Value;
end;

procedure TPdfEma.setVisual(const Value: Boolean);
begin
  blnVisual := Value;
end;

end.
