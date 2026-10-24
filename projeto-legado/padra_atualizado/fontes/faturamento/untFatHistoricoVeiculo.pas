unit untFatHistoricoVeiculo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, Grids, DBGridCitel, DBGrids,
  Uni, DB, frxClass, frxExportCSVTestabilidade, untFatGeraPdfEmail;

type
  TfrmFatHistoricoVeiculo = class(TfrmPai)
    pnlFundo: TPanel;
    Label3: TLabel;
    dbgDocumentos: TDBGridCitel;
    pnlVeiculo: TPanel;
    dtsVeiculo: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FPlaca: String;
    qryVeiculo: TUniQuery;
    procedure pSetPlaca(const Value: String);
  public
    class procedure pExibeHistorico(strPlaca: String);

    property strPlaca: String read FPlaca write pSetPlaca;
  end;

var
  frmFatHistoricoVeiculo: TfrmFatHistoricoVeiculo;

implementation

uses MaskUtils, untFuncoesSimples, untReimpressao, untSQLRepositorio,
  untConstantes;

{$R *.dfm}

procedure TfrmFatHistoricoVeiculo.FormCreate(Sender: TObject);
begin
  inherited;
  
  qryVeiculo := fCriaQuery;
  dtsVeiculo.DataSet := qryVeiculo;

end;

procedure TfrmFatHistoricoVeiculo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryVeiculo);

  inherited;
end;

procedure TfrmFatHistoricoVeiculo.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  Var
    objReimpressao: TReimpressao;
    objPdfEma     : TPdfEma;
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    If qryVeiculo.IsEmpty Then
      Exit;

    objReimpressao := TReimpressao.Create(qryVeiculo.FieldByName('FGO_NUMDOC').AsString,
                                          qryVeiculo.FieldByName('FGO_ESPDOC').AsString,
                                          VS_Date,VS_Date,'','','',True,'C',
                                          False,False,False,'','',True,0,False,'',True);
    Try
      objPdfEma := TPdfEma.Create(Nil);

      objPdfEma.setEdtFst(opcEmail);
      objPdfEma.setNumDoc(qryVeiculo.FieldByName('FGO_NUMDOC').AsString);
      objPdfEma.setEspDoc(qryVeiculo.FieldByName('FGO_ESPDOC').AsString);
      objPdfEma.setCodEmp('');
      objPdfEma.setVeiF10(True);
      objPdfEma.setSoCons(True);
      objPdfEma.setVisual(True);
      objPdfEma.setPasPdf('Docs_Env_Reimp');

      objPdfEma.setReimpr(objReimpressao);
      objPdfEma.fReimprimeDocumento;

    Finally
      FreeAndNil(objReimpressao);
      FreeAndNil(objPdfEma);
    End;
  End

  Else If Key = VK_ESCAPE Then
  Begin
    btnSair.Click;
    Key := 0;
  End;
end;

procedure TfrmFatHistoricoVeiculo.FormShow(Sender: TObject);
begin
  inherited;

  pSQL(qryVeiculo, repFaturamento, 'HISTORICO_VEICULO', [FPlaca]);
  qryVeiculo.Open;

  qryVeiculo.FieldByName('CONPAG').EditMask := MASK_CONPAG5;
  TFloatField(qryVeiculo.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';
end;

class procedure TfrmFatHistoricoVeiculo.pExibeHistorico(strPlaca: String);
begin
  pCriarFormularios(TfrmFatHistoricoVeiculo, frmFatHistoricoVeiculo);
  Try
    frmFatHistoricoVeiculo.strPlaca := strPlaca;
    frmFatHistoricoVeiculo.ShowModal;
  Finally
    pFreeAndNil(frmFatHistoricoVeiculo);
  End;
end;

procedure TfrmFatHistoricoVeiculo.pSetPlaca(const Value: String);
begin
  FPlaca := Value;
  pnlVeiculo.Caption := 'Placa: '+ FormatMaskText('lll-9999;0; ', FPlaca) + ' Veículo: '+ fRetornaDescricaoVeic(FPlaca);
end;

end.
