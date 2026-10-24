{************************}
{* qryGenEmp -> CADEMP  *}
{* qryGenFor -> CADFOR  *}
{*********************JB*}
unit untQckPedidoCompraJato;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, RLFilters, RLDraftFilter, RLReport, RLPreviewForm,
  RLParser, Uni;

type
  TfrmQckPedidoCompraJato = class(TForm)
    qckPagina: TRLReport;
    rlbHeader1: TRLBand;
    rllNomEmp: TRLLabel;
    rllCidade: TRLLabel;
    rllEndereco: TRLLabel;
    rllBairro: TRLLabel;
    rllCep: TRLLabel;
    rllCnpj: TRLLabel;
    rllInscEst: TRLLabel;
    rllFone: TRLLabel;
    rllFax: TRLLabel;
    rlbHeader2: TRLBand;
    rllDepartamento: TRLLabel;
    rllOrdem: TRLLabel;
    rlbHeader3: TRLBand;
    rllCodigo: TRLLabel;
    rllDescri: TRLLabel;
    rllUnidade: TRLLabel;
    rllQtd: TRLLabel;
    rllValUnit: TRLLabel;
    rllValTot: TRLLabel;
    rllPorcIpi: TRLLabel;
    rllValIpi: TRLLabel;
    rleExpre: TRLExpressionParser;
    rlbSumario1: TRLBand;
    rllValTotItems: TRLLabel;
    rllTotItems: TRLLabel;
    rllTotIpi: TRLLabel;
    rllTotPed: TRLLabel;
    rllValTotIpi: TRLLabel;
    rllValTotPed: TRLLabel;
    rlbSumario2: TRLBand;
    rllDtaEnt: TRLLabel;
    rllCondPag: TRLLabel;
    rlbSumario3: TRLBand;
    rllCodFor: TRLLabel;
    rllNomeFor: TRLLabel;
    rllAtencao: TRLLabel;
    rllCidadeFor: TRLLabel;
    rllEnderecoFor: TRLLabel;
    rllBairroFor: TRLLabel;
    rllCepFor: TRLLabel;
    rllCnpjFor: TRLLabel;
    rllInscEstFor: TRLLabel;
    rllFoneFor: TRLLabel;
    rllFaxFor: TRLLabel;
    rlbSumario4: TRLBand;
    rllLocalEntrega: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    rlbSumario5: TRLBand;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    rlbSumario6: TRLBand;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    rllObs1Sum6: TRLLabel;
    rllObs2Sum6: TRLLabel;
    rlbFooter1: TRLBand;
    rllImpressao: TRLLabel;
    rlbDetail: TRLBand;
    rdbCodIte: TRLDBText;
    rdbDesIte: TRLDBText;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel15: TRLLabel;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLLabel4: TRLLabel;
    RLLabel9: TRLLabel;
    rllTotSub: TRLLabel;
    rllValTotSub: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel22: TRLLabel;
    rllLitragem: TRLLabel;
    qckPagina1: TRLReport;
    rleExpre1: TRLExpressionParser;
    RLBand1: TRLBand;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLBand2: TRLBand;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLBand3: TRLBand;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel39: TRLLabel;
    RLBand4: TRLBand;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText14: TRLDBText;
    RLBand5: TRLBand;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    RLLabel47: TRLLabel;
    procedure rllNomEmpBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllCidadeBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllPontoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllCnpjBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllCodForBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllNomeForBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel12BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel2BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel3BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel10BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel11BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbHeader1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure rllEnderecoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllBairroBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllCepBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllInscEstBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllFoneBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllFaxBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllOrdemBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllDtaEntBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllCondPagBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbSumario3BeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rllAtencaoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllCidadeForBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllEnderecoForBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllBairroForBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllCepForBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllCnpjForBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllInscEstForBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllFoneForBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllFaxForBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel13BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText6BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText3BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllValTotItemsBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllValTotIpiBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllValTotPedBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure qckPaginaBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RLDBText4BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText2BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllValTotSubBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel18BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel19BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel20BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel16BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel21BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel17BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel22BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllLitragemBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel45BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
  private
    { Private declarations }
    qryGenEmp: TUniQuery;
    qryGenFor: TUniQuery;
    
  public
    { Public declarations }
    intTotRec    : Integer;
    blnSemPre    : Boolean;
    blnImpRes    : Boolean;
    strEspDoc    : String;
    strNumPedido : String;
    strDtaEntrega: String;
    strCndPag    : String;
    strComprador : String;
    strCodFor    : String;
    strAtencao   : String;
    strObs001    : String;
    strObs002    : String;
    strObs003    : String;
    strObs004    : String;
    strObs005    : String;
    strObsPd1    : String;
    strObsPd2    : String;
    strObsPd3    : String;
    strTipFre    : String;
    strPedVen    : String;
    strNumCtn    : String;
    blnPedImp    : Boolean;
    curTotItems  : Currency;
    curTotIpi    : Currency;
    curTotSub    : Currency;
    curLitrag    : Currency;
    strEmpDes    : String;        
  end;

