unit untImendesOpcoesRecriacaoConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, untFuncoesSimples;

type
   TTipoGeracao =  (ttgItensComRetParcial,
                    ttgItensComDivergencia,
                    ttgNaoEncontradoImendes,
                    ttgCodBarrasInvalido,
                    ttgTodos,
                    ttgIndefinido);

  TfrmImendesOpcoesRecriacaoConsulta = class(TfrmPaiConfirma)
    rdgOpcao: TRadioGroup;
    lblArqBas: TLabel;
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  protected
    blnConfirma: Boolean;
  public
    class function fRetImendesOpcoesRecriacaoConsulta(ArquivoBase: String): TTipoGeracao;
    { Public declarations }
  end;

var
  frmImendesOpcoesRecriacaoConsulta: TfrmImendesOpcoesRecriacaoConsulta;

implementation

{$R *.dfm}

{ TfrmImendesOpcoesRecriacaoConsulta }

procedure TfrmImendesOpcoesRecriacaoConsulta.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
end;

class function TfrmImendesOpcoesRecriacaoConsulta.fRetImendesOpcoesRecriacaoConsulta(ArquivoBase: String): TTipoGeracao;
begin
  pCriarFormularios(TfrmImendesOpcoesRecriacaoConsulta, frmImendesOpcoesRecriacaoConsulta);
  Try
    frmImendesOpcoesRecriacaoConsulta.blnConfirma := False;
    frmImendesOpcoesRecriacaoConsulta.lblArqBas.Caption :=  'Consulta Selecionada: ' + ArquivoBase;
    frmImendesOpcoesRecriacaoConsulta.ShowModal;
    Result := ttgIndefinido;
    If frmImendesOpcoesRecriacaoConsulta.blnConfirma Then
    Begin
      case frmImendesOpcoesRecriacaoConsulta.rdgOpcao.ItemIndex of
        0 : Result := ttgItensComRetParcial;
        1 : Result := ttgItensComDivergencia;
        2 : Result := ttgNaoEncontradoImendes;
        3 : Result := ttgCodBarrasInvalido;
        4 : Result := ttgTodos;
      end;
    End;

  Finally
    FreeAndNil(frmImendesOpcoesRecriacaoConsulta)
  End;
end;

end.
