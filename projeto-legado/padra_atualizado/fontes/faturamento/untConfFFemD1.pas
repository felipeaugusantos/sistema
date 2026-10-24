unit untConfFFemD1;

interface

uses
  Classes,
  Windows,
  untFuncFat,
  untConfDocs,
  untWaitWindow;

type
  TConfirmarFFemD1 = class(Tcomponent)
    private
      FNumFF: String;
      FNumD1: String;
      FDtaD1: TDateTime;

      FCodCli: String;
      FCodVen: String;
      FCodRep: String;
      FOriDoc: String;
      FDtaEFF: TDateTime;

      FDiasD1: Integer;

      FFrmWW: TfrmWaitWindow;

      objConfDocs: TConfirmacaoDocumentos;

      procedure pIniciaWaitWindow;
      procedure pInformacaoWaitWindow(strInfo: String);
      procedure pFinalizaWaitWindow;

      function fValidaDocumentos: Boolean;
      procedure pPreparaParaConfirmar(objVenda: TFatVenda);

    public
      function fPedeDocumentos: Boolean;
      function fConfirmarFFemD1: Boolean;

      Constructor Create(AOwner: TComponent); override;
  end;

implementation

uses SysUtils, Controls, Forms, untDigFFeD1, untFuncoesSimples, untFuncoes;

constructor TConfirmarFFemD1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  objConfDocs := TConfirmacaoDocumentos.Create(Self);
  objConfDocs.pPreparaDocumentoParaConfirmar := pPreparaParaConfirmar;
  objConfDocs.pInformacoes := pInformacaoWaitWindow;

  FDiasD1 := fCfgSis('DIASD1', VarInteger);  
end;

function TConfirmarFFemD1.fPedeDocumentos: Boolean;
  Var
    blnBreak: Boolean;
begin
  inherited;

  blnBreak := False;
  Result   := False;

  While (Not Result) Do
  Begin
    Try
      pCriarFormularios(TfrmDigFFeD1, frmDigFFeD1);

      frmDigFFeD1.edtNumFF.Text := FNumFF;
      frmDigFFeD1.edtNumD1.Text := FNumD1;
      frmDigFFeD1.mskDtaD1.Text := DateToStr(FDtaD1);

      blnBreak := Not (frmDigFFeD1.ShowModal = mrOk);

      FNumFF := frmDigFFeD1.edtNumFF.Text;
      FNumD1 := frmDigFFeD1.edtNumD1.Text;
      FDtaD1 := strToDateDef(frmDigFFeD1.mskDtaD1.Text, VS_DATE);

      Result := (Not blnBreak) And fValidaDocumentos;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TConfirmarFFemD1.fPedeNumeroDaFFeD1]');
      End;
    End;

    pFreeAndNil(frmDigFFeD1);

    If blnBreak Then
      Break;
  End;

end;

function TConfirmarFFemD1.fConfirmarFFemD1: Boolean;
  Var
    strMsg: String;
begin
  Try
    Screen.Cursor := crHourGlass;

    pIniciaWaitWindow;

    Result := False;
    objConfDocs.strNumDoc := FNumFF;
    objConfDocs.strEspDoc := 'FF';
    objConfDocs.blnFiltrarEmp := True;//Somente da propria loja

    pInformacaoWaitWindow('Aguarde... Carregando documento(s) para confirmação!');

    objConfDocs.pCriaTemporariaConfirmacao;

    If Not objConfDocs.blnSemDocumentosParaConfirmar Then
    Begin
      Result := objConfDocs.fMarcaDocumento(True, strMsg) And
                objConfDocs.fCarregaItensConfirmacaoDocumentos And
                objConfDocs.fConfirmarDocumentos;

      If Result Then
      Begin
        pInformacaoWaitWindow('Confirmação concluída com sucesso!');

        fMensagem('ATENÇÃO!', 'Confirmação da FF (' + FNumFF + ') ' +
                              'concluida com sucesso!', ['&Ok']);
      End;
    End
    Else
      fMensagem('ATENÇÃO!', 'Não há FF para confirmar com este número!', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[]');
    End;
  End;

  pFinalizaWaitWindow;  

  Screen.Cursor := crDefault;
end;

function TConfirmarFFemD1.fValidaDocumentos: Boolean;
begin
  Result := True;

  If (fVerificaVendaExiste(FNumD1, 'D1', VS_strCodEmp, FCodCli, FCodVen, FCodRep, FOriDoc, FDtaEFF)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Documento ' + FNumD1 + '-D1 já foi emitido!', ['&Ok']);
    Result := False;
  End;

  If FDtaD1 > VS_Date Then
  Begin
    fMensagem('ATENÇÃO!', 'A data de emissão do documento D1 não deve ser maior que a data atual!', ['&Ok']);
    Result := False;
  End;

  If FDtaD1 < (VS_Date - FDiasD1) Then
  Begin
    fMensagem('ATENÇÃO!', 'A data de emissão do documento D1 não deve ser inferior à ' +
                          FormatDateTime('dd/mm/yyyy', VS_Date - FDiasD1)+ '.', ['&Ok']);
    Result := False;
  End;

  If (Not fVerificaVendaExiste(FNumFF, 'FF', VS_strCodEmp, FCodCli, FCodVen, FCodRep, FOriDoc, FDtaEFF)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Documento ' + FNumFF + '-FF não foi encontrado no sistema!', ['&Ok']);
    Result := False;
  End
  Else
  Begin
    objConfDocs.strCodCli := FCodCli;

    If FDtaEFF < (VS_Date - FDiasD1) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data de emissão do documento FF não deve ser inferior à ' +
                            FormatDateTime('dd/mm/yyyy', VS_Date - FDiasD1) + '.', ['&Ok']);
      Result := False;
    End;
  End;

end;

procedure TConfirmarFFemD1.pFinalizaWaitWindow;
begin
  If Assigned(FFrmWW) Then
  Begin
    FFrmWW.Close;
    pFreeAndNil(FFrmWW);
  End;
end;

procedure TConfirmarFFemD1.pInformacaoWaitWindow(strInfo: String);
begin
  If Assigned(FFrmWW) Then
  Begin
    FFrmWW.lblTexto.Caption := strInfo;
    FFrmWW.Refresh;
  End;
end;

procedure TConfirmarFFemD1.pIniciaWaitWindow;
begin
  pCriarFormularios(TfrmWaitWindow, FFrmWW);

  FFrmWW.lblTexto.Caption := 'Aguarde...';
  FFrmWW.tmrWait.Enabled := False;

  AnimateWindow(FFrmWW.Handle, 200, AW_BLEND);

  FFrmWW.Show;
  FFrmWW.Refresh;
end;

procedure TConfirmarFFemD1.pPreparaParaConfirmar(objVenda: TFatVenda);
begin
  objVenda.VS_Date   := FDtaD1;
  objVenda.strNumDoc := FNumD1;
  objVenda.strEspDoc := 'D1';
  objVenda.blnCupEsp := True; //Sempre como nota especial pois nao deve gravar financeiro
  objVenda.blnNovoSequencial := False; //Nao deve pegar sequencial pois é o proprio numero do D1
  objVenda.blnImprimeDocs := False; //Nao deve imprimir nenhum documento
end;

end.