var
  frmQckPedidoCompraJato: TfrmQckPedidoCompraJato;

implementation

uses untModuloSPR,  untGerencImpr, untFuncoes, untfuncoesSimples, DB;

{$R *.dfm}

procedure TfrmQckPedidoCompraJato.rllNomEmpBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := qryGenEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllCidadeBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Cidade: ' + fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString) + ' - ' +
                       fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString,1);
end;

procedure TfrmQckPedidoCompraJato.rllPontoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := #27 + 'W' + #0 + '.';
end;

procedure TfrmQckPedidoCompraJato.rllCnpjBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'CNPJ: ' + qryGenEmp.FieldByName('EMP_C_G_C_').AsString;;
end;

procedure TfrmQckPedidoCompraJato.rllCodForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'FORNECEDOR: ' + strCodFor;
end;

procedure TfrmQckPedidoCompraJato.rllNomeForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'NOME: ' + qryGenFor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmQckPedidoCompraJato.RLLabel1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := strObs001;
end;

procedure TfrmQckPedidoCompraJato.RLLabel12BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'COMPRADOR: ' + strComprador;
end;

procedure TfrmQckPedidoCompraJato.RLLabel2BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := strObs002;
end;

procedure TfrmQckPedidoCompraJato.RLLabel3BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := strObs003;
end;

procedure TfrmQckPedidoCompraJato.RLLabel10BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := strObs004;
end;

procedure TfrmQckPedidoCompraJato.RLLabel11BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := strObs005;
end;

procedure TfrmQckPedidoCompraJato.rlbHeader1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

  With qryGenEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    
    If fEmptyStr(strEmpDes) Then
      ParamByName('CODEMP').AsString := VS_strCodEmp
    Else
      ParamByName('CODEMP').AsString := strEmpDes;

    Open;
  End;

  If strEspDoc = 'OR' Then
  Begin
    rlbSumario4.Visible := False;
    rlbSumario5.Visible := True;

    rllObs1Sum6.Visible := False;
    rllObs2Sum6.Visible := False;
  End
  Else
  Begin
    rlbSumario4.Visible := True;
    rlbSumario5.Visible := False;
  End;

  If qckPagina.PageNumber > 1 Then
  Begin

    If intTotRec > 46 Then
    Begin
      intTotRec := intTotRec - 46;

      If intTotRec > 19 Then
      Begin
        qckPagina.MinBands := 44; {47}
        rlbFooter1.Visible := True;
      End
      Else
      Begin
        qckPagina.MinBands := 19; {22}
        rlbFooter1.Visible := False;
      End;

    End
    Else //If intTotRec > 22 Then
    Begin

      rlbSumario1.Height := 390;

      rllTotItems.Top    := 340;
      rllValTotItems.Top := rllTotItems.Top;

      rllTotIpi.Top      := rllTotItems.Top + 12;
      rllValTotIpi.Top   := rllTotItems.Top + 12;

      rllTotSub.Top      := rllTotIpi.Top + 12;
      rllValTotSub.Top   := rllTotIpi.Top + 12;

      rllTotPed.Top      := rllTotSub.Top + 12;
      rllValTotPed.Top   := rllTotSub.Top + 12;

      rlbFooter1.Visible := False;
    End;

  End;

  If blnSemPre Then
  Begin
    rllTotItems.Visible    := False;
    rllValTotItems.Visible := False;
    rllTotIpi.Visible      := False;
    rllTotSub.Visible      := False;
    rllValTotIpi.Visible   := False;
    rllValTotSub.Visible   := False;
    rllTotPed.Visible      := False;
    rllValTotPed.Visible   := False;
  End;
  
