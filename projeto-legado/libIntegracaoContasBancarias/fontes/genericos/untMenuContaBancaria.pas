unit untMenuContaBancaria;

interface

Uses
  Vcl.Themes, Vcl.Styles, Vcl.SysStyles,
  System.Classes, System.SysUtils, System.StrUtils, System.Math,
  Vcl.Forms, System.DateUtils, Vcl.StdCtrls, System.Variants,
  Vcl.Controls, Winapi.Windows, Winapi.Messages, Data.DB,

  Uni, UniClientDataset, cxProgressBar, EditFocus, maskEditFocus,
  IdHashMessageDigest, frxClass,

  untTLibContasBancariasFuncoes,ContasBancarias.View.ImportacaoExtrato,
  untExtratoBaseClass;


  function MenuImportarContasBancarias: String;
  procedure MenuConsultaSaldoContasBancarias;


implementation

procedure MenuConsultaSaldoContasBancarias;
  Var
    LfrmImportacaoExtrato : TfrmImportacaoExtrato;
Begin
  Try
    TLibContaBancariaFuncoes.pCriarFormularios(TfrmImportacaoExtrato,LfrmImportacaoExtrato);
    LfrmImportacaoExtrato.ConsultaSaldo := True;
    LfrmImportacaoExtrato.ShowModal;
  Finally
    FreeAndNil(LfrmImportacaoExtrato);
  End;
End;


function MenuImportarContasBancarias: String;
  Var
    LfrmImportacaoExtrato : TfrmImportacaoExtrato;
Begin
  Try
    TLibContaBancariaFuncoes.pCriarFormularios(TfrmImportacaoExtrato,LfrmImportacaoExtrato);
    LfrmImportacaoExtrato.ConsultaSaldo := False;
    LfrmImportacaoExtrato.ShowModal;
    Result := LfrmImportacaoExtrato.JSONDadosExtratoBancario;
  Finally
    FreeAndNil(LfrmImportacaoExtrato);
  End;
End;


end.
