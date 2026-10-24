unit Produto.GS1CNP.Inconsistencia.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxClasses, cxGridLevel, cxGrid, cxCheckBox, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFuncoesGenerica,
  System.UITypes, Produto.GS1CNP.Shared.Types;

type

  TProdutoGS1CNPInconsistenciaView = class(TfrmPaiConfirma)
    grdDadosConsulta: TcxGrid;
    grdDadosConsultaTableView: TcxGridTableView;
    grdDadosConsultaTableViewCodigo: TcxGridColumn;
    grdDadosConsultaTableViewMensagem: TcxGridColumn;
    grdDadosConsultaTableViewCampoArquivo: TcxGridColumn;
    grdDadosConsultaLevel: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FConfirma: Boolean;
    FValidations: TArrayValidations;

    procedure pExecRetornoCadastroGS1CNP();
    procedure pAddInfo(const ACodigo, AMensagem, ACampo: String);
    function GetFields(const AFields: TArrayFields): String;
  public
    property blnConfirma: Boolean read FConfirma;
    property Validations: TArrayValidations write FValidations;
  end;

var
  ProdutoGS1CNPInconsistenciaView: TProdutoGS1CNPInconsistenciaView;

implementation

{$R *.dfm}

uses untGravando, Produto.GS1CNP.Interfaces.Consulta, Produto.GS1CNP.Interfaces.Service,
  Produto.GS1CNP.Service.Consulta, Produto.GS1CNP.Shared.Exception;

{ TProdutoGS1CNPInconsistenciaView }

procedure TProdutoGS1CNPInconsistenciaView.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FConfirma := True;
end;

procedure TProdutoGS1CNPInconsistenciaView.FormCreate(Sender: TObject);
begin
  inherited;
  FConfirma          := False;
end;

procedure TProdutoGS1CNPInconsistenciaView.FormShow(Sender: TObject);
begin
  inherited;
  pExecRetornoCadastroGS1CNP;
end;

function TProdutoGS1CNPInconsistenciaView.GetFields(const AFields: TArrayFields): String;
var
  intContador: Integer;
begin
  Result := '';
  for intContador := 0 to Length(AFields) - 1 do
  begin
    if intContador > 0 then
      Result := Result + ',';

    Result := Result + AFields[intContador].field.field;
  end;
end;

procedure TProdutoGS1CNPInconsistenciaView.pAddInfo(const ACodigo, AMensagem, ACampo: String);
var
  intRec: Integer;
begin
  intRec := grdDadosConsultaTableView.DataController.AppendRecord;
  grdDadosConsultaTableView.DataController.Values[intRec, 0] := ACodigo;
  grdDadosConsultaTableView.DataController.Values[intRec, 1] := AMensagem;
  grdDadosConsultaTableView.DataController.Values[intRec, 2] := ACampo;
  grdDadosConsultaTableView.DataController.Post();
end;

procedure TProdutoGS1CNPInconsistenciaView.pExecRetornoCadastroGS1CNP;
var
  LContador: Integer;
begin
  try
    for LContador := 0 to Length(FValidations) - 1 do
    begin
      pAddInfo(FValidations[LContador].code,
               FValidations[LContador].messageValidations,
               GetFields(FValidations[LContador].fields));
    end;
  except
    on e: ErroConsultaView do
    begin
      fMensagem('Erro', e.Message, ['&Ok']);
      blnFecharFormPai := True;
    end;
  end;
end;

end.