end;

procedure TfrmQckPedidoCompraJato.FormDestroy(Sender: TObject);
begin
  qryGenEmp.Close;
  qryGenFor.Close;
end;

procedure TfrmQckPedidoCompraJato.rllEnderecoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Endereco: ' + qryGenEmp.FieldByName('EMP_ENDERE').AsString + ' ' + qryGenEmp.FieldByName('EMP_ENDNUM').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllBairroBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Bairro: ' + qryGenEmp.FieldByName('EMP_BAIRRO').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllCepBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Cep: ' + qryGenEmp.FieldByName('EMP_C_E_P_').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllInscEstBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Insc.Est: ' + qryGenEmp.FieldByName('EMP_I_E_S_').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllFoneBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Fone: ' + qryGenEmp.FieldByName('EMP_FONE01').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllFaxBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Fax: ' + qryGenEmp.FieldByName('EMP_F_A_X_').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllOrdemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If strEspDoc = 'OR' Then
    Text := 'O R C A M E N T O    -    PEDIDO No. ' + strNumPedido + strNumCtn + IIF(blnPedImp, ' - IMPORTACAO', '')
  Else
    Text := 'O R D E M  DE  C O M P R A    -    PEDIDO No. ' + strNumPedido + strNumCtn + IIF(blnPedImp, ' - IMPORTACAO', '');
end;

procedure TfrmQckPedidoCompraJato.rllDtaEntBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'DATA DA ENTREGA: ' + strDtaEntrega;
end;

procedure TfrmQckPedidoCompraJato.rllCondPagBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'COND. DE PAG.: ' + Copy(strCndPag,5,Length(strCndPag)) + ' D.D.L.';
end;

procedure TfrmQckPedidoCompraJato.rlbSumario3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FOR_CODFOR = :CODFOR ';

  With qryGenFor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFOR').AsString := strCodFor;
    Open;
  End;
end;

procedure TfrmQckPedidoCompraJato.rllAtencaoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'ATENCAO: ' + strAtencao;
end;

procedure TfrmQckPedidoCompraJato.rllCidadeForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Cidade: ' + fRetNomCidade(qryGenFor.FieldByName('FOR_CODCID').AsString) + ' - ' +
                       fRetNomCidade(qryGenFor.FieldByName('FOR_CODCID').AsString, 1);
end;

procedure TfrmQckPedidoCompraJato.rllEnderecoForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Endereco: ' + qryGenFor.FieldByName('FOR_ENDERE').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllBairroForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Bairro: ' + qryGenFor.FieldByName('FOR_BAIRRO').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllCepForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Cep: ' + qryGenFor.FieldByName('FOR_C_E_P_').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllCnpjForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'CNPJ: ' + qryGenFor.FieldByName('FOR_C_G_C_').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllInscEstForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Insc.Est: ' + qryGenFor.FieldByName('FOR_I_E_S_').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllFoneForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Fone: ' + qryGenFor.FieldByName('FOR_FONE01').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllFaxForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Fax: ' + qryGenFor.FieldByName('FOR_F_A_X_').AsString;
end;

procedure TfrmQckPedidoCompraJato.RLLabel13BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := fRetDataExtenso(VS_Date,True);
end;

