{************************}
{* qryGenEmp -> CADEMP  *}
{* qryGenFor -> CADFOR  *}
{*********************JB*}
unit untQckPedidoCompra;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, RLFilters, RLDraftFilter, RLReport, RLPreviewForm,
  RLParser, Uni;

type
  TfrmQckPedidoCompra = class(TForm)
    rldFiltro: TRLDraftFilter;
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
    rllPonto: TRLLabel;
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
    rllPonto2: TRLLabel;
    rlbSumario4: TRLBand;
    rllLocalEntrega: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    rlbSumario5: TRLBand;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    rlbSumario6: TRLBand;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    rllObs1Sum: TRLLabel;
    rllObs2Sum: TRLLabel;
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
    RLLabel15: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    rllTotSub: TRLLabel;
    rllValTotSub: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    rllPedVen: TRLLabel;
    rllEmailFor: TRLLabel;
    rllLitragem: TRLLabel;
    qckPagina1: TRLReport;
    rlbCabecalhoRes: TRLBand;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    rlbTituloRes: TRLBand;
    rllOrdem1: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLBand3: TRLBand;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel42: TRLLabel;
    rlbDetalheRes: TRLBand;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    rlbSumarioRes: TRLBand;
    RLLabel38: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel31: TRLLabel;
    RLDBText12: TRLDBText;
    rleExpre1: TRLExpressionParser;
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
    procedure RLLabel7BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel8BeforePrint(Sender: TObject; var Text: String;
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
    procedure rllLocalEntregaBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel5BeforePrint(Sender: TObject; var Text: String;
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
    procedure rllImpressaoBeforePrint(Sender: TObject; var Text: String;
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
    procedure RLLabel21BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllPedVenBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllEmailForBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllLitragemBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllOrdem1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel40BeforePrint(Sender: TObject; var Text: String;
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
    strPedVen    : String;
    strTipFre    : String;
    strNumCtn    : String;
    blnPedImp    : Boolean;
    curTotItems  : Currency;
    curTotIpi    : Currency;
    curTotSub    : Currency;
    curLitrag    : Currency;
    strEmpDes    : String;
  end;

var
  frmQckPedidoCompra: TfrmQckPedidoCompra;

implementation

uses untModuloSPR,  untGerencImpr, untFuncoes, untfuncoesSimples, DB;

{$R *.dfm}

procedure TfrmQckPedidoCompra.rllNomEmpBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := #27 + 'P' + #18 + #27 + 'W' + #1 + qryGenEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmQckPedidoCompra.rllCidadeBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := #27 + 'M' + #15 + 'Cidade..: ' + fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString) + ' - ' +
                                         fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString, 1);
end;

procedure TfrmQckPedidoCompra.rllPontoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := #27 + 'W' + #0 + '.';
end;

procedure TfrmQckPedidoCompra.rllCnpjBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '   CNPJ....: ' + qryGenEmp.FieldByName('EMP_C_G_C_').AsString;;
end;

procedure TfrmQckPedidoCompra.rllCodForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := #27 + 'W' + #1 + 'FORNECEDOR: ' + strCodFor;
end;

procedure TfrmQckPedidoCompra.rllNomeForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := ' NOME: ' + qryGenFor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmQckPedidoCompra.RLLabel1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := #27 + 'M' + #15 + strObs001;
end;

procedure TfrmQckPedidoCompra.RLLabel12BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := #27 + 'W' + #1 + 'COMPRADOR: ' + strComprador;
end;

procedure TfrmQckPedidoCompra.RLLabel2BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '    ' + strObs002;
end;

procedure TfrmQckPedidoCompra.RLLabel3BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '    ' + strObs003;
end;

procedure TfrmQckPedidoCompra.RLLabel7BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '    ' + strObs002;
end;

procedure TfrmQckPedidoCompra.RLLabel8BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '    ' + strObs003;
end;

procedure TfrmQckPedidoCompra.RLLabel10BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '    ' + strObs004;
end;

procedure TfrmQckPedidoCompra.RLLabel11BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '    ' + strObs005;
end;

procedure TfrmQckPedidoCompra.rlbHeader1BeforePrint(Sender: TObject;
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

    rllObs1Sum.Visible := False;
    rllObs2Sum.Visible := False;
  End
  Else
  Begin
    rlbSumario4.Visible := True;
    rlbSumario5.Visible := False;
  End;

  If qckPagina.PageNumber > 1 Then
  Begin

    If intTotRec > 47 Then
    Begin
      intTotRec := intTotRec - 47;

      If intTotRec > 22 Then
      Begin
        qckPagina.MinBands := 47;
        qckPagina.MaxBands := 47;
        rlbFooter1.Visible := True;
      End
      Else
      Begin
        qckPagina.MinBands := 22;
        qckPagina.MaxBands := 22;
        rlbFooter1.Visible := False;
      End;

    End
    Else //If intTotRec > 22 Then
    Begin

      rlbSumario1.Height := 390;

      rllTotItems.Top        := 320;
      rllValTotItems.Top     := rllTotItems.Top;

      rllTotIpi.Top         := rllTotItems.Top + 12;
      rllValTotIpi.Top      := rllTotItems.Top + 12;

      rllTotSub.Top        := rllTotIpi.Top + 14;
      rllValTotSub.Top     := rllTotIpi.Top + 14;

      rllTotPed.Top        := rllTotSub.Top + 12;
      rllValTotPed.Top     := rllTotSub.Top + 12;

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

procedure TfrmQckPedidoCompra.FormDestroy(Sender: TObject);
begin
  qryGenEmp.Close;
  qryGenFor.Close;
end;

procedure TfrmQckPedidoCompra.rllEnderecoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '   Endereco: ' + qryGenEmp.FieldByName('EMP_ENDERE').AsString + ' ' + qryGenEmp.FieldByName('EMP_ENDNUM').AsString;
end;

procedure TfrmQckPedidoCompra.rllBairroBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '   Bairro..: ' + qryGenEmp.FieldByName('EMP_BAIRRO').AsString;
end;

procedure TfrmQckPedidoCompra.rllCepBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '   Cep.....: ' + qryGenEmp.FieldByName('EMP_C_E_P_').AsString;
end;

procedure TfrmQckPedidoCompra.rllInscEstBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '   Insc.Est: ' + qryGenEmp.FieldByName('EMP_I_E_S_').AsString;
end;

procedure TfrmQckPedidoCompra.rllFoneBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '   Fone....: ' + qryGenEmp.FieldByName('EMP_FONE01').AsString;
end;

procedure TfrmQckPedidoCompra.rllFaxBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '   Fax.....: ' + qryGenEmp.FieldByName('EMP_F_A_X_').AsString;
end;

procedure TfrmQckPedidoCompra.rllOrdemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If strEspDoc = 'OR' Then
    Text := 'O R C A M E N T O    -    PEDIDO No. ' + strNumPedido + strNumCtn + IIF(blnPedImp, ' - IMPORTACAO', '')
  Else
    Text := 'O R D E M  DE  C O M P R A    -    PEDIDO No. ' + strNumPedido + strNumCtn + IIF(blnPedImp, ' - IMPORTACAO', '');
end;

procedure TfrmQckPedidoCompra.rllDtaEntBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'DATA DA ENTREGA: ' + strDtaEntrega;
end;

procedure TfrmQckPedidoCompra.rllCondPagBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'COND. DE PAG.: ' + Copy(strCndPag,5,Length(strCndPag)) + ' D.D.L.';
end;

procedure TfrmQckPedidoCompra.rlbSumario3BeforePrint(Sender: TObject;
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

procedure TfrmQckPedidoCompra.rllAtencaoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'ATENCAO: ' + strAtencao;
end;

procedure TfrmQckPedidoCompra.rllCidadeForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Cidade..: ' + fRetNomCidade(qryGenFor.FieldByName('FOR_CODCID').AsString) + ' - ' +
                       fRetNomCidade(qryGenFor.FieldByName('FOR_CODCID').AsString, 1);
end;

procedure TfrmQckPedidoCompra.rllEnderecoForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Endereco: ' + qryGenFor.FieldByName('FOR_ENDERE').AsString;
end;

procedure TfrmQckPedidoCompra.rllBairroForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Bairro..: ' + qryGenFor.FieldByName('FOR_BAIRRO').AsString;
end;

procedure TfrmQckPedidoCompra.rllCepForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Cep.....: ' + qryGenFor.FieldByName('FOR_C_E_P_').AsString;
end;

procedure TfrmQckPedidoCompra.rllCnpjForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'CNPJ....: ' + qryGenFor.FieldByName('FOR_C_G_C_').AsString;
end;

procedure TfrmQckPedidoCompra.rllInscEstForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Insc.Est: ' + qryGenFor.FieldByName('FOR_I_E_S_').AsString;
end;

procedure TfrmQckPedidoCompra.rllFoneForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Fone....: ' + qryGenFor.FieldByName('FOR_FONE01').AsString;
end;

procedure TfrmQckPedidoCompra.rllFaxForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Fax.....: ' + qryGenFor.FieldByName('FOR_F_A_X_').AsString;
end;

procedure TfrmQckPedidoCompra.RLLabel13BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := fRetDataExtenso(VS_Date,True);
end;

procedure TfrmQckPedidoCompra.RLDBText6BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
//  Text := fRetUnidadeItem(Text);
end;

procedure TfrmQckPedidoCompra.rllLocalEntregaBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := #27 + 'P' + #18 + #27 + 'W' + #1 + 'LOCAL DE ENTREGA';
end;

procedure TfrmQckPedidoCompra.RLLabel5BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := #27 + 'P' + #18 + #27 + 'W' + #1 + 'OBSERVACOES';
end;

procedure TfrmQckPedidoCompra.RLDBText3BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  If blnSemPre And (Not fEmptyStr(rdbCodIte.Caption)) Then
    Text := '________'

//  Else If Not blnSemPre Then
//    curTotItems := curTotItems + frmModuloSPR.qryRelatorio.FieldByName('VALITE').AsCurrency;

end;

procedure TfrmQckPedidoCompra.RLDBText1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  If blnSemPre And (Not fEmptyStr(rdbCodIte.Caption)) Then
    Text := '________'

//  Else If Not blnSemPre Then
//    curTotIpi := curTotIpi + frmModuloSPR.qryRelatorio.FieldByName('VALIPI').AsCurrency;
end;

procedure TfrmQckPedidoCompra.rllValTotItemsBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := FloatToStrF(curTotItems,ffNumber,15,2);
end;

procedure TfrmQckPedidoCompra.rllValTotIpiBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := FloatToStrF(curTotIpi,ffNumber,15,2);
end;

procedure TfrmQckPedidoCompra.rllValTotPedBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := FloatToStrF(curTotItems + curTotIpi + curTotSub,ffNumber,15,2);
end;

procedure TfrmQckPedidoCompra.rllImpressaoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  {If qckPagina.PageNumber = intLastPage Then
    Text := ''
  Else}
  Text := #27 + 'W' + #1 + 'IMPRESSAO CONTINUA NA PROXIMA PAGINA';
end;

procedure TfrmQckPedidoCompra.qckPaginaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin

  If intTotRec > 22 Then
  Begin
    qckPagina.MinBands := 47;
    qckPagina.MaxBands := 47;
    rlbFooter1.Visible := True;
  End
  Else
  Begin
    qckPagina.MinBands := 22;
    qckPagina.MaxBands := 22;
    rlbFooter1.Visible := False;
  End;

end;

procedure TfrmQckPedidoCompra.FormCreate(Sender: TObject);
begin
  qryGenEmp := fCriaQuery(Self);
  qryGenFor := fCriaQuery(Self);

  blnSemPre := False;
end;

procedure TfrmQckPedidoCompra.RLDBText4BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If blnSemPre And (Not fEmptyStr(rdbCodIte.Caption)) Then
    Text := '________';
end;

procedure TfrmQckPedidoCompra.RLDBText2BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If blnSemPre And (Not fEmptyStr(rdbCodIte.Caption)) Then
    Text := '____';
end;

procedure TfrmQckPedidoCompra.rllValTotSubBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := FloatToStrF(curTotSub,ffNumber,15,2);
end;

procedure TfrmQckPedidoCompra.RLLabel18BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If (Not fEmptyStr(strObsPd1)) Or (Not fEmptyStr(strObsPd2)) Or (Not fEmptyStr(strObsPd3)) Then
    Text := '    Observacoes: '
  Else
    Text := '';

  Text := Text + strObsPd1;
end;

procedure TfrmQckPedidoCompra.RLLabel19BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '                 ' + strObsPd2;
end;

procedure TfrmQckPedidoCompra.RLLabel20BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '                 ' + strObsPd3;
end;

procedure TfrmQckPedidoCompra.RLLabel21BeforePrint(Sender: TObject;
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

procedure TfrmQckPedidoCompra.rllPedVenBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '                 ' + strPedVen;
end;

procedure TfrmQckPedidoCompra.rllEmailForBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'Email...: ' + qryGenFor.FieldByName('FOR_EMAIL_').AsString;
end;

procedure TfrmQckPedidoCompra.rllLitragemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'LITRAGEM: ' +  FloatToStrF(curLitrag,ffNumber,15,2);
end;

procedure TfrmQckPedidoCompra.rllOrdem1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  If strEspDoc = 'OR' Then
    Text := 'O R C A M E N T O    -    PEDIDO No. ' + strNumPedido + strNumCtn + IIF(blnPedImp, ' - IMPORTACAO', '')
  Else
    Text := 'O R D E M  DE  C O M P R A    -    PEDIDO No. ' + strNumPedido + strNumCtn + IIF(blnPedImp, ' - IMPORTACAO', '');
end;

procedure TfrmQckPedidoCompra.RLLabel40BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := FloatToStrF(curLitrag,ffNumber,15,2);
end;

end.