procedure TfrmQckPedidoCompraJato.RLDBText6BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  Text := fRetUnidadeItem(Text);
end;

procedure TfrmQckPedidoCompraJato.RLDBText3BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  If blnSemPre And (Not fEmptyStr(rdbCodIte.Caption)) Then
    Text := '________'

//  Else If Not blnSemPre Then
//    curTotItems := curTotItems + frmModuloSPR.qryRelatorio.FieldByName('VALITE').AsCurrency;

end;

procedure TfrmQckPedidoCompraJato.RLDBText1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If blnSemPre And (Not fEmptyStr(rdbCodIte.Caption)) Then
    Text := '________'

//  Else If Not blnSemPre Then
//    curTotIpi := curTotIpi + frmModuloSPR.qryRelatorio.FieldByName('VALIPI').AsCurrency;
end;

procedure TfrmQckPedidoCompraJato.rllValTotItemsBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := FloatToStrF(curTotItems,ffNumber,15,2);
end;

procedure TfrmQckPedidoCompraJato.rllValTotIpiBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := FloatToStrF(curTotIpi,ffNumber,15,2);
end;

procedure TfrmQckPedidoCompraJato.rllValTotPedBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := FloatToStrF(curTotItems + curTotIpi + curTotSub,ffNumber,15,2);
end;

procedure TfrmQckPedidoCompraJato.qckPaginaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin

  If intTotRec > 19 Then
  Begin
    qckPagina.MinBands := 44;
    rlbFooter1.Visible := True;
  End
  Else
  Begin
    qckPagina.MinBands := 19;
    rlbFooter1.Visible := False;
  End;

end;

procedure TfrmQckPedidoCompraJato.FormCreate(Sender: TObject);
begin
  qryGenEmp := fCriaQuery(Self);
  qryGenFor := fCriaQuery(Self);

  blnSemPre := False;
end;

procedure TfrmQckPedidoCompraJato.RLDBText4BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If blnSemPre And (Not fEmptyStr(rdbCodIte.Caption)) Then
    Text := '________';
end;

procedure TfrmQckPedidoCompraJato.RLDBText2BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If blnSemPre And (Not fEmptyStr(rdbCodIte.Caption)) Then
    Text := '____';
end;

procedure TfrmQckPedidoCompraJato.rllValTotSubBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := FloatToStrF(curTotSub,ffNumber,15,2);
end;

procedure TfrmQckPedidoCompraJato.RLLabel18BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := strObsPd1;
end;

procedure TfrmQckPedidoCompraJato.RLLabel19BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := strObsPd2;
end;

procedure TfrmQckPedidoCompraJato.RLLabel20BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := strObsPd3;
end;

procedure TfrmQckPedidoCompraJato.RLLabel16BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  If (Not fEmptyStr(strObsPd1)) Or (Not fEmptyStr(strObsPd2)) Or (Not fEmptyStr(strObsPd3)) Then
    Text := 'Observacoes: '
  Else
    Text := '';

end;

procedure TfrmQckPedidoCompraJato.RLLabel21BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  If Not fEmptyStr(strTipFre) Then
  Begin
    If strTipFre = '1' Then
      Text := 'TIPO DE FRETE: CIF '
    Else
      Text := 'TIPO DE FRETE: FOB ';
  End
  Else
    Text := '';

end;

procedure TfrmQckPedidoCompraJato.RLLabel17BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := strPedVen;
end;

procedure TfrmQckPedidoCompraJato.RLLabel22BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Email: ' + qryGenFor.FieldByName('FOR_EMAIL_').AsString;
end;

procedure TfrmQckPedidoCompraJato.rllLitragemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'LITRAGEM: ' +  FloatToStrF(curLitrag,ffNumber,15,2);
end;

procedure TfrmQckPedidoCompraJato.RLLabel45BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := FloatToStrF(curLitrag,ffNumber,15,2);
end;

end.

